from django.shortcuts import render, redirect
from .models import Result, AfterResult, PreResult, TimeAdjustment, ExchangeApplication
from account.models import CustomUser as User
from django.contrib.auth.decorators import login_required
from scripts.get_date_range import *
from datetime import time, datetime, timedelta
from collections import defaultdict
from date.views import attr_list
from .forms import TimeAdjustmentCreateForm, TimeAdjustmentSearchForm, ExchangeApplicationCreateForm, ExchangeApplicationRefuseForm


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


@login_required
def check_result_1(continue_dict, schedule_rule, last_off_hours, to_check_month, last_shift_type=None, cycle_start=None):
    """

    :param continue_dict: 各個user的連續工作天數
    :param schedule_rule: 醫院規則，單週同班 or 單月同班 or 三月同班
    :param last_off_hours: 前一次下班時間(不考慮加班)，datetime
    :param last_shift_type: 前一班的班別(需與)，單週同班種才需要
    :return: [(result_id, invalid item),]
    """
    invalid = list()

    to_check = defaultdict(list)
    pre_results = PreResult.objects.order_by('date')
    if pre_results:
        for result in pre_results:
            to_check[result.user.id].append(result)
    else:
        results = Result.object.filter(
            date__month=to_check_month).order_by('date')
        for result in results:
            to_check[result.user.id].append(result)

    check_shift_type(to_check, invalid)

    return invalid


def check_shift_type(results, invalid):
    return None


def check_rest():
    return None


# 檢查剩餘假日休假

@login_required
def check_holiday_rest(data, attrs, holiday_rest_num, output):
    for i in range(len(data)):
        # 等於的值需再檢查
        if data[i]['type'] in ['休假', 'oncall'] and attrs[i] == 'holiday':
            holiday_rest_num -= 1
            if holiday_rest_num < 0:
                output[data[i]['class'] + '-' +
                       data[i]['id']].append('可休假假日數已用完')
    return None

# 檢查法規


@login_required
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
    return render(request, 'results/exchange_application_list.html', context=context)


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
