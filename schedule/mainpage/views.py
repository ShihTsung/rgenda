# python modules
import datetime
import collections
import copy
import random
from numpy.random import choice
from .functions import *
from .get_data import *


# django modules
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from scripts.get_date_range import *

# models
from account.models import CustomUser, Department
from shift.models import *
from result.models import Result, PreResult, TimeAdjustment
from demand.models import *
from date.models import *
from reservation.models import *
from station.models import *
from calendar import monthrange


def manager_mainpage_data(request):
    department = request.user.department
    today = datetime.datetime.now().date()
    start = datetime.date(today.year, today.month, 1)
    day = monthrange(today.year, today.month)[1]
    end = datetime.date(today.year, today.month, day)
    legal_workhours = 0
    users = CustomUser.objects.filter(
        department=department,
        can_be_scheduled=True
    )
    user_set = set()
    res = {
        'today': today,
        'start': start,
        'end': end
    }
    results = Result.objects.filter(
        user__in=users,
        date__range=[start, end]
    ).prefetch_related(
        'user'
    ).prefetch_related(
        'shift'
    ).prefetch_related(
        'station'
    )
    adjustments = TimeAdjustment.objects.filter(
        user__in=users,
        date__range=[start, end]
    )
    total_workhours = 0
    official_rest = 0

    workhours_til_today = 0
    official_rest_til_today = 0

    for result in results:
        if result.user not in user_set:
            user_set.add(result.user)
        total_workhours += result.shift.work_hours

        if result.shift.shift_type in [0, 1, 2, 3, 7]:
            legal_workhours += 8

        if result.date <= today:
            workhours_til_today += result.shift.work_hours

        if result.shift.shift_type == 3:
            official_rest += result.shift.work_hours
            if result.date <= today:
                official_rest_til_today += result.shift.work_hours
    adj_nums = [0, 0, 0, 0, 0, 0, 0]
    adj_nums_minus = [0, 0, 0, 0, 0, 0, 0]
    adj_nums_til_today = [0, 0, 0, 0, 0, 0, 0]
    minus_adj_til_today = [0, 0, 0, 0, 0, 0, 0]
    self_rest = 0
    for adj in adjustments:
        if adj.adjustment_type == 0:
            adj_nums[adj.adjustment_item] += adj.hours
            if adj.date <= today:
                adj_nums_til_today[adj.adjustment_item] += adj.hours
        else:
            adj_nums_minus[adj.adjustment_item] += adj.hours
            if adj.date <= today:
                minus_adj_til_today[adj.adjustment_item] += adj.hours
            if adj.adjustment_item == 6:
                self_rest += adj.hours
    user_len = len(user_set)
    if user_len == 0:
        user_len = 1
    avg = total_workhours/user_len
    avg_til_today = workhours_til_today/user_len
    avg_overtime = sum(adj_nums[:3])/user_len
    avg_minustime = adj_nums_minus[5]/user_len
    avg_overtime_til_today = sum(adj_nums_til_today[:3])/user_len
    avg_minus_til_today = minus_adj_til_today[5]/user_len
    oncall_num = adj_nums[4]/user_len
    diff = (total_workhours +
            sum(adj_nums[:3]) - adj_nums[5] +
            adj_nums[4] - legal_workhours) / user_len

    users_nums = [0, 0, 0, 0, 0, 0]
    for user in users:
        users_nums[user.type_of_user] += 1

    types = {
        '正職': users_nums[0],
        '資深正職': users_nums[1],
        '行政職': users_nums[2],
        '小計1': sum(users_nums[:3]),
        '新進人員': users_nums[3],
        '兼職人員': users_nums[4],
        '實習生': users_nums[5],
        '小計2': sum(users_nums[3:]),
    }
    res['總時數'] = round(avg, 2)   # 總時數
    res['類別統計'] = types
    res['加班'] = round(avg_overtime, 2)  # 加班
    res['減班'] = round(avg_minustime, 2)  # 減班
    res['oncall'] = round(oncall_num, 2)
    res['應上工時'] = round(legal_workhours, 2)
    res['差額'] = round(diff, 2)
    res['公假'] = official_rest
    onboard = (avg_til_today + official_rest_til_today +
               avg_overtime_til_today + avg_minus_til_today)
    res['bars'] = [
        round(avg, 2),
        round(onboard, 2),
        round(official_rest_til_today/user_len, 2),
        round(self_rest/user_len, 2)
    ]
    return res


# 首頁，分為使用者與管理者兩種
@login_required
def index(request):

    start, end = date_range(0, 3)
    data = manager_mainpage_data(request)
    context = {
        'LANG': request.LANGUAGE_CODE,
        'start': start,
        'end': end,
        'results': 'results',
        'default': start,
        'department': request.user.department,
        'bars': data['bars'],
        'total_avg': data['總時數'],
        'types': data['類別統計'],
        'workhours': data['應上工時'],
        'oncall': data['oncall'],
        'overtime': data['加班'],
        'minustime': data['減班'],
        'diff': data['差額'],
        'firstday': request.user.department.start_of_week
    }
    if request.user.role in ['admin', 'manager']:
        return render(request, 'mainpage/manager_index.html', context)
    else:
        return render(request, 'mainpage/employee_index.html', context)


