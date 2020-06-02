# python modules
from calendar import monthrange
import datetime
import collections
import copy
import random

# django modules
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from account.models import CustomUser, Department
from scripts.get_date_range import *
# models
from shift.models import *
from result.models import *
from demand.models import *
from date.models import *
from reservation.models import *
from station.models import *


# 回傳所有員工類別的統計
def get_employee_status(dpmt):
    users = CustomUser.objects.filter(department=dpmt)
    return_data = [0, 0, 0, 0]
    for user in users:
        if user.type_of_user == 'Normal':
            return_data[0] += 1
        elif user.type_of_user == 'Pragnant':
            return_data[1] += 1
        elif user.type_of_user == 'Intern':
            return_data[2] += 1
        elif user.type_of_user == 'PartTime':
            return_data[3] += 1
        else:
            continue
    return return_data

# 首頁，分為使用者與管理者兩種
@login_required
def index(request):
    n, p, i, pt = get_employee_status(request.user.department)
    start, end = date_range(0, 3)
    context = {
        'LANG': request.LANGUAGE_CODE,
        'Normal': n,
        'Pragnant': p,
        'Intern': i,
        'PartTime': pt,
        'start': start,
        'end': end,
        'results': 'results',
        'default': start
    }
    if request.user.is_staff:
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


def get_demands(request):
    demands = DemandOfStation.objects.all()
    demand_list = []
    for d in demands:
        if d.shift.station.department == request.user.department:
            demand_list.append(d)
    return demand_list


def get_shifts(request):
    shift_list = []
    shifts = Shift.objects.all()
    for s in shifts:
        if s.station.department == request.user.department:
            shift_list.append(s)
    return shift_list


def get_users(request):
    users = CustomUser.objects.filter(
        can_be_scheduled=True,
        department=request.user.department)
    user_list = users[::1]

    return user_list


def get_dates():
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


def check_continuous_limit(user, choosed_shift, valid):
    if user.hour_realized < 20:
        valid = True
    else:
        valid = False


def schedule_test(request):
    # 抓出需求
    demand_list = get_demands(request)
    # 抓出本部門的所有班別
    shift_list = get_shifts(request)
    # 抓出所有使用者
    user_list = get_users(request)
    # 抓出要排班的所有日期
    days = get_dates()

    def zero():
        return 0

    results = {}

    # 對每天遍歷
    for i in days.keys():
        days[i].type_demand = collections.defaultdict(zero)
        # 當天需求
        demand_pool = {'1': {}, '2': {}, '3': {}, '4': {}}
        choosable = {'1': [], '2': [], '3': [], '4': []}

        for d in demand_list:
            idx = str(d.shift.name) + '-' + str(d.shift.station.name)
            days[i].type_demand[idx] = {'1': 0, '2': 0, '3': 0, '4': 0}
            if days[i].attribute == 'workday':
                days[i].type_demand[idx][str(d.level)] += d.weekday
            else:
                days[i].type_demand[idx][str(d.level)] += d.holiday
            demand_pool[str(d.level)
                        ][idx] = days[i].type_demand[idx][str(d.level)]
            choosable[str(d.level)].append(idx)

        # 排序 user
        user_list.sort(key=lambda s: s.level, reverse=True)
        user_dict = {u.username: u for u in user_list}
        user_pool = [u.username for u in user_list]
        # print(days[i], user_list, user_pool, demand_pool)
        # 挑人
        for u in user_pool:
            # 可以排班就排下去
            if user_dict[u].can_be_scheduled:
                # 選個班別
                choosed_shift = random.choice(
                    choosable[str(user_dict[u].level)])
                valid = False  # 合法標記
                count = 0      # 計算次數限制
                while not valid:
                    check_continuous_limit(user_dict[u], choosed_shift, valid)
                    count += 1
                    if count > 100:
                        break
                    if valid is False:
                        choosed_shift = random.choice(
                            choosable[str(user_dict[u].level)])

                results[(i, u)] = [user_dict[u], choosed_shift]

    # print(a is b)
    print(results)

    # print(results)
    context = {
        'days': days,
        'users': user_list
    }
    # 隨機取一人一班別指派

    return render(request, 'mainpage/test.html', context)
