from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages


@login_required
def date_manage(request):
    context = {'LANG': request.LANGUAGE_CODE}
    return render(request, 'calendars/date_manage.html', context)
