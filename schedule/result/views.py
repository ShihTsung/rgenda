from django.shortcuts import render, redirect
from .models import Result, AfterResult, PreResult, TimeAdjustment, ExchangeApplication
from account.models import CustomUser as User
from account.models import Department
from account.views import cycle_analysis, get_cycle, assign_user
from django.contrib.auth.decorators import login_required
from scripts.get_date_range import *
from datetime import time, datetime, timedelta, date
from collections import defaultdict
from date.views import red_list
from .forms import TimeAdjustmentCreateForm, TimeAdjustmentSearchForm, ExchangeApplicationCreateForm, ExchangeApplicationRefuseForm
from date.models import Oneday
from demand.views import get_demands
from reservation.views import get_reserve_leave, get_promise_leave, get_official_leave
from numpy.random import choice
import json


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


# 秀出正式班表
@login_required
def show_results(request):
    lang = request.LANGUAGE_CODE
    start, end = date_range(0, 3)
    context = {'LANG': lang, 'start': start, 'end': end}
    return render(request, 'calendars/results.html', context)


# 唯讀班表
@login_required
def user_results(request):
    start, end = date_range(0, 3)
    lang = request.LANGUAGE_CODE
    context = {
        'LANG': lang,
        'start': start,
        'end': end,
        'results': 'results',
        'default': start}
    return render(request, 'calendars/read_only_results.html', context)


# 排完未發布班表
@login_required
def show_pre_result(request):
    start, end = date_range(0, 2)
    lang = request.LANGUAGE_CODE
    context = {'LANG': lang, 'start': start, 'end': end}
    return render(request, 'calendars/pre_results.html', context)


# 歷史班表
@login_required
def show_after_result(request):
    start, end = date_range(-12, 0)
    lang = request.LANGUAGE_CODE
    context = {
        'LANG': lang,
        'start': start,
        'end': end,
        'results': 'afterresults',
        'default': end}
    return render(request, 'calendars/history_results.html', context)

# 班表發布
@login_required
def publish_result(request):
    lang = request.LANGUAGE_CODE
    results = PreResult.objects.all()
    for result in results:
        if result.shift.station.department == request.user.department:
            Result.objects.create(
                shift=result.shift,
                user=result.user,
                date=result.date,
                overtime=result.overtime)
            result.delete()
    start, end = date_range(0, 2)
    context = {'LANG': lang, 'start': start, 'end': end}
    return redirect('/'+lang+'/results')

# 現在班表轉歷史班表
@login_required
def result_to_history(request):
    lang = request.LANGUAGE_CODE
    start, end = date_range(-1, 0)
    results = Result.objects.filter(
        date__range=[start, end])
    for result in results:
        if result.shift.station.department == request.user.department:
            AfterResult.objects.create(
                shift=result.shift,
                user=result.user,
                date=result.date,
                overtime=result.overtime)
            result.delete()
    start, end = date_range(0, 2)
    context = {
        'LANG': lang,
        'start': start,
        'end': end,
        'results': 'afterresults',
        'default': end
    }

    return redirect('/'+lang+'/results/after_results')


def check_result(d_id, month_to_check=None):
    """
    """
    invalid = defaultdict(list)
    # demand_unsatisfied = defaultdict()
    if month_to_check:
        results = Result.objects.filter(date__month=month_to_check).order_by('date')
    else:
        results = PreResult.objects.order_by('date')
    to_check = defaultdict(list)
    for result in results:
        to_check[result.user.id].append(result)
    department = Department.objects.get(id=d_id)
    for user_id, results in to_check.items():
        check_cycle(department, results, invalid)
        check_rest_day(department, results, invalid)
        check_rest_hour(results, invalid)
        if User.objects.get(id=user_id).pregnant:
            check_hour_pregnant(results, invalid)
    return invalid


