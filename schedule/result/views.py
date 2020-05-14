from django.shortcuts import render, redirect
from .models import Result, AfterResult, PreResult
from account.models import CustomUser as User
from django.contrib.auth.decorators import login_required
import datetime


def zeroPadding(num, digit):
    zero = ""
    for i in range(digit):
        zero += '0'
    return (zero + str(num))[-digit:]


def get_start_date():
    now = datetime.datetime.now()
    year = str(now.year)
    month = str(now.month)
    start = zeroPadding(year, 4) + '-' + zeroPadding(month, 2) + '-01'
    return start


def get_end_date(num):
    now = datetime.datetime.now()
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
