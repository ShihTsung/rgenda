# models
from shift.models import *
from result.models import *
from demand.models import *
from date.models import *
from reservation.models import *
from station.models import *
from account.models import CustomUser, Department
from calendar import monthrange

import datetime


def get_demands(department):
    """
    回傳清單，限制同部門的
    """
    demands = DemandOfStation.objects.all()
    demand_list = []
    for d in demands:
        if d.shift.station.department == department:
            demand_list.append(d)
    return demand_list


def get_shifts(department):
    shift_list = []
    shifts = Shift.objects.all()
    for s in shifts:
        if s.station.department == department:
            shift_list.append(s)
    return shift_list


def get_users(department):
    """
    回傳清單，清單內是每個使用者的物件
    """
    users = CustomUser.objects.filter(
        can_be_scheduled=True,
        department=department)
    user_list = users[::1]

    return user_list


def get_dates():
    """
    回傳字典
    key: 每天的字串
    value: 每天的 date物件
    """
    now = datetime.datetime.now()
    year = now.year
    next_month = now.month + 1
    if next_month > 12:
        next_month = 1
        year += 1
    day_nums = monthrange(now.year, next_month)[1]
    start = str(year) + '-' + str(next_month) + '-01'
    end = str(year) + '-' + str(next_month) + '-' + str(day_nums)
    days = Oneday.objects.filter(date__range=[start, end])
    days = {str(day.date): day for day in days}

    return days
