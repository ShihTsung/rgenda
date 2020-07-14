# models
from shift.models import *
from result.models import *
from demand.models import *
from date.models import *
from reservation.models import *
from station.models import *
from account.models import CustomUser, Department
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


class Day:
    def __init__(self, date, attr):
        self.date = date
        self.is_weekend = self.date.weekday() in [5, 6]
        self.is_holiday = True if attr == 'holiday' else False


def get_dates(begin):
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

    next_month = str(next_month).zfill(2)
    start = str(year) + '-' + str(next_month) + '-01'
    w = datetime.date.fromisoformat(
        start).weekday()  # 0 => Monday, 6 => Sunday

    if begin == 0:
        previous = datetime.date.fromisoformat(
            start) - datetime.timedelta(days=w)

    else:
        previous = datetime.date.fromisoformat(
            start) - datetime.timedelta(days=w+1)

    end = (previous + datetime.timedelta(days=41)).strftime('%Y-%m-%d')
    previous = previous.strftime('%Y-%m-%d')
    days = Oneday.objects.filter(date__range=[previous, end])

    result = {}
    for day in days:
        result[day.date.strftime('%Y-%m-%d')] = Day(day.date, day.attribute)

    return result
