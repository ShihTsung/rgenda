from django.shortcuts import render, redirect
from .models import Result, AfterResult, PreResult
from account.models import CustomUser as User
from django.contrib.auth.decorators import login_required
from datetime import date, time, datetime, timedelta
from collections import defaultdict
from date.views import attr_list


def zeroPadding(num, digit):
    zero = ""
    for i in range(digit):
        zero += '0'
    return (zero + str(num))[-digit:]


def get_start_date():
    now = datetime.now()
    year = str(now.year)
    month = str(now.month)
    start = zeroPadding(year, 4) + '-' + zeroPadding(month, 2) + '-01'
    return start


def get_end_date(num):
    now = datetime.now()
    year = now.year
    month = now.month + num
    end = zeroPadding(year, 4) + '-' + zeroPadding(month, 2) + '-01'
    return end

# 計算總工時
@login_required
def cal_workhour(request):
    pass


# 計算月工時(可以輸入查找時間)
@login_required
def cal_period_workhour(request, start, end):
    if request.user.role == 'admin' or request.user.is_superuser:
        users = User.objects.all()
    else:
        users = User.objects.filter(department=request.user.department)

    u_workhour_dict = {u.username: 0 for u in users}

    for u in users:
        results = AfterResult.objects.filter(date__range=[start, end], user=u)
        total_hour = 0.0
        for r in results:
            total_hour += r.workhour
        u_workhour_dict[u.username] = total_hour

    context = {'hour_table': u_workhour_dict}

    return render(request, 'calculation/total_workhour.html', context)


@login_required
def show_results(request):
    lang = request.LANGUAGE_CODE
    start = get_start_date()
    end = get_end_date(3)
    context = {'LANG': lang, 'start': start, 'end': end}
    return render(request, 'calendars/results.html', context)


@login_required
def user_results(request):
    start = get_start_date()
    end = get_end_date(3)
    lang = request.LANGUAGE_CODE
    context = {'LANG': lang, 'start': start, 'end': end}
    return render(request, 'calendars/read_only_results.html', context)


def check_result(request):
    invalid = defaultdict(list)
    results = Result.objects.order_by('date')
    pre_results = PreResult.objects.order_by('date')
    data = defaultdict(list)
    start_date = results[0].date
    end_date = pre_results[-1].date if pre_results else results[-1].date
    end_date_month = end_date.month
    for result in results:
        if result.shift.start_hour == 24:
            start = datetime.combine(result.date, time(hour=0, minute=result.shift.start_min)) + timedelta(days=1)
            end = datetime.combine(result.date, time(hour=result.shift.end_hour, minute=result.shift.end_min)) + timedelta(days=1)
        elif result.shift.start_hour > result.shift.end_hour:
            start = datetime.combine(result.date, time(hour=result.shift.start_hour, minute=result.shift.start_min))
            end = datetime.combine(result.date, time(hour=result.shift.end_hour, minute=result.shift.end_min)) + timedelta(days=1)
        else:
            start = datetime.combine(result.date, time(hour=result.shift.start_hour, minute=result.shift.start_min))
            end = datetime.combine(result.date, time(hour=result.shift.end_hour, minute=result.shift.end_min))
        data[result.user.id].append({
            'id': result.id,
            'class': 'Result',
            'type': result.shift.shift_type,
            'date': result.date,
            'start': start,
            'end': end,
        })
    for result in pre_results:
        if result.shift.start_hour == 24:
            start = datetime.combine(result.date, time(hour=0, minute=result.shift.start_min)) + timedelta(days=1)
            end = datetime.combine(result.date, time(hour=result.shift.end_hour, minute=result.shift.end_min)) + timedelta(days=1)
        elif result.shift.start_hour > result.shift.end_hour:
            start = datetime.combine(result.date, time(hour=result.shift.start_hour, minute=result.shift.start_min))
            end = datetime.combine(result.date, time(hour=result.shift.end_hour, minute=result.shift.end_min)) + timedelta(days=1)
        else:
            start = datetime.combine(result.date, time(hour=result.shift.start_hour, minute=result.shift.start_min))
            end = datetime.combine(result.date, time(hour=result.shift.end_hour, minute=result.shift.end_min))
        data[result.user.id].append({
            'id': result.id,
            'class': 'PreResult',
            'type': result.shift.shift_type,
            'date': result.date,
            'start': start,
            'end': end,
        })
    attrs = attr_list(start_date, end_date)
    for user_id in data:
        user = User.objects.get(id=user_id)
        check_holiday_rest(data[user_id], attrs, user.holiday_rest_num - user.holiday_rest_num_used, invalid)
        check_law_rule(data[user_id], user.department.law_rule, invalid)
        if user.pregnant or user.type_of_user == 'Intern' and user.department.intern_d_only:
            check_d_only(data[user_id], invalid)
        if user.type_of_user == 'Intern' and not user.department.intern_in_holiday or user.type_of_user == 'PartTime' and not user.department.part_time_in_holiday:
            check_workday_only(data[user_id], attr_list, invalid)
        if user.department.schedule_rule == 1:
            check_same_in_month(data[user_id], invalid)
        if user.department.schedule_rule == 2:
            if end_date_month % 3 == 1:
                check_same_in_month(data[user_id], invalid)
            else:
                check_same_in_months(data[user_id], invalid)
    return invalid


