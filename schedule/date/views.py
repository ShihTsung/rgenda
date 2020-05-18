from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Oneday


@login_required
def date_manage(request):
    context = {'LANG': request.LANGUAGE_CODE}
    return render(request, 'calendars/date_manage.html', context)


def attr_list(start, end):
    days = Oneday.objects.filter(date__gte=start, date__lte=end).order_by('date')
    return [day.attribute for day in days]