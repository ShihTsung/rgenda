"""
排班問題的純資料表達。

設計原則：
- frozen dataclass、不可變、可序列化（pickle / json / dict）
- 不依賴 Django ORM — 之後 CP-SAT model 只吃 SchedulingProblem，
  方便在 unit test 裡用 dummy 資料跑、不需要起 DB
- 單位約定：
    shift_type:
        0=白班 / 1=小夜 / 2=大夜 / 3=公假 / 4=oncall /
        5=有薪假 / 6=無薪假 / 7=行政班
    law_rule (Department):
        0=一般工時(7休2) / 1=雙週變形(14休4) /
        2=四週變形(28休8) / 3=八週變形(56休16)
    schedule_rule (Department):
        0=單週同班種 / 1=單月同班種 / 2=三月同班種
    is_holiday: H_Calendar.attribute[str(dept_id)] == '2'
"""
from dataclasses import dataclass, field
from datetime import date
from typing import Optional


@dataclass(frozen=True)
class StaffInput:
    """單一員工的靜態資料 + 本月排班所需配額。"""
    id: int
    username: str
    full_name: str
    level: int                  # 1-5（部門內職級）
    type_of_user: int           # 0-5（正職/資深/行政/新進/兼職/實習）
    pregnant: bool
    can_be_scheduled: bool

    # 本月配額（來自 user.holiday_rest_num - holiday_rest_num_used 等）
    holiday_rest_quota: int = 0


@dataclass(frozen=True)
class DayInput:
    """單一天 + 本部門對該天的紅日標記。"""
    the_date: date
    is_holiday: bool            # H_Calendar.attribute[dept_id] == '2'
    is_red_day: bool            # H_Calendar.red_day（國家紅日，跨部門）


@dataclass(frozen=True)
class DemandInput:
    """某天 + 某班別 + 某層級的人力需求量。

    DB 端 DemandOfStation 是「部門全月的日均需求」（config1=平日, config2=假日），
    loader 會展開到每一天的 DemandInput。
    """
    the_date: date
    shift_id: int               # FK 到 Shift（給 solver 把人指到正確班別用）
    shift_type: int             # 0=白班 / 1=小夜 / 2=大夜 / 7=行政
    station_id: int             # FK 到 Station
    level: int                  # 該需求要的職級
    count: int                  # 需要幾位


@dataclass(frozen=True)
class CommitmentInput:
    """員工已預先確定的某天動作（預排假 / 預排班 / 公假）。

    這些是「硬約束」— solver 必須遵守。
    """
    user_id: int
    the_date: date
    kind: str                   # 'rest'(Reservation) | 'work'(PromiseShift)
    shift_type: Optional[int] = None  # 僅 kind='work' 適用


@dataclass(frozen=True)
class SchedulingProblem:
    """整個排班問題的不可變快照。

    輸入 → CP-SAT model；之後 solver 輸出一份 schedule（user_id × date → shift_id），
    再由另一個 module 寫回 PreResult。
    """
    department_id: int
    department_name: str
    year: int
    month: int

    law_rule: int               # 0=7天循環 / 1=14天循環 / 2=三月循環
    schedule_rule: int          # 0=每週同班 / 1=每月同班 / 2=三月同班

    days: list[DayInput]
    staffs: list[StaffInput]
    demands: list[DemandInput]
    commitments: list[CommitmentInput]

    def summary(self) -> str:
        """人類可讀的摘要，cli 用。"""
        n_days = len(self.days)
        n_holidays = sum(1 for d in self.days if d.is_holiday)
        n_total_demand = sum(d.count for d in self.demands)
        return (
            f"Department: {self.department_name} (id={self.department_id})\n"
            f"  Period:        {self.year}-{self.month:02d}  "
            f"({n_days} 天，其中 {n_holidays} 假日)\n"
            f"  law_rule:      {self.law_rule}  "
            f"(0=週/1=雙週/2=三月)\n"
            f"  schedule_rule: {self.schedule_rule}  "
            f"(0=每週同班/1=每月同班/2=三月同班)\n"
            f"  Staffs:        {len(self.staffs)} 人\n"
            f"  Demands:       {len(self.demands)} 條，總需求 {n_total_demand} 人次\n"
            f"  Commitments:   {len(self.commitments)} 條"
        )
