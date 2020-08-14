from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.utils.translation import gettext_lazy as _
import datetime
import calendar
from scripts.get_date_range import *
from collections import defaultdict
from .models import Reservation, PromiseShift


@login_required
def reserve(request):
    start, end = date_range(1, 3)
    max_reserve = request.user.department.limit_pre_schedule
    context = {
        'LANG': request.LANGUAGE_CODE,
        'start': start,
        'end': end,
        'max': max_reserve,
    }

    return render(request, 'calendars/reserve_holiday.html', context)


@login_required
def promises(request):
    start, end = date_range(1, 12)
    context = {
        'LANG': request.LANGUAGE_CODE,
        'start': start,
        'end': end,
    }

    return render(request, 'calendars/promise_shift.html', context)


def get_reserve_leave(department, date_start, date_end):
    """
    取得部門中所有可工作人員的預排假
    :return:
    """
    output = defaultdict(list)
    reservations = Reservation.objects.filter(user__department=department, date__gte=date_start, date__lte=date_end)
    for reservation in reservations:
        output[reservation.user.id].append(reservation.date)
    return output


def get_promise_leave(department, date_start, date_end):
    output = defaultdict(list)
    promise_rests = PromiseShift.objects.filter(user__department=department, date__gte=date_start, date__lte=date_end,
                                                shift_type=5)
    for pr in promise_rests:
        output[pr.user.id].append(pr.date)
    return output


def get_official_leave(department, date_start, date_end):
    output = defaultdict(list)
    official_leaves = PromiseShift.objects.filter(user__department=department, date__gte=date_start, date__lte=date_end,
                                                  shift_type=3)
    for ol in official_leaves:
        output[ol.user.id].append(ol.date)
    return output