def check_cycle(department, results, invalid):
    """
    檢查 單週/單月/三月 內班種是否相同，增加 unique shift type in a week/a month/three month
    :param department:
    :param results:
    :param invalid:
    :return:
    """
    date0 = results[0].date
    user = results[0].user
    # 單週同班種
    if department.schedule_rule == 0:
        temp_results = results.copy()
        ca = cycle_analysis(department.id, date0)
        current_shift_type = None
        for i, d in enumerate(get_cycle(department.id, ca['cycle_no'])):
            if d < date0:
                temp_results.insert(i, Result.objects.filter(date=d, user=user))
            else:
                break
        for i, result in enumerate(temp_results):
            if i % 7 == 0:
                current_shift_type = None
            if current_shift_type is None and result.shift.shift_type in ['白班', '小夜', '大夜']:
                current_shift_type = result.shift.shift_type
            elif result.shift.shift_type in ['白班', '小夜', '大夜'] and result.shift.shift_type != current_shift_type and result in results:
                invalid[result.id].append('unique shift type in a week')
        return None
    # 單月/三月同班種
    current_shift_type = None
    if department.schedule_rule == 2 and date0.month % 3 != department.month_cycle:
        results_last_month = Result.objects.filter(date__month=results[0].date.month - 1,
                                                   user=user,
                                                   shift__shift_type__in=['白班', '小夜', '大夜'])
        shift_types = [result.shift.shift_type for result in results_last_month]
        counter = 0
        for st in ['白班', '小夜', '大夜']:
            if shift_types.count(st) > counter:
                counter = shift_types.count(st)
                current_shift_type = st
    for result in results:
        if current_shift_type is None and result.shift.shift_type in ['白班', '小夜', '大夜']:
            current_shift_type = result.shift.shift_type
        elif result.shift.shift_type in ['白班', '小夜', '大夜'] and result.shift.shift_type != current_shift_type:
            invalid[result.id].append('unique shift type in a week')
    return None


def check_rest_day(department, results, invalid):
    """
    檢查
    1. 連續工作超過6天，增加 continue working over 6 days
    2. 單一週期內休假數目不足，增加 workday too much in the cycle
    3. 週末/國定假日休假額度用完，增加 holiday rest out of limit
    :param department:
    :param results:
    :param invalid:
    :return:
    """
    user = results[0].user
    holiday_rest_remain = user.holiday_rest_num - user.holiday_rest_num_used
    date0 = results[0].date
    ca = cycle_analysis(department.id, date0)
    temp_results = results.copy()
    # add previous results to make a complete cycle
    for i, d in enumerate(get_cycle(department.id, ca['cycle_no'])):
        if d < date0:
            temp_results.insert(i, Result.objects.filter(date=d, user=user))
        else:
            break
    # get continue workday number
    last_week_results = Result.objects.filter(date__in=[date0 - timedelta(days=i) for i in range(1, 8)],
                                              user=user).order_by('date')
    continue_workday = 0
    for result in last_week_results:
        if result.shift.shift_type in ['白班', '小夜', '大夜', '公假']:
            continue_workday += 1
        else:
            continue_workday = 0
    # start checking
    work_days_limit = 5 * 2 ** department.law_rule
    work_days = 0
    for ind, result in enumerate(temp_results):
        if ind % (5 * 2 ** department.law_rule) == 0:
            work_days_limit = 5 * 2 ** department.law_rule
            work_days = 0
        if Oneday.objects.filter(date=result.date)[0].attribute == 'holiday':
            work_days_limit -= 1
        if result.shift.shift_type in ['白班', '小夜', '大夜', '公假']:
            continue_workday += 1
            work_days += 1
        else:
            continue_workday = 0
            if Oneday.objects.filter(date=result.date)[0].red_day:
                holiday_rest_remain -= 1
        if continue_workday > 6 and result in results:
            invalid[result.id].append('continue working over 6 days')
        if work_days > work_days_limit and result in results:
            invalid[result.id].append('workday too much in the cycle')
        if holiday_rest_remain < 0:
            invalid[result.id].append('holiday rest out of limit')
    return None


