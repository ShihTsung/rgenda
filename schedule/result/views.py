from .forms import TimeAdjustmentCreateForm, TimeAdjustmentSearchForm, ExchangeApplicationCreateForm, ExchangeApplicationRefuseForm
from .models import Result, AfterResult, PreResult, TimeAdjustment, ExchangeApplication
from account.models import CustomUser as User
from account.models import Department
from account.views import cycle_analysis, get_cycle, assign_user
from collections import defaultdict
from copy import deepcopy
from date.models import H_Calendar
from date.views import attr_list, red_dict
from datetime import time, datetime, timedelta, date
from demand.views import get_demands
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from numpy.random import choice
from reservation.views import get_reserve_leave, get_promise_leave, get_official_leave, get_promise_other
from scripts.get_date_range import *
from shift.models import Shift
from shift.views import get_shifts
from station.models import Station
from station.views import get_stations
from calendar import monthrange
from notifications.signals import notify
from remarks.models import ResultRemark, PreResultRemark


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
    month = request.GET.get('month')
    now = datetime.datetime.now()
    next_month = now.month + 1
    year = now.year
    if next_month > 12:
        next_month = 1
        year += 1
    if month:
        days_in_month = monthrange(now.year, int(month))[1]
        start = datetime.date(now.year, int(month), 1)
        end = datetime.date(now.year, int(month), days_in_month)

    else:
        days_in_month = monthrange(year, int(month))[1]
        start = datetime.date(year, next_month, 1)
        end = datetime.date(year, next_month, days_in_month)

    results = PreResult.objects.filter(date__range=[start, end])
    published_results = Result.objects.filter(date__range=[start, end])
    remarks = PreResultRemark.objects.all()
    p_remarks = ResultRemark.objects.all()

    if results:
        notify.send(
            request.user,
            recipient=User.objects.filter(role="user"),
            verb='下個月班表發佈了！')
    for result in results:
        if result.shift.department == request.user.department:
            published = published_results.filter(
                user=result.user,
                date=result.date).first()
            if published:
                published.shift = result.shift
                published.station = result.station
                published.save()
                remark = remarks.filter(result=result).first()
                p_remark = p_remarks.filter(result=published).first()
                if remark:
                    if not p_remark:
                        ResultRemark.objects.create(
                            result=published,
                            content=remark.content
                        )
                else:
                    if p_remark:
                        p_remark.delete()
            else:
                new_result = Result.objects.create(
                    shift=result.shift,
                    user=result.user,
                    date=result.date,
                    station=result.station
                )
                remark = remarks.filter(result=result).first()
                if remark:
                    ResultRemark.objects.create(
                        result=new_result,
                        content=remark.content
                    )

    start, end = date_range(0, 2)
    context = {'LANG': lang, 'start': start, 'end': end}
    return redirect('/'+lang+'/results/pre_results')

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
        results = Result.objects.filter(
            date__month=month_to_check).order_by('date')
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
                temp_results.insert(
                    i, Result.objects.filter(date=d, user=user))
            else:
                break
        for i, result in enumerate(temp_results):
            if i % 7 == 0:
                current_shift_type = None
            if current_shift_type is None and result.shift.shift_type in [0, 1, 2]:
                current_shift_type = result.shift.shift_type
            elif result.shift.shift_type in [0, 1, 2] and result.shift.shift_type != current_shift_type and result in results:
                invalid[result.id].append('unique shift type in a week')
        return None
    # 單月/三月同班種
    current_shift_type = None
    if department.schedule_rule == 2 and date0.month % 3 != department.month_cycle:
        results_last_month = Result.objects.filter(date__month=results[0].date.month - 1,
                                                   user=user,
                                                   shift__shift_type__in=[0, 1, 2])
        shift_types = [
            result.shift.shift_type for result in results_last_month]
        counter = 0
        for st in [0, 1, 2]:
            if shift_types.count(st) > counter:
                counter = shift_types.count(st)
                current_shift_type = st
    for result in results:
        if current_shift_type is None and result.shift.shift_type in [0, 1, 2]:
            current_shift_type = result.shift.shift_type
        elif result.shift.shift_type in [0, 1, 2] and result.shift.shift_type != current_shift_type:
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
        if result.shift.shift_type in [0, 1, 2, 3]:
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
        if H_Calendar.objects.filter(date=result.date)[0].attribute == 'holiday':
            work_days_limit -= 1
        if result.shift.shift_type in [0, 1, 2, 3]:
            continue_workday += 1
            work_days += 1
        else:
            continue_workday = 0
            if H_Calendar.objects.filter(date=result.date)[0].attribute in ['weekend', 'holiday']:

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
    last_result = Result.objects.filter(
        user=results[0].user, date=results[0].date - timedelta(days=1))
    last_off_time = datetime.combine(
        last_result.date, time(hour=0, minute=0, second=0))
    if last_result.shift.shift_type in [0, 1, 2]:
        if last_result.shift.start_time > last_result.shift.end_time:
            last_off_time = datetime.combine(
                last_result.date, last_result.shift.end_time) + timedelta(days=1)
        else:
            last_off_time = datetime.combine(
                last_result.date, last_result.shift.end_time)
    for result in results:
        if result.shift.shift_type in [0, 1, 2]:
            start_time = datetime.combine(result.date, result.shift.start_time)
            if start_time - last_off_time < timedelta(hours=11):
                invalid[result.id].append('rest time less than 11 hours')
            if result.shift.start_time > result.shift.end_time:
                last_off_time = datetime.combine(
                    result.date, result.shift.end_time) + timedelta(days=1)
            else:
                last_off_time = datetime.combine(
                    result.date, result.shift.end_time)
    return None


def check_hour_pregnant(results, invalid):
    """
    檢查孕婦上班時間是否早於6點或下班時間晚於22點，是的話增加 pregnant woman work between 22 PM to 6 AM
    :param results:
    :param invalid:
    :return:
    """
    for result in results:
        if result.shift.shift_type in [0, 1, 2] and not (
                result.shift.start_time >= time(hour=6, minute=0) and result.shift.end_time <= time(hour=22, minute=0)):
            invalid[result.id].append(
                'pregnant woman work between 22 PM to 6 AM')
    return None


# TimeAdjustment 含加班/減班
@login_required
def time_adjustment_list(request):
    create_form = TimeAdjustmentCreateForm()
    search_form = TimeAdjustmentSearchForm()
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
            if result.shift.shift_type in [0, 1, 2, 3]:
                output[user.id] += 1
            else:
                output[user.id] = 0
    return output


def get_used_rest(department, date_start, date_end):
    """
    取得department中所有可排班user在date_start至date_end前已排的例假&休假
    :param department:
    :param date_start:
    :param date_end:
    :return:
    """
    users = User.objects.filter(department=department, can_be_scheduled=True)
    output = dict()
    for user in users:
        output[user.id] = list()
        results = Result.objects.filter(
            user=user, date__gte=date_start, date__lt=date_end)
        for result in results:
            if result.shift.name == '例假':
                output[user.id].append('例')
            elif result.shift.name in ['休息', 'oncall']:
                output[user.id].append('休')
            elif result.shift.shift_type in [0, 1, 2, 3]:
                output[user.id].append('工')
            else:
                output[user.id].append('特')
    return output


def get_workday_num(user_id, cycle_start, cycle_end, date0=None):
    """
    取得指定員工在起訖日內的值班天數
    若開始日期(每月一號)不是週期的第一天，則將員工該週期開始日前已排定的上班日數(同週期內上個月的班表)扣除
    :param user_id:
    :param cycle_start: (週期的)起始日
    :param cycle_end: (週期的)結束日
    :param date0: 開始日
    :return:
    """
    workdays = list(red_dict(cycle_start, cycle_end).values()).count(False)
    if date0:
        results = Result.objects.filter(
            user__id=user_id, date__gte=cycle_start, date__lt=date0,
            shift__shift_type__in=[0, 1, 2, 3])
        workdays -= len(results)
    return workdays


def str_to_date(s):
    sp = s.split('-')
    return date(year=int(sp[0]), month=int(sp[1]), day=int(sp[2]))


