"""
DB → SchedulingProblem 的 loader。

唯一的 Django ORM 接觸點。CP-SAT model / solver 之後只吃 SchedulingProblem，
不會再碰 ORM。
"""
from calendar import monthrange
from datetime import date

from .data import (
    CommitmentInput,
    DayInput,
    DemandInput,
    SchedulingProblem,
    ShiftInput,
    StaffInput,
)


def load_problem(department_id: int, year: int, month: int) -> SchedulingProblem:
    """從現有 Django models 組出排班問題快照。"""
    # 在 function 內 import 避免 app loading 順序問題
    from account.models import CustomUser, Department
    from date.models import H_Calendar
    from demand.models import DemandOfStation
    from reservation.models import PromiseShift, Reservation

    department = Department.objects.get(id=department_id)

    days = _load_days(department_id, year, month)
    staffs = _load_staffs(department_id)
    shifts = _load_shifts(department_id)
    demands = _load_demands(department_id, days)
    commitments = _load_commitments(
        {s.id for s in staffs}, year, month, Reservation, PromiseShift
    )

    return SchedulingProblem(
        department_id=department.id,
        department_name=department.name,
        year=year,
        month=month,
        law_rule=department.law_rule,
        schedule_rule=department.schedule_rule,
        days=days,
        staffs=staffs,
        shifts=shifts,
        demands=demands,
        commitments=commitments,
    )


def _load_days(department_id: int, year: int, month: int) -> list[DayInput]:
    from date.models import H_Calendar

    n_days = monthrange(year, month)[1]
    cal_qs = H_Calendar.objects.filter(
        date__year=year, date__month=month
    ).order_by('date')
    cal_map = {c.date: c for c in cal_qs}

    out = []
    dept_key = str(department_id)
    for d in range(1, n_days + 1):
        the_date = date(year, month, d)
        cal = cal_map.get(the_date)
        is_holiday = False
        is_red_day = False
        if cal:
            is_red_day = bool(cal.red_day)
            if isinstance(cal.attribute, dict):
                is_holiday = cal.attribute.get(dept_key) == '2'
        out.append(DayInput(
            the_date=the_date,
            is_holiday=is_holiday,
            is_red_day=is_red_day,
        ))
    return out


def _load_staffs(department_id: int) -> list[StaffInput]:
    from account.models import CustomUser

    qs = (CustomUser.objects
          .filter(department_id=department_id, can_be_scheduled=True)
          .order_by('id'))
    return [
        StaffInput(
            id=u.id,
            username=u.username,
            full_name=u.full_name or u.username,
            level=u.level or 1,
            type_of_user=u.type_of_user or 0,
            pregnant=bool(u.pregnant),
            can_be_scheduled=bool(u.can_be_scheduled),
            holiday_rest_quota=(
                (u.holiday_rest_num or 0) - (u.holiday_rest_num_used or 0)
            ),
        )
        for u in qs
    ]


def _load_shifts(department_id: int) -> list[ShiftInput]:
    from shift.models import Shift

    qs = Shift.objects.filter(department_id=department_id).order_by('id')
    return [
        ShiftInput(
            id=s.id,
            name=s.name or '',
            shift_type=s.shift_type or 0,
            work_hours=s.work_hours or 0.0,
            start_time=s.start_time,
            end_time=s.end_time,
        )
        for s in qs
    ]


def _load_demands(department_id: int, days: list[DayInput]) -> list[DemandInput]:
    """DemandOfStation 是部門全月的日均需求；展開成每天每條。

    config1 = 平日需求人數、config2 = 假日需求人數。
    """
    from demand.models import DemandOfStation

    qs = (DemandOfStation.objects
          .select_related('shift', 'station')
          .filter(shift__department_id=department_id))

    out = []
    for d in qs:
        for day in days:
            count = d.config2 if day.is_holiday else d.config1
            if count == 0:
                continue
            out.append(DemandInput(
                the_date=day.the_date,
                shift_id=d.shift_id,
                shift_type=d.shift.shift_type,
                station_id=d.station_id,
                level=d.level,
                count=count,
            ))
    return out


def _load_commitments(
    user_ids: set[int],
    year: int,
    month: int,
    Reservation,
    PromiseShift,
) -> list[CommitmentInput]:
    out = []
    rest_qs = Reservation.objects.filter(
        user_id__in=user_ids, date__year=year, date__month=month,
    )
    for r in rest_qs:
        out.append(CommitmentInput(
            user_id=r.user_id, the_date=r.date, kind='rest',
        ))
    work_qs = PromiseShift.objects.filter(
        user_id__in=user_ids, date__year=year, date__month=month,
    )
    for w in work_qs:
        out.append(CommitmentInput(
            user_id=w.user_id,
            the_date=w.date,
            kind='work',
            shift_type=w.shift_type,
        ))
    return out
