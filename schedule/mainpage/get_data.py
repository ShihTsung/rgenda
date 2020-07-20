# models
from datetime import timedelta
from shift.models import *
from result.models import *
from demand.models import *
from date.models import *
from reservation.models import *
from station.models import *
from account.models import CustomUser, Department
import datetime


# 部門內的需求
def get_demands(department):
    """
    : params department: 部門物件
    return: 部門內所有需求
    """
    demands = DemandOfStation.objects.all()
    demand_list = []
    for d in demands:
        if d.shift.department == department:
            demand_list.append(d)
    return demand_list


# 部門內的班別
def get_shifts(department):
    """
    : params department: 部門物件
    return: 部門內所有班別
    """
    shifts = Shift.objects.filter(department=department)
    return list(shifts)


def get_users(department):
    """
    : params department: 部門物件
    return: 部門內所有可排班的使用者
    """
    users = CustomUser.objects.filter(
        can_be_scheduled=True,
        department=department)
    user_list = users[::1]

    return user_list


class Day:
    def __init__(self, date, attr):
        self.date = date
        self.is_weekday = False if attr == 'holiday' else True


def cycle_analysis(department, input_date):
    """
    :param department: 科別/部門 物件
    :param input_date: datetime.date() 物件

    """
    start_weekday = department.date_start.weekday()
    if department.begin_of_week == 0:
        pass
    date_start = department.date_start
    rule = department.law_rule
    date_diff = (input_date - date_start).days
    cycle_no = date_diff // (7 * 2 ** 2)
    day_no = date_diff % (7 * 2 ** 2)

    return (cycle_no, day_no)


def get_dates(department):
    """
    回傳字典
    key: 每天的字串
    value: 每天的 date物件
    """
    now = datetime.datetime.today().date()
    results = Result.objects.filter(date__gt=now)
    if not results:
        last_day = department.date_start
    else:
        dates = [r.date for r in results]
        last_day = max(dates)

    new_start = last_day + timedelta(days=1)

    days = Oneday.objects.filter(
        date__range=(new_start,
                     new_start+timedelta(days=41))
    )

    return [Day(d.date, d.attribute) for d in days]  # 回傳42天