def check_rest_hour(results, invalid):
    """
    檢查兩班之間休息是否過11小時，不足的話增加 rest time less than 11 hours
    :param results:
    :param invalid:
    :return:
    """
    last_result = Result.objects.filter(user=results[0].user, date=results[0].date - timedelta(days=1))
    last_off_time = datetime.combine(last_result.date, time(hour=0, minute=0, second=0))
    if last_result.shift.shift_type in ['白班', '小夜', '大夜']:
        if last_result.shift.start_time > last_result.shift.end_time:
            last_off_time = datetime.combine(last_result.date, last_result.shift.end_time) + timedelta(days=1)
        else:
            last_off_time = datetime.combine(last_result.date, last_result.shift.end_time)
    for result in results:
        if result.shift.shift_type in ['白班', '小夜', '大夜']:
            start_time = datetime.combine(result.date, result.shift.start_time)
            if start_time - last_off_time < timedelta(hours=11):
                invalid[result.id].append('rest time less than 11 hours')
            if result.shift.start_time > result.shift.end_time:
                last_off_time = datetime.combine(result.date, result.shift.end_time) + timedelta(days=1)
            else:
                last_off_time = datetime.combine(result.date, result.shift.end_time)
    return None


def check_hour_pregnant(results, invalid):
    """
    檢查孕婦上班時間是否早於6點或下班時間晚於22點，是的話增加 pregnant woman work between 22 PM to 6 AM
    :param results:
    :param invalid:
    :return:
    """
    for result in results:
        if result.shift.shift_type in ['白班', '小夜', '大夜'] and not (
                result.shift.start_time >= time(hour=6, minute=0) and result.shift.end_time <= time(hour=22, minute=0)):
            invalid[result.id].append('pregnant woman work between 22 PM to 6 AM')
    return None


# TimeAdjustment 含加班/減班
@login_required
def time_adjustment_list(request):
    create_form = TimeAdjustmentCreateForm()
    search_form = TimeAdjustmentSearchForm()
    results = Result.objects.exclude(
        time_adjustment__isnull=True).order_by('-time_adjustment__id')[:10]
    if request.method == 'POST':
        if 'result_date' in request.POST:
            time_adjustment = TimeAdjustment(
                hours=create_form.hours,
                adjustment_type=create_form.adjustment_type,
                remark=create_form.remark,
            )
            time_adjustment.save()
            result = Result.objects.filter(
                user__name=create_form.name,
                date=create_form.result_date,
            )
            result.time_adjustment = time_adjustment
            result.save()
            return redirect('/result/time_adjustment')
        if 'date_start' in request.POST:
            results = Result.objects.filter(
                date__range=[search_form.date_start, search_form.date_end],
                user__name=search_form.name,
                time_adjustment__isnull=False,
                time_adjustment__item=search_form.adjustment_item,
            )
            create_form = TimeAdjustmentCreateForm()
            search_form = TimeAdjustmentSearchForm()
    context = {
        'results': results,
        'create_form': create_form,
        'search_form': search_form,
    }
    return render(request, 'results/time_adjustment.html', context=context)


# 換班申請
@login_required
def exchange_application_list(request):
    form = ExchangeApplicationCreateForm()
    if request.method == 'POST':
        application = ExchangeApplication(
            user_apply=request.user,
            user_receive=form.receive_user,
            date_start=form.exchange_date_start,
            date_end=form.exchange_date_end,
        )
        application.save()
        return redirect('/result/exchange_application_list')
    processing = list()
    complete = list()
    if request.user.role == 'user':
        applications = ExchangeApplication.objects.filter(
            user_apply=request.user)
        for application in applications:
            if application.application_status in [0, 1, 2, 3]:
                processing.append(application)
            else:
                complete.append(application)
    else:
        applications = ExchangeApplication.objects.exclude(
            application_status=0)
        for application in applications:
            if application.application_status == 1:
                processing.append(application)
            else:
                complete.append(application)
    context = {
        'processing': processing,
        'complete': complete,
        'form': form,
    }
    return render(request,
                  'results/exchange_application_list.html',
                  context=context)