# 處理  404
def handler404(request, exception, template_name="404.html"):
    response = render(request, template_name)
    response.status_code = 404
    return response


# 處理500
def handler500(request, *args, **argv):
    response = render(request, '500.html', {})
    response.status_code = 500
    return response


class Staff:

    def __init__(self, name, workday, holiday_rest, scheduled_rest=[], scheduled_work=[], ensure_rest=[], continuous=0):
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


def schedule_test(request):

    def zero():
        return 0
    demand_whole_month = []
    total_whole_month = {'1': [], '2': [], '3': [], '4': []}
    for i in days.keys():
        days[i].type_demand = collections.defaultdict(zero)
        # 產生當天需求
        demand_pool = {'白班': {'1': {}, '2': {}, '3': {}, '4': {}},
                       '小夜': {'1': {}, '2': {}, '3': {}, '4': {}},
                       '大夜': {'1': {}, '2': {}, '3': {}, '4': {}}
                       }
        choosable = {'1': [], '2': [], '3': [], '4': []}
        total = {'1': 0, '2': 0, '3': 0, '4': 0}
        total_by_type = {'白班': 0, '小夜': 0, '大夜': 0, }
        for d in demand_list:
            idx = str(d.shift.name)
            days[i].type_demand[idx] = {'1': 0, '2': 0, '3': 0, '4': 0}
            if days[i].attribute == 'workday':
                days[i].type_demand[idx][str(d.level)] += d.weekday
                total[str(d.level)] += d.weekday
            else:
                days[i].type_demand[idx][str(d.level)] += d.holiday
                total[str(d.level)] += d.holiday
            demand_pool[d.shift.shift_type][str(
                d.level)][idx] = days[i].type_demand[idx][str(d.level)]
            choosable[str(d.level)].append(idx)
        demand_whole_month.append(demand_pool)
        for key, val in total.items():
            total_whole_month[key].append(val)
    for key, val in total_whole_month.items():
        print(key, val)

    return redirect("/")


# 要在確定班別後才執行
def count_holiday_rest(user, shift, day):
    """
    如果是休假，又是假日休，要扣掉假日休額度
    user=> 使用者
    shift=> 班別
    day=> 日期
    """
    if day.attribute == 'holiday':
        if shift.shift_type in ['休假', ]:
            user.holiday_rest_num_used += 1
            user.save()

# 指派例假或休息日


def rest_assignment(req):
    """
    req => Dict{'name': List[0 or id of shift] }
    return req
    """
    for key, val in req.items():
        x, y = 0.5, 0.5
        for i in range(len(val)):
            if val[i] == 0:
                v = choice(2, 1, p=[x, y])
                if v == 1:
                    val[i] = 'H'
                    x *= 10
                else:
                    val[i] = 'R'
                    y *= 10
                x, y = x/(x+y), y/(x+y)

    """把第一個假日設為例假"""
    # for loop rows
    for key, val in req.items():
        # for loop items of row
        for i in range(len(val)):
            if val[i] == 'H':
                break
            if val[i] == 'R':
                for j in range(i+1, len(val)):
                    if val[j] == 'H':
                        val[i], val[j] = val[j], val[i]
                        break
                break
    return req


def assignment(attendance_matrix, department):
    """
    attendance_matrix => Dict{'name':List[int]} 每個人的班表
    department => Department object 部門
    return Dict{'name': List[int or id of shift]}
    """
    user_nums = len(attendance_matrix)
    users = attendance_matrix.keys()
    demand_pool = {'白班': [], '小夜': [], '大夜': []}
    demand_list = get_demands(request)

    for d in demand_list:
        demand_pool[d.shift.shift_type] += [d.id] * d.weekday
    w, n, g = len(demand_pool['白班']), len(
        demand_pool['小夜']), len(demand_pool['大夜'])
    total_weight = w + n + g
    weight_w = w/total_weight
    weight_n = n/total_weight
    weight_g = g/total_weight

    type_result = choice(['白班', '小夜', '大夜'], user_nums,
                         p=[weight_w, weight_n, weight_g])
    result = []
    for i in type_result:
        select = random.choice(demand_pool[i])
        result.append(select)
        demand_pool[i].remove(select)
    for i, (k, v) in enumerate(attendance_matrix.items()):
        for idx in range(len(v)):
            if v[idx] == 1:
                v[idx] = result[i]

    return attendance_matrix


@login_required
def statistics_department(request):
    return render(request, 'statistics/statistics_department.html')


@login_required
def statistics_person(request):
    context = {
        'LANG': request.LANGUAGE_CODE,
        # 'start': start,
        # 'end': end,
        # 'results': 'results',
        # 'default': start,
        # 'department': request.user.department,
        # 'bars': data['bars'],
        # 'total_avg': data['總時數'],
        # 'types': data['類別統計'],
        # 'workhours': data['應上工時'],
        # 'oncall': data['oncall'],
        # 'overtime': data['加班'],
        # 'minustime': data['減班'],
        # 'diff': data['差額'],
        'firstDay': request.user.department.start_of_week
    }
    return render(request, 'statistics/statistics_person.html', context)
