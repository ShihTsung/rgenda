"""
SchedulingProblem → CP-SAT cp_model.CpModel。

Step 2 範圍（最小可解）：
- 變數：x[user, date, shift] ∈ {0, 1}
- 約束 1：每位員工每天恰好 1 個 shift（含 leave 類）
- 約束 2：每筆 demand 的人數 + 職級嚴格滿足
- 約束 3：commitments（預排假/班）為硬約束

step 3 將補：連續工作上限、兩班間隔 11h、孕婦不夜、shift_type cycle 等。
"""
from collections import defaultdict
from typing import Optional

from ortools.sat.python import cp_model

from .data import (
    Assignment,
    SchedulingProblem,
    WORKING_SHIFT_TYPES,
)


class ScheduleModel:
    """包住 cp_model + 變數索引，方便求解後抽出 Assignment list。"""

    def __init__(self, problem: SchedulingProblem):
        self.problem = problem
        self.model = cp_model.CpModel()
        self.x: dict[tuple[int, object, int], cp_model.IntVar] = {}

        # 預先建好幾個常用 index
        self._shifts_by_id = {s.id: s for s in problem.shifts}
        self._working_shift_ids = {
            s.id for s in problem.shifts if s.shift_type in WORKING_SHIFT_TYPES
        }
        self._shift_ids_by_type: dict[int, list[int]] = defaultdict(list)
        for s in problem.shifts:
            self._shift_ids_by_type[s.shift_type].append(s.id)

        self._build_variables()
        self._add_one_shift_per_day()
        self._add_demand_constraints()
        self._add_commitment_constraints()

    # ------------------------------------------------------------ variables

    def _build_variables(self) -> None:
        """每位員工 × 每天 × 每個 shift = 一個 BoolVar。"""
        for u in self.problem.staffs:
            for d in self.problem.days:
                for s in self.problem.shifts:
                    name = f'x_u{u.id}_d{d.the_date.day:02d}_s{s.id}'
                    self.x[u.id, d.the_date, s.id] = self.model.NewBoolVar(name)

    # ------------------------------------------------------------ constraints

    def _add_one_shift_per_day(self) -> None:
        """每位員工每天恰好一個 shift。"""
        for u in self.problem.staffs:
            for d in self.problem.days:
                self.model.AddExactlyOne(
                    self.x[u.id, d.the_date, s.id]
                    for s in self.problem.shifts
                )

    def _add_demand_constraints(self) -> None:
        """每筆 demand：那天那個 shift_id，恰好 count 位該 level 的員工。

        嚴格 ==：避免不該排該班的 level 跑進去。
        """
        eligible_by_level: dict[int, list[int]] = defaultdict(list)
        for u in self.problem.staffs:
            eligible_by_level[u.level].append(u.id)

        # 同一 (date, shift_id) 可能有多筆 demand（不同 level），但合計
        # 也代表「該 shift_id 那天該排這麼多人」— 之後若需求同班別不分層
        # 也想限制總人數，可以另加約束。
        for dem in self.problem.demands:
            users_of_level = eligible_by_level.get(dem.level, [])
            self.model.Add(
                sum(self.x[uid, dem.the_date, dem.shift_id]
                    for uid in users_of_level)
                == dem.count
            )

    def _add_commitment_constraints(self) -> None:
        """已預排（Reservation / PromiseShift）為硬約束。"""
        for c in self.problem.commitments:
            if c.kind == 'rest':
                # 必須非「上班類」shift（含公假）— 換言之上班類的全部 = 0
                for s_id in self._working_shift_ids:
                    self.model.Add(self.x[c.user_id, c.the_date, s_id] == 0)
            elif c.kind == 'work' and c.shift_type is not None:
                # 必須上指定 shift_type 中某一個 shift
                matching = self._shift_ids_by_type.get(c.shift_type, [])
                if matching:
                    self.model.Add(
                        sum(self.x[c.user_id, c.the_date, s_id]
                            for s_id in matching)
                        == 1
                    )

    # ------------------------------------------------------------ result

    def extract_assignments(
        self, solver: cp_model.CpSolver
    ) -> list[Assignment]:
        """從 solver 結果抽出 (user, date, shift) 指派 list。"""
        out = []
        for (u_id, the_date, s_id), var in self.x.items():
            if solver.Value(var) == 1:
                out.append(Assignment(
                    user_id=u_id, the_date=the_date, shift_id=s_id,
                ))
        return out
