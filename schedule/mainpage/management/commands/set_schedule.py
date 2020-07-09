# python modules
import datetime
import collections
import copy
import random
from numpy.random import choice
from mainpage.functions import *
from mainpage.get_data import *
from django.core.management.base import BaseCommand, CommandError
from account.models import Department

random.randint


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
    days = get_dates()
    workdays = 0
    holidays = 0
    for i in days.keys():
        if days[i].attribute == 'workday':
            workdays += 1
        elif days[i].attribute == 'holiday':
            holidays += 1
        else:
            continue

    return (workdays, holidays)


def assignment(attendance_matrix, department):
    if len(attendance_matrix) == 0:
        return None
    user_nums = len(attendance_matrix)
    users = attendance_matrix.keys()
    demand_pool = {'白班': [], '小夜': [], '大夜': []}
    demand_list = get_demands(department)

    for d in demand_list:
        demand_pool[d.shift.shift_type] += [d.id] * d.weekday
    w, n, g = len(demand_pool['白班']), len(
        demand_pool['小夜']), len(demand_pool['大夜'])
    total_weight = w + n + g
    weight_w, weight_n, weight_g = w/total_weight, n/total_weight, g/total_weight

    type_result = choice(['白班', '小夜', '大夜'], user_nums,
                         p=[weight_w, weight_n, weight_g])
    result = []
    for i in type_result:
        if demand_pool[i] == []:
            result.append('')
            continue
        select = random.choice(demand_pool[i])
        result.append(select)
        demand_pool[i].remove(select)
    for i, (k, v) in enumerate(attendance_matrix.items()):
        for idx in range(len(v)):
            if v[idx] == 1:
                v[idx] = result[i]
    return attendance_matrix


class Command(BaseCommand):
    help = 'calculate the schedule'

    def handle(self, *args, **options):
        # 指定部門
        department = Department.objects.first()
        # 抓出需求
        demand_list = get_demands(department)
        # 抓出本部門的所有班別
        shift_list = get_shifts(department)
        # 抓出所有使用者
        user_list = get_users(department)
        # 抓出要排班的所有日期
        days = get_dates()
        # 結果總表
        total_result = dict()

        demand_whole_month = []
        total_whole_month = {'1': [], '2': [], '3': [], '4': []}  # 總共有多少需求

        # 算總需求
        for i in days.keys():
            total_per_day = {'1': 0, '2': 0, '3': 0, '4': 0}
            for d in demand_list:
                if days[i].attribute == 'workday':
                    total_per_day[str(d.level)] += d.weekday
                if days[i].attribute == 'holiday':
                    total_per_day[str(d.level)] += d.holiday
            for l in total_per_day.keys():
                total_whole_month[l].append(total_per_day[l])

        workday_num, holiday_num = get_info_of_month()

        for level in range(1, 5):
            demands = []
            for i, (k, v) in enumerate(days.items()):
                is_weekday = True if v.attribute == 'workday' else False
                staff_num = total_whole_month[str(level)][i]
                demand = Demand(k, staff_num, is_weekday)
                demands.append(demand)

            # 排班人員名單
            staffs = []
            for staff in user_list:
                if staff.level == level:
                    s = Staff(staff.username, 27, 10)
                    staffs.append(s)
            self.stdout.write(self.style.SUCCESS(staffs))
            self.stdout.write(self.style.SUCCESS((workday_num, holiday_num)))
            test_result = None
            count = 0

            while test_result is None and count < 100:
                if len(staffs) == 0:
                    break
                else:
                    test_result = calculate(staffs, demands)
                    count += 1
            
            if test_result:
                print('DEMAND')
                print('D', [d.day for d in demands])
                print('W', [1 if d.is_weekday else 0 for d in demands])
                assign_result = assignment(test_result, department)

                print('RESULT')
                for s_name, val in assign_result.items():
                    print(s_name, val, '| on duty:', sum(val),
                          '| holiday rest:',
                          sum([1 if (val[i] == 0 and demands[i].is_weekday is False) else 0 for i in range(len(val))]))
            else:
                print('Fail')