def check_holiday_rest(data, attrs, holiday_rest_num, output):
    for i in range(len(data)):
        # 等於的值需再檢查
        if data[i]['type'] in ['休假', 'oncall'] and attrs[i] == 'holiday':
            holiday_rest_num -= 1
            if holiday_rest_num < 0:
                output[data[i]['class'] + '-' + data[i]['id']].append('可休假假日數已用完')
    return None


def check_law_rule(data, rule, output):
    continuous = 0
    work_list = list()
    end = None
    min_rest = 2 ** (rule + 1)
    days_length = 7 * (2 ** rule)
    for d in data:
        if d['type'] in ['休假', 'oncall']:
            work_list.append(1)
            continuous = 0
        else:
            continuous += 1
            work_list.append(0)
            if continuous > 6:
                output[d['class'] + '-' + d['id']].append('連續上班超過六天')
            start = d['start']
            if start and end and start < end + timedelta(hours=11):
                output[d['class'] + '-' + d['id']].append('值班間隔不足11小時')
            end = d['end']
        if len(work_list) == days_length and sum(work_list) < min_rest:
            output[d['class'] + '-' + d['id']].append('不符合勞基法工時規則')
        work_list.pop(0)
    return None


def check_d_only(data, output):
    for d in data:
        if d['type'] in ['小夜', '大夜']:
            output[d['class'] + '-' + d['id']].append('不可值夜班')
    return None


def check_workday_only(data, attrs, output):
    for i in range(len(data)):
        if not data[i]['type'] in ['休假', 'oncall'] and attrs[i] == 'holiday':
            output[data[i]['class'] + '-' + data[i]['id']].append('不可值假日班')
    return None


def check_same_in_month(data, output):
    shift_type = None
    m = data[0]['date'].month
    for d in data:
        if d['date'].month != m:
            m = d['date'].month
            shift_type = None
        if shift_type:
            if d['type'] != shift_type:
                output[d['class'] + '-' + d['id']].append('同月的班種需相同')
        else:
            if d['type'] in ['白班', '小夜', '大夜']:
                shift_type = d['type']
    return None


def check_same_in_months(data, output):
    shift_type = None
    for d in data:
        if shift_type:
            if d['type'] != shift_type:
                output[d['class'] + '-' + d['id']].append('三個月的班種需相同')
        else:
            if d['type'] in ['白班', '小夜', '大夜']:
                shift_type = d['type']
    return None