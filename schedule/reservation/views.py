from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.utils.translation import gettext_lazy as _
import datetime
import calendar
from scripts.get_date_range import range
from condition.models import Condition


@login_required
def reserve(request):
    start, end = range()
    condition = Condition.objects.get(department=request.user.department)
    max_reserve = condition.limit_pre_schedule
    context = {
        'LANG': request.LANGUAGE_CODE,
        'start': start,
        'end': end,
        'max': max_reserve
    }

    return render(request, 'calendars/reserve_holiday.html', context)


@login_required
def promises(request):
    start, end = range()

    context = {
        'LANG': request.LANGUAGE_CODE,
        'start': start,
        'end': end
    }

    return render(request, 'calendars/promise_shift.html', context)
