from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import H_Calendar


@login_required
def date_manage(request):
    context = {'LANG': request.LANGUAGE_CODE}
    return render(request, 'calendars/date_manage.html', context)


@login_required
def config_manage(request):
    context = {'LANG': request.LANGUAGE_CODE}
    return render(request, 'calendars/config_manage.html', context)


def attr_list(start, end):
    """
    取得醫院行事曆類別，分為workday(一般工作日)，holiday(休息工作日)，closed_day(休診日)
    :param start: 開始日期
    :param end: 結束日期
    :return:
    """
    days = H_Calendar.objects.filter(date__gte=start, date__lte=end).order_by('date')
    return [day.attribute for day in days]


def red_list(start, end):
    """
    取得是否為假日，假日包含週休二日和國定假日
    :param start: 開始日期
    :param end: 結束日期
    :return:
    """
    days = H_Calendar.objects.filter(date__gte=start, date__lte=end).order_by('date')
    return [day.red_day for day in days]
