"""
CP-SAT solver wrapper。

把 SchedulingProblem 餵進 ScheduleModel、求解、回傳 Solution。
"""
import time
from typing import Optional

from ortools.sat.python import cp_model

from .data import SchedulingProblem, Solution
from .model import ScheduleModel


def solve(
    problem: SchedulingProblem,
    *,
    time_limit_seconds: float = 30.0,
    log_search: bool = False,
) -> Solution:
    """求解；回傳 Solution，無論成功/失敗都會帶 status 跟耗時。"""
    sm = ScheduleModel(problem)
    solver = cp_model.CpSolver()
    solver.parameters.max_time_in_seconds = time_limit_seconds
    if log_search:
        solver.parameters.log_search_progress = True

    t0 = time.perf_counter()
    status = solver.Solve(sm.model)
    elapsed_ms = int((time.perf_counter() - t0) * 1000)

    feasible = status in (cp_model.OPTIMAL, cp_model.FEASIBLE)
    return Solution(
        status=solver.StatusName(status),
        walltime_ms=elapsed_ms,
        objective=_safe_objective(solver, sm.model) if feasible else None,
        assignments=sm.extract_assignments(solver) if feasible else [],
    )


def _safe_objective(
    solver: cp_model.CpSolver, model: cp_model.CpModel
) -> Optional[float]:
    """目前 step 2 model 沒有 objective；step 3+ 才會加。"""
    try:
        if model.Proto().HasField('objective'):
            return solver.ObjectiveValue()
    except Exception:
        pass
    return None