@login_required
def exchange_application_audit(request):
    form = ExchangeApplicationRefuseForm()
    if request.method == 'POST':
        application = ExchangeApplication.objects.get(
            id=form.exchange_application_id)
        application.application_status = 2
        application.remark = form.remark
        application.save()
        return redirect('/result/exchange_application_audit')
    if request.user.role == 'user':
        processing = ExchangeApplication.objects.filter(
            user_receive=request.user, application_status=0)
        complete = None
    else:
        processing = ExchangeApplication.objects.filter(application_status=1)
        complete = ExchangeApplication.objects.filter(
            application_status__in=[2, 3, 4, 5])
    context = {
        'processing': processing,
        'complete': complete,
        'form': form,
    }
    return render(request, 'results/exchange_application_audit.html', context=context)


@login_required
def exchange_application_undo(request, ea_id):
    application = ExchangeApplication.objects.get(id=ea_id)
    application.delete()
    return redirect('/result/exchange_application_list')


@login_required
def exchange_application_accept(request, ea_id):
    application = ExchangeApplication.objects.get(id=ea_id)
    if request.user.role == 'user':
        application.application_status = 1
        application.save()
        return redirect('/result/exchange_application_audit')
    else:
        application.application_status = 3
        application.save()
        date_list = [application.date_start]
        temp_date = application.date_start
        while temp_date < application.date_end:
            temp_date += timedelta(days=1)
            date_list.append(temp_date)
        for d in date_list:
            result_apply = Result.objects.filter(
                date=d, user=application.user_apply)
            result_apply.user = application.user_receive
            result_apply.save()
            result_receive = Result.objects.filter(
                date=d, user=application.user_receive)
            result_receive.user = application.user_apply
            result_receive.save()
        return redirect('/result/exchange_application_list')


@login_required
def exchange_application_archive(request, ea_id):
    application = ExchangeApplication.objects.get(id=ea_id)
    application.application_status += 2
    application.save()
    return redirect('/result/exchange_application_list')


def calculate(request):
    department = Department.objects.get(id=1)
    #
    demands = get_demands(department, date(year=2020, month=7, day=1), date(year=2020, month=7, day=31), True)
    # 白班/小夜/大夜 人力需求比(依階級區分)
    shift_type_proportion = {
        '白班': {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            'sum': 0,
        },
        '小夜': {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            'sum': 0,
        },
        '大夜': {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            'sum': 0,
        },
    }
    for st in ['白班', '小夜', '大夜']:
        for d in demands[st]:
            for i in range(1, 5):
                shift_type_proportion[st][i] = max(shift_type_proportion[st][i], demands[st][d][i])
    for st in shift_type_proportion:
        shift_type_proportion[st]['sum'] = sum(shift_type_proportion[st].values())
    # 單月同班種
    # if department.schedule_rule == 1:
    #     # 一般
    #     if department.law_rule == 0:
    #         pass
    #     elif department.law_rule == 1:
    results = calculate_m_1(department, demands, shift_type_proportion)

    context = {
        'demands': json.dumps(demands),
        'shift_type_proportion': json.dumps(shift_type_proportion),
        'results': json.dumps(results),
    }
    return render(request, 'test.html', context=context)


