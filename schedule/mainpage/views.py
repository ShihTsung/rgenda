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


# 回傳所有員工特定時間的總工時
# def get_total_workhour_by_time(time, )


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
    """
    回傳清單，限制同部門的
    """
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
    """
    回傳清單，清單內是每個使用者的物件
    """
    users = CustomUser.objects.filter(
        can_be_scheduled=True,
        department=request.user.department)
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


def check_continuous_limit(user, choosed_shift, valid):
    if user.hour_realized < 20:
        valid = True
    else:
        valid = False


# 產生排班人員名單
def make_user_pool(day, user_dict):
    """
    day=> 選定排班的當天
    user_dict=> {username: UserObject}字典
    """
    user_pool = []
    for u in user_dict.keys():
        if day.attribute == 'holiday':
            if u.type_of_user not in ['Intern', 'PartTime']:
                user_pool.append(u.username)
        else:
            user_pool.append(u.username)
    return user_pool

# 特殊情況排除


def exclude_shift(user, shift, day):
    """
    孕婦不得值夜班
    實習生不排晚班
    user=> 使用者
    shift=> 班別
    day=> 日期
    """
    # 孕婦不排夜班
    if user.check_pregnant:
        if shift.shift_type in ['大夜', '小夜']:
            return False
    # 實習不排晚班
    if user.type_of_user == 'Intern':
        if shift.shift_type in ['小夜', '大夜']:
            return False
    # 兼職不排假日
    return True


# 職級檢查
def check_level_require(user, demand):
    """
    檢查職級是否吻合
    user=> 使用者
    demand=> 需求
    """
    if user.level < demand.level:
        return False
    return True


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
    # 對每天遍歷
    results = {u.username: {i: '' for i in days.keys()} for u in user_list}

    for i in days.keys():
        # 產生班表的 pool
        make_shift_pool(shift_list, demand_list, days[i])

        days[i].type_demand = collections.defaultdict(zero)
        # 產生當天需求
        demand_pool = {'1': {}, '2': {}, '3': {}, '4': {}}
        choosable = {'1': [], '2': [], '3': [], '4': []}
        for d in demand_list:
            idx = str(d.shift.id)
            days[i].type_demand[idx] = {'1': 0, '2': 0, '3': 0, '4': 0}
            if days[i].attribute == 'workday':
                days[i].type_demand[idx][str(d.level)] += d.weekday
            else:
                days[i].type_demand[idx][str(d.level)] += d.holiday
            demand_pool[str(d.level)
                        ][idx] = days[i].type_demand[idx][str(d.level)]
            choosable[str(d.level)].append(idx)

        for d in demand_list:
            idx = str(d.id)

        # 排序 user
        user_list.sort(key=lambda s: s.level, reverse=True)
        user_dict = {u.username: u for u in user_list}
        user_pool = make_user_pool(days[i], user_dict)

        # 照順序挑人
        for u in user_pool:
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

            results[u][i] = choosed_shift

    # print(a is b)
    print('result', results)

    # print(results)
    context = {
        'days': days,
        'users': user_list
    }
    # 隨機取一人一班別指派

    return render(request, 'mainpage/test.html', context)


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


def make_shift_pool(demand_list, shift_list, day):
    pool = {'1': [], '2': [], '3': [], '4': []}


def find_shift(day, user, shifts, demand_pool):
    """
    選定一個班別
    檢查條件
    day=> 選定的某一天
    user=> 選定的使用者
    shifts=> 本部門所有班別列表
    demand_pool=> 需求列表
    """
    random.choice()