def create_result(request, department_id, start, end):
    """

    :param department_id:
    :param start:
    :param end:
    :return:
    """
    try:
        department = Department.objects.get(id=department_id)
    except Department.DoesNotExist:
        print('DEPARTMENT NOT EXIST')
        return redirect('/' + request.LANGUAGE_CODE + '/results')
    try:
        date_start = str_to_date(start)
        date_end = str_to_date(end)
    except ValueError:
        print('WRONG DATE INPUT')
        return redirect('/' + request.LANGUAGE_CODE + '/results')

    # 檢查班表是否已建立
    try:
        exist = Result.objects.filter(
            date=date_start, user__department=department)
        exist_pre = PreResult.objects.filter(
            date=date_start, user__department=department)
        if len(exist) + len(exist_pre):
            print('RESULT ALREADY EXIST')
            return redirect('/' + request.LANGUAGE_CODE + '/results')
    except Result.DoesNotExist:
        pass

    # 日期資料
    date_list = [date_start + timedelta(days=i)
                 for i in range((date_end - date_start).days + 1)]
    attrs = attr_list(department.id, date_start, date_end)
    reds = red_dict(date_start, date_end)

    # 連續工作天、預排假、保證假、公假
    continue_dict = get_continue_days(department, date_start)
    reserve_leave_dict = get_reserve_leave(department, date_start, date_end)
    promise_leave_dict = get_promise_leave(department, date_start, date_end)
    promise_other_dict = get_promise_other(department, date_start, date_end)
    official_leave_dict = get_official_leave(department, date_start, date_end)

    rest_dict = {
        0: '事假',
        1: '家庭照顧假',
        2: '無薪病假',
        # 3: '公假',
        4: '產假',
        # 5: '例/休',
        6: '生理假',
        7: '特休',
        8: '補休',
        9: '婚假',
        10: '計薪病假',
        11: '喪假',
        12: '安胎休養假',
        13: '產檢假',
        14: '陪產假',
    }

    # create cycle list
    ca = cycle_analysis(department, date_start)
    cycle_no = ca['cycle_no']
    cycle0 = get_cycle(department, cycle_no)
    cycle = cycle0
    cycle_list = [cycle]
    while cycle[-1] < date_end:
        cycle_no += 1
        cycle = get_cycle(department, cycle_no)
        cycle_list.append(cycle)

    # cycle0已排好的(前月的)班表
    used_rest = get_used_rest(department, cycle0[0], date_start)

    # get all stations, shifts in department
    stations = get_stations(department)
    shifts = get_shifts(department)

    output = dict()

    # 例假/休息用的 shift & station
    station_rest = Station.objects.get(
        department=department,
        name='休假',
    )
    station_official_leave = Station.objects.get(
        department=department,
        name='公假',
    )
    shift_rest0 = Shift.objects.get(
        department=department,
        name='例假',
    )
    shift_rest1 = Shift.objects.get(
        department=department,
        name='休息',
    )
    shift_official_leave = Shift.objects.get(
        department=department,
        name='公假',
    )

    for station in stations:
        for shift in shifts:

            # 排1工作站1班別
            user_pool = dict()
            workday_dict = dict()
            demands = get_demands(station, shift)
            for demand in demands:

                # 當前level的user
                user_current_level = list()

                # 建立參與排班的user池 & output
                if not demand['users']:
                    continue
                for user in demand['users']:
                    user_current_level.append(user.id)
                    user_pool.update({
                        user.id: {
                            'holiday_rest': user.holiday_rest_num - user.holiday_rest_num_used,
                            'reserve_leave': reserve_leave_dict[user.id],
                            'promise_leave': promise_leave_dict[user.id],
                            'promise_other': [str_to_date(d) for d in promise_other_dict[user.id]],
                            'official_leave': official_leave_dict[user.id],
                        },
                    })

                    output[user.id] = dict()
                    output[user.id]['date_pre'] = continue_dict[user.id]
                    for d in date_list:
                        if d in official_leave_dict[user.id]:
                            output[user.id][str(d)] = 1
                        else:
                            output[user.id][str(d)] = 0
                    workday_dict[user.id] = dict()

                # 建立需求單
                demand_dict = dict()
                for ind, d in enumerate(date_list):
                    if attrs[ind] == '0':
                        demand_dict[str(d)] = 0
                    elif attrs[ind] == '1':
                        demand_dict[str(d)] = demand['demand'].config1
                    elif attrs[ind] == '2':
                        demand_dict[str(d)] = demand['demand'].config2

                # for cycle 計算班表
                for ind, cycle in enumerate(cycle_list):

                    # set workday_dict
                    if ind == 0:
                        for user in demand['users']:
                            workday_dict[user.id][ind] = get_workday_num(
                                user.id, cycle[0], cycle[-1], date_start)
                    else:
                        for user in demand['users']:
                            workday_dict[user.id][ind] = get_workday_num(
                                user.id, cycle[0], cycle[-1])

                    # 檢查可工作天數是否滿足需求
                    total_demands = sum(
                        [demand_dict[str(d)] for d in cycle if date_start <= d <= date_end])
                    total_workdays = sum([workday_dict[user_id][ind]
                                          for user_id in user_pool])

                    if total_demands <= total_workdays:
                        # 人力滿足需求 嘗試排班100次
                        for _ in range(100):
                            # 每次回圈重設 temp_output、weight_workday、weight_holiday_rest
                            # create temp_output
                            temp_output = deepcopy(output)

                            # set weight, start calculating
                            weight_workday = dict(
                                [(user_id, workday_dict[user_id][ind]) for user_id in user_pool])
                            weight_holiday_rest = dict(
                                [(user_id, user_pool[user_id]['holiday_rest']) for user_id in user_pool])

                            for d in cycle:
                                if date_start <= d <= date_end:

                                    # user可排人選
                                    options = list()
                                    for user_id, user_data in user_pool.items():
                                        if d in (user_data['promise_leave'] + user_data['official_leave'] + user_data[
                                                'promise_other']) or weight_workday[user_id] == 0 or temp_output[user_id][
                                                str(d)] != 0:
                                            continue
                                        s = 0
                                        d_n = d - timedelta(days=1)
                                        d_p = d + timedelta(days=1)
                                        while str(d_n) in temp_output[user_id]:
                                            if temp_output[user_id][str(d_n)] != 0:
                                                s += temp_output[user_id][str(d_n)]
                                                d_n = d_n - timedelta(days=1)
                                            else:
                                                break
                                        while str(d_p) in temp_output[user_id]:
                                            if temp_output[user_id][str(d_p)] != 0:
                                                s += temp_output[user_id][str(d_p)]
                                                d_p = d_p + timedelta(days=1)
                                            else:
                                                break
                                        if s < 6:
                                            options.append(user_id)
                                    if len(options) < demand_dict[str(d)]:
                                        # 可排人數不足 跳出
                                        break

                                    # 預排假權重(10倍)
                                    weight_reserve_leave = dict()
                                    for user_id in options:
                                        if d in user_pool[user_id]['reserve_leave']:
                                            weight_reserve_leave[user_id] = 1
                                        else:
                                            weight_reserve_leave[user_id] = 10

                                    weight = list()
                                    if reds[str(d)]:
                                        # 若為休假日 則剩餘 可休假假日數 越少的人被排到的機率越高
                                        for user_id in options:
                                            weight.append(weight_workday[user_id] * weight_reserve_leave[user_id] *
                                                          (100 - weight_holiday_rest[user_id]) * 1000 + 1)
                                    else:
                                        for user_id in options:
                                            weight.append(
                                                weight_workday[user_id] * weight_reserve_leave[user_id] * 1000 + 1)
                                    weight_sum = sum(weight)
                                    weight = [w / weight_sum for w in weight]
                                    on_duty = choice(
                                        options, demand_dict[str(d)], p=weight, replace=False)
                                    for user_id in user_pool:
                                        if user_id in on_duty:
                                            temp_output[user_id][str(d)] = 1
                                            weight_workday[user_id] -= 1
                                            if reds[str(d)] and user_id not in user_current_level:
                                                weight_holiday_rest[user_id] += 1
                                        elif reds[str(d)] and user_id in user_current_level:
                                            weight_holiday_rest[user_id] -= 1
                            else:
                                # 成功排完 1 cycle
                                # 儲存結果
                                output = temp_output

                                # 儲存剩餘工作天 & 可休假假日數
                                for user_id in user_pool:
                                    workday_dict[user_id][ind] = weight_workday[user_id]
                                    user_pool[user_id]['holiday_rest'] = weight_holiday_rest[user_id]

                                # 結束迴圈
                                break
                        else:
                            # 嘗試100次皆失敗，強制產生班表，不必滿足所有需求
                            # 嘗試排班10次，取最滿足需求的結果
                            best_temp_output = None
                            demand_loss = total_demands

                            best_weight_workday = dict()
                            best_weight_holiday_rest = dict()

                            for _ in range(10):
                                # 每次回圈重設 weight_workday、weight_holiday_rest
                                temp_demand_loss = 0
                                temp_output = deepcopy(output)

                                # set weight, start calculating
                                weight_workday = dict(
                                    [(user_id, workday_dict[user_id][ind]) for user_id in user_pool])
                                weight_holiday_rest = dict(
                                    [(user_id, user_pool[user_id]['holiday_rest']) for user_id in user_pool])

                                for d in cycle:
                                    if date_start <= d <= date_end:

                                        # user可排人選
                                        options = list()
                                        for user_id, user_data in user_pool.items():
                                            if d in (user_data['promise_leave'] + user_data['official_leave'] +
                                                     user_data['promise_other']) or weight_workday[user_id] == 0 or \
                                                    temp_output[user_id][str(d)] != 0:
                                                continue
                                            s = 0
                                            d_n = d - timedelta(days=1)
                                            d_p = d + timedelta(days=1)
                                            while str(d_n) in temp_output[user_id]:
                                                if temp_output[user_id][str(d_n)] != 0:
                                                    s += temp_output[user_id][str(
                                                        d_n)]
                                                    d_n = d_n - \
                                                        timedelta(days=1)
                                                else:
                                                    break
                                            while str(d_p) in temp_output[user_id]:
                                                if temp_output[user_id][str(d_p)] != 0:
                                                    s += temp_output[user_id][str(
                                                        d_p)]
                                                    d_p = d_p + \
                                                        timedelta(days=1)
                                                else:
                                                    break
                                            if s < 6:
                                                options.append(user_id)
                                        if len(options) <= demand_dict[str(d)]:
                                            # 可排人數不足或等於需求 所有可排人員皆排班 記錄差額
                                            temp_demand_loss += demand_dict[str(
                                                d)] - len(options)
                                            for user_id in user_pool:
                                                if user_id in options:
                                                    temp_output[user_id][str(
                                                        d)] = 1
                                                    weight_workday[user_id] -= 1
                                                    if reds[str(d)] and user_id not in user_current_level:
                                                        weight_holiday_rest[user_id] += 1
                                                elif reds[str(d)] and user_id in user_current_level:
                                                    weight_holiday_rest[user_id] -= 1
                                        else:
                                            # 預排假權重
                                            weight_reserve_leave = dict()
                                            for user_id in options:
                                                if d in user_pool[user_id]['reserve_leave']:
                                                    weight_reserve_leave[user_id] = 1
                                                else:
                                                    weight_reserve_leave[user_id] = 10

                                            weight = list()
                                            if reds[str(d)]:
                                                for user_id in options:
                                                    weight.append(
                                                        weight_workday[user_id] * weight_reserve_leave[user_id] * (
                                                            100 - weight_holiday_rest[user_id]) * 1000 + 1)
                                            else:
                                                for user_id in options:
                                                    weight.append(weight_workday[user_id] * weight_reserve_leave[
                                                        user_id] * 1000 + 1)
                                            weight_sum = sum(weight)
                                            weight = [
                                                w / weight_sum for w in weight]
                                            on_duty = choice(
                                                options, demand_dict[str(d)], p=weight, replace=False)
                                            for user_id in user_pool:
                                                if user_id in on_duty:
                                                    temp_output[user_id][str(
                                                        d)] = 1
                                                    weight_workday[user_id] -= 1
                                                    if reds[str(d)] and user_id not in user_current_level:
                                                        weight_holiday_rest[user_id] += 1
                                                elif reds[str(d)] and user_id in user_current_level:
                                                    weight_holiday_rest[user_id] -= 1
                                if temp_demand_loss < demand_loss:
                                    demand_loss = temp_demand_loss
                                    best_temp_output = temp_output
                                    best_weight_workday.update(weight_workday)
                                    best_weight_holiday_rest.update(
                                        weight_holiday_rest)
                            output = best_temp_output

                            # 儲存剩餘工作天 & 可休假假日數
                            for user_id in user_pool:
                                workday_dict[user_id][ind] = best_weight_workday[user_id]
                                user_pool[user_id]['holiday_rest'] = best_weight_holiday_rest[user_id]
                    else:
                        # 嘗試排班100次，取最滿足需求的結果
                        best_temp_output = None
                        demand_loss = total_demands

                        best_weight_workday = dict()
                        best_weight_holiday_rest = dict()

                        for _ in range(100):
                            # 每次回圈重設 temp_output、weight_workday、weight_holiday_rest
                            # create temp_output
                            temp_output = deepcopy(output)
                            temp_demand_loss = 0

                            # set weight, start calculating
                            weight_workday = dict(
                                [(user_id, workday_dict[user_id][ind]) for user_id in user_pool])
                            weight_holiday_rest = dict(
                                [(user_id, user_pool[user_id]['holiday_rest']) for user_id in user_pool])

                            for d in cycle:
                                if date_start <= d <= date_end:
                                    # user可排人選
                                    options = list()
                                    for user_id, user_data in user_pool.items():
                                        if d in (user_data['promise_leave'] + user_data['official_leave'] + user_data[
                                                'promise_other']) or weight_workday[user_id] == 0 or temp_output[user_id][
                                                str(d)] != 0:
                                            continue
                                        s = 0
                                        d_n = d - timedelta(days=1)
                                        d_p = d + timedelta(days=1)
                                        while str(d_n) in temp_output[user_id]:
                                            if temp_output[user_id][str(d_n)] != 0:
                                                s += temp_output[user_id][str(d_n)]
                                                d_n = d_n - timedelta(days=1)
                                            else:
                                                break
                                        while str(d_p) in temp_output[user_id]:
                                            if temp_output[user_id][str(d_p)] != 0:
                                                s += temp_output[user_id][str(d_p)]
                                                d_p = d_p + timedelta(days=1)
                                            else:
                                                break
                                        if s < 6:
                                            options.append(user_id)
                                    if len(options) <= demand_dict[str(d)]:
                                        # 可排人數不足或等於需求 所有可排人員皆排班 記錄差額
                                        temp_demand_loss += demand_dict[str(
                                            d)] - len(options)
                                        for user_id in user_pool:
                                            if user_id in options:
                                                temp_output[user_id][str(
                                                    d)] = 1
                                                weight_workday[user_id] -= 1
                                                if reds[str(d)] and user_id not in user_current_level:
                                                    weight_holiday_rest[user_id] += 1
                                            elif reds[str(d)] and user_id in user_current_level:
                                                weight_holiday_rest[user_id] -= 1
                                    else:
                                        # 預排假權重
                                        weight_reserve_leave = dict()
                                        for user_id in options:
                                            if d in user_pool[user_id]['reserve_leave']:
                                                weight_reserve_leave[user_id] = 1
                                            else:
                                                weight_reserve_leave[user_id] = 10

                                        weight = list()
                                        if reds[str(d)]:
                                            for user_id in options:
                                                weight.append(
                                                    weight_workday[user_id] * weight_reserve_leave[user_id] * (
                                                        100 - weight_holiday_rest[user_id]) * 1000 + 1)
                                        else:
                                            for user_id in options:
                                                weight.append(weight_workday[user_id] * weight_reserve_leave[
                                                    user_id] * 1000 + 1)
                                        weight_sum = sum(weight)
                                        weight = [
                                            w / weight_sum for w in weight]
                                        on_duty = choice(
                                            options, demand_dict[str(d)], p=weight, replace=False)
                                        for user_id in user_pool:
                                            if user_id in on_duty:
                                                temp_output[user_id][str(
                                                    d)] = 1
                                                weight_workday[user_id] -= 1
                                                if reds[str(d)] and user_id not in user_current_level:
                                                    weight_holiday_rest[user_id] += 1
                                            elif reds[str(d)] and user_id in user_current_level:
                                                weight_holiday_rest[user_id] -= 1
                            if temp_demand_loss < demand_loss:
                                demand_loss = temp_demand_loss
                                best_temp_output = temp_output
                                best_weight_workday.update(weight_workday)
                                best_weight_holiday_rest.update(
                                    weight_holiday_rest)
                        output = best_temp_output

                        # 儲存剩餘工作天 & 可休假假日數
                        for user_id in user_pool:
                            workday_dict[user_id][ind] = best_weight_workday[user_id]
                            user_pool[user_id]['holiday_rest'] = best_weight_holiday_rest[user_id]
            # --print--
            print('RESULTS')

            # 移除date_pre
            # 將0指派為 例假/休假/特殊假
            for user_id in user_pool:
                user = User.objects.get(id=user_id)
                output[user_id].pop('date_pre')

                # --print--
                print(user_id, output[user_id].values())

                q = used_rest[user_id]
                for ind, cycle in enumerate(cycle_list):
                    options = ['例', '休'] * 2 ** department.schedule_rule
                    # 第一個迴圈需將之前的例假/休假扣除
                    if ind == 0:
                        for st in q:
                            if st in ['例', '休']:
                                print(st)
                                options.remove(st)
                            if '休' not in options:
                                options.append('休')
                    q = q[-6:]
                    for d in cycle:
                        if date_start <= d <= date_end:
                            # 增加公假Result
                            if d in user_pool[user_id]['official_leave']:
                                output[user_id][str(d)] = '工'
                                PreResult.objects.create(
                                    user=user,
                                    shift=shift_official_leave,
                                    date=d,
                                    station=station_official_leave,
                                )
                            # 增加上班Result
                            elif output[user_id][str(d)] == 1:
                                output[user_id][str(d)] = '工'
                                PreResult.objects.create(
                                    user=user,
                                    shift=shift,
                                    date=d,
                                    station=station,
                                )
                            # 增加特殊假Result
                            elif d in user_pool[user_id]['promise_other']:
                                output[user_id][str(d)] = '特'
                                PreResult.objects.create(
                                    user=user,
                                    shift=Shift.objects.get(
                                        department=department, name=rest_dict[promise_other_dict[user_id][str(d)]]),
                                    date=d,
                                    station=station_rest,
                                )
                            # 增加例假 or 休息Result
                            else:
                                # 排休且為假日，已使用假日休假數+1
                                if reds[str(d)]:
                                    user.holiday_rest_num_used += 1
                                if '例' not in q and '例' in options:
                                    options.remove('例')
                                    output[user_id][str(d)] = '例'
                                    PreResult.objects.create(
                                        user=user,
                                        shift=shift_rest0,
                                        date=d,
                                        station=station_rest,
                                    )
                                else:
                                    options.remove('休')
                                    output[user_id][str(d)] = '休'
                                    PreResult.objects.create(
                                        user=user,
                                        shift=shift_rest1,
                                        date=d,
                                        station=station_rest,
                                    )
                            q.append(output[user_id][str(d)])
                            if len(q) > 6:
                                q.pop(0)
                            if '休' not in options:
                                options.append('休')
                user.save()

    # 行政職
    try:
        user_admin = User.objects.get(type_of_user=2)
        station_admin = Station.objects.get(department=department, name='行政')
        shift_admin = Shift.objects.get(department=department, name='行政')

        for user in user_admin:
            for d in date_list:
                if reds[str(d)]:
                    if d.isoweekday() == 7:
                        PreResult.objects.create(
                            user=user,
                            shift=shift_rest0,
                            date=d,
                            station=station_rest,
                        )
                    else:
                        PreResult.objects.create(
                            user=user,
                            shift=shift_rest1,
                            date=d,
                            station=station_rest,
                        )
                elif d in official_leave_dict[user.id]:
                    PreResult.objects.create(
                        user=user,
                        shift=shift_official_leave,
                        date=d,
                        station=station_official_leave,
                    )
                elif str(d) in promise_other_dict[user.id]:
                    PreResult.objects.create(
                        user=user,
                        shift=Shift.objects.get(department=department, name=rest_dict[promise_other_dict[user.id][str(d)]]),
                        date=d,
                        station=station_rest,
                    )
                else:
                    PreResult.objects.create(
                        user=user,
                        shift=shift_admin,
                        date=d,
                        station=station_admin,
                    )
    except User.DoesNotExist:
        pass

    return redirect('/' + request.LANGUAGE_CODE + '/results')