def calculate_m_1(department, demands, user_proportion):
    """
    單月/三月同班種 雙週變形工時
    :return:
    """
    results = {
        '白班': dict(),
        '小夜': dict(),
        '大夜': dict(),
    }
    result_count = 0
    result_status = {
        '白班': False,
        '小夜': False,
        '大夜': False,
    }
    # 切週期，存在cycle_list
    date_start = str_to_date(list(demands['白班'].keys())[0])
    date_end = str_to_date(list(demands['白班'].keys())[-1])
    ca = cycle_analysis(department, date_start)
    cycle_no = ca['cycle_no']
    cycle0 = get_cycle(department, cycle_no)
    cycle = cycle0
    cycle_list = [cycle]
    while cycle[-1] < date_end:
        cycle_no += 1
        cycle = get_cycle(department, cycle_no)
        cycle_list.append(cycle)
    # 計算
    # 1. 分配人
    # 2. for 班別 D/E/N
    # 3. for level 4/3/2/1
    # 4. for 週期cycle
    while result_count < 10:  # TODO
        result_count += 1
        # 1.
        user_distribution = assign_user(department, user_proportion)
        continue_dict = get_continue_days(department, date_start)
        reserve_leave_dict = get_reserve_leave(department, date_start, date_end)
        promise_leave_dict = get_promise_leave(department, date_start, date_end)
        official_leave_dict = get_official_leave(department, date_start, date_end)
        # 2.
        for st in ['白班', '小夜', '大夜']:
            # 整理user資料
            users = {
                1: dict(),
                2: dict(),
                3: dict(),
                4: dict(),
            }
            for level in user_distribution[st]:
                for user in user_distribution[st][level]:
                    users[level][user.id] = {
                        'holiday_rest': user.holiday_rest_num - user.holiday_rest_num_used,
                        # workday 要 by cycle 計算
                        'workday': 0,
                        'work_continuous': continue_dict[user.id],
                        'reserve_leave': reserve_leave_dict[user.id],
                        'promise_leave': promise_leave_dict[user.id],
                        'official_leave': official_leave_dict[user.id],
                    }
            temp_result = None
            count = 0
            while temp_result is None and count < 100:
                temp_users = users.copy()
                # 3, 4
                temp_result = calculate_with_level(temp_users, demands[st], cycle_list)
            if temp_result:
                results[st].update(temp_result)
                result_status[st] = True
            else:
                results = {
                    '白班': dict(),
                    '小夜': dict(),
                    '大夜': dict(),
                }
                result_status = {
                    '白班': False,
                    '小夜': False,
                    '大夜': False,
                }
                break
        if result_status['白班'] and result_status['小夜'] and result_status['大夜']:
            break
    return results


def get_continue_days(department, date0):
    """
    取得department中所有可排班user在date0之前的連續工作天數
    :param department:
    :param date0:
    :return:
    """
    users = User.objects.filter(department=department, can_be_scheduled=True)
    output = dict()
    for user in users:
        output[user.id] = 0
        results = Result.objects.filter(user=user, date__gte=date0 - timedelta(days=7),
                                        date__lte=date0 - timedelta(days=1)).order_by('date')
        for result in results:
            if result.shift.shift_type in ['白班', '小夜', '大夜', '公假']:
                output[user.id] += 1
            else:
                output[user.id] = 0
    return output


def get_workday_num(user_id, date_start, date_end, date0=None):
    """
    取得指定員工在起訖日內的值班天數
    若開始日期(每月一號)不是週期的第一天，則將員工該週期開始日前已排定的上班日數(同週期內上個月的班表)扣除
    :param user_id:
    :param date_start: (週期的)起始日
    :param date_end: (週期的)結束日
    :param date0: 開始日
    :return:
    """
    workdays = red_list(date_start, date_end).count(False)
    if date0:
        results = Result.objects.filter(user__id=user_id, date__gte=date_start, date__lt=date0,
                                        shift__shift_type__in=['白班', '小夜', '大夜', '公假'])
        workdays -= len(results)
    return workdays


