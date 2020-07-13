# python modules
import datetime
import random
from numpy.random import choice
from mainpage.functions import *
from mainpage.get_data import *
from django.core.management.base import BaseCommand, CommandError
from account.models import Department
from calendar import monthrange


class Staff:

    def __init__(self, name, workday, holiday_rest, scheduled_rest=[],
                 scheduled_work=[], ensure_rest=[], continuous=0):
        """
        :param name: 名稱
        :param workday: 工作天數
        :param holiday_rest: 可休假日天數
        :param scheduled_rest: 預排假
        :param scheduled_work: 預排班/公假
        :param ensure_rest: 保證價
        :param continuous: 連續工作天數
        """
        self.name = name
        self.workday = workday
        self.holiday_rest = holiday_rest
        self.scheduled_rest = scheduled_rest
        self.scheduled_work = scheduled_work
        self.ensure_rest = ensure_rest
        self.continuous = continuous

    def __str__(self):
        return self.name


class Demand:

    def __init__(self, day, staff_num, is_weekday=True):
        """
        :param day: 日期
        :param staff_num: 需求人數
        :param is_weekday: True=平日, False=假日
        """
        self.day = day
        self.staff_num = staff_num
        self.is_weekday = is_weekday

    def __str__(self):
        return self.day

    def __repr__(self):
        return self.day + ':::' + str(self.staff_num)


def get_info_of_month():
    now = datetime.datetime.today().weekday()  # 0 for monday, 6 for sunday
    begin = 0
    days = get_dates(begin)
    workdays = 0
    holidays = 0
    for i in days.keys():
        if days[i].is_holiday:
            holidays += 1
        else:
            workdays += 1

    return (workdays, holidays)


def devideDays(days):
    past = []
    present = []
    future = []
    now = datetime.datetime.now()
    year = now.year
    next_month = now.month + 1
    if next_month > 12:
        next_month = 1
        year += 1
    month_range = monthrange(year, next_month)
    start = datetime.date(year, next_month, 1)
    end = datetime.date(year, next_month, month_range[1])

    for k, v in days.items():
        if v.date < start:
            past.append(k)
        elif v.date > end:
            future.append(k)
        else:
            present.append(k)
    return past, present, future


def devidePeriod(days):
    result = []
    day_list = list(days.keys())
    for i in range(3):
        result.append(day_list[i*14: i*14+14])
    return result


class Command(BaseCommand):
    help = 'calculate the schedule'

    def handle(self, *args, **options):
        result = {}
        department = Department.objects.first()  # 指定部門
        demand_list = get_demands(department)  # 抓出需求
        shift_list = get_shifts(department)  # 抓出本部門的所有班別
        user_list = get_users(department)   # 抓出所有使用者
        begin = department.begin_of_week
        days = get_dates(begin)             # 抓出要排班的所有日期
        past, curr, future = devideDays(days)  # 標記日期
        # print('past', past) 目標月份的前個月
        # print('curr', curr)   目標月份
        # print('future', future)   目標的未來月份

        # 總共有多少需求
        periods = devidePeriod(days)

        # 對三個週期遍歷
        for period in periods:
            total_whole_period = {'1': [], '2': [], '3': [], '4': []}
            for i in period:
                # 算總需求
                total_per_day = {'1': 0, '2': 0, '3': 0, '4': 0}
                for d in demand_list:
                    if days[i].is_holiday:
                        total_per_day[str(d.level)] += d.holiday
                    else:
                        total_per_day[str(d.level)] += d.weekday
                for l in total_per_day.keys():
                    total_whole_period[l].append(total_per_day[l])

            for level in range(1, 5):
                demands = []
                for i in range(len(period)):
                    day_obj = days[period[i]]
                    staff_num = total_whole_period[str(level)][i]
                    is_weekday = not day_obj.is_holiday
                    demand = Demand(period[i], staff_num, is_weekday)
                    demands.append(demand)

                # 排班人員名單
                staffs = []
                for staff in user_list:
                    if staff.level == level:
                        s = Staff(staff.username, 10, 20)
                        staffs.append(s)
                self.stdout.write(self.style.SUCCESS(staffs))
                # self.stdout.write(self.style.SUCCESS((workday_num, holiday_num)))
                test_result = None
                count = 0

                while test_result is None and count < 100:
                    if len(staffs) == 0:
                        break
                    else:
                        test_result = calculate(staffs, demands)
                        count += 1

                if test_result:
                    # print('DEMAND')
                    # print('D', [d.day for d in demands])
                    # print('W', [1 if d.is_weekday else 0 for d in demands])

                    # print('RESULT')
                    # for s_name, val in test_result.items():
                    #     print(s_name, val, '| on duty:', sum(val),
                    #           '| holiday rest:',
                    #           sum([1 if (val[i] == 0 and demands[i].is_weekday is False) else 0 for i in range(len(val))]))
                    assign_result = assignment(test_result, department)
                    add_rest = rest_assignment(assign_result)
                    for s_name, val in add_rest.items():
                        # print(s_name, val)
                        if s_name in result.keys():
                            result[s_name] += val
                        else:
                            result[s_name] = val
                else:
                    print('Fail')
        print(result)