def calculate_with_level(users, demands, cycle_list):
    """

    :param users: {
        level: [
            {
                'id': id,
                'holiday_rest': holiday_rest,
                'workday': 0,
                'work_continuous': work_continuous,
                'reserve_leave': reserve_leave,
                'promise_leave': promise_leave,
                'official_leave': official_leave,
            },
        ]
    }
    :param demands: {
        date: {
            1: a,
            2: b,
            3: c,
            4: d,
        }
    }
    :param cycle_list:
    :return:
    """
    # set output = {
    #     user_id: {
    #         date_pre: continue_days,
    #         date: 0,
    #     },
    # }
    output = dict()
    date_pre = str(str_to_date(list(demands.keys())[0]) - timedelta(days=1))
    for l in users:
        for user_id in users[l]:
            output[user_id] = dict()
            output[user_id][date_pre] = users[l][user_id]['work_continuous']
            for d in demands:
                if d in users[l][user_id]['official_leave']:
                    output[user_id][d] = 1
                else:
                    output[user_id][d] = 0
    # workdays_dict 存取每個user在每個cycle有多少工作天
    workdays_dict = defaultdict(dict)
    # user_pool 參與排班的使用者 4 > 4+3 > 4+3+2 > 4+3+2+1
    user_pool = dict()

    date0 = str_to_date(list(demands.keys())[0])
    date_ = str_to_date(list(demands.keys())[-1])
    # 3.
    for level in [4, 3, 2, 1]:
        user_pool.update(users[level])
        # 4.
        for ind, cycle in enumerate(cycle_list):
            if ind == 0:
                for user_id in users[level]:
                    workdays_dict[user_id][ind] = get_workday_num(user_id, cycle[0], cycle[-1], date0)
            else:
                for user_id in users[level]:
                    workdays_dict[user_id][ind] = get_workday_num(user_id, cycle[0], cycle[-1])
            for user_id in user_pool:
                user_pool[user_id]['workday'] = workdays_dict[user_id][ind]
            # 檢查可工作天數是否滿足需求
            total_demands = sum([demands[str(d)][level] for d in cycle if date0 <= d <= date_])
            total_workdays = sum([user_pool[user_id]['workday'] for user_id in user_pool])
            if total_demands > total_workdays:
                # TODO: add fake users
                return None
            # set weight, start calculating

            weight_workday = dict([(user_id, user_pool[user_id]['workday']) for user_id in user_pool])
            weight_holiday_rest = dict([(user_id, user_pool[user_id]['holiday_rest']) for user_id in user_pool])

            for d in demands:
                options = list()
                for user_id, user_data in user_pool.items():
                    if d in (user_data['promise_leave'] + user_data['official_leave']) or weight_workday[user_id] == 0 or output[user_id][d] != 0:
                        continue
                    s = 0
                    d_n = d_p = d
                    while d_n in output[user_id]:
                        if output[user_id][d_n] != 0:
                            s += output[user_id][d_n]
                            d_n = str(str_to_date(d_n) - timedelta(days=1))
                        else:
                            break
                    while d_p in output[user_id]:
                        if output[user_id][d_p] != 0:
                            s += output[user_id][d_p]
                            d_p = str(str_to_date(d_p) + timedelta(days=1))
                        else:
                            break
                    if s < 6:
                        options.append(user_id)
                if len(options) < demands[d][level]:
                    # 可排人數不足，重試
                    return None
                weight_reserve_leave = dict()
                for user_id, user_data in user_pool.items():
                    if d in user_data['reserve_leave']:
                        weight_reserve_leave[user_id] = 1
                    else:
                        weight_reserve_leave[user_id] = 10
                weight = list()
                if demands[d]['red']:
                    for user_id in options:
                        weight.append(weight_workday[user_id] * weight_reserve_leave[user_id] * weight_holiday_rest[
                            user_id] * 1000 + 1)
                else:
                    for user_id in options:
                        weight.append(weight_workday[user_id] * weight_reserve_leave[user_id] * 1000 + 1)
                weight_sum = sum(weight)
                weight = [w / weight_sum for w in weight]
                on_duty = choice(options, demands[d][level], p=weight, replace=False)
                for user_id in on_duty:
                    output[user_id][d] = 1
                    weight_workday[user_id] -= 1
                if demands[d]['red']:
                    for user_id in users[level]:
                        if user_id not in on_duty:
                            weight_holiday_rest[user_id] -= 1
    for user_id in output:
        output[user_id].pop(date_pre)
    return output


def str_to_date(s):
    sp = s.split('-')
    return date(year=int(sp[0]), month=int(sp[1]), day=int(sp[2]))
