from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Shift
from .forms import (ShiftCreationForm, ShiftEditForm)
from demand.models import DemandOfStation
from datetime import datetime
from copy import copy

"""
班別管理
"""


# 建立班別
@login_required
def shift_create(request):
    form = ShiftCreationForm()

    if request.method == 'POST':
        form = ShiftCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/shifts/list')

    context = {'form': form}

    return render(request, 'shifts/shiftCreate.html', context)


def int_to_time_str(num):
    show_data = str(copy(num))
    if len(show_data) < 2:
        show_data = '0' + show_data
    return show_data


# 班別列表
@login_required
def shift_list(request):
    global int_to_time_str

    shifts = Shift.objects.all()
    field_names = [(0, 'name'), (1, 'shift_type'), (4, 'department')]

    context = {'shifts': shifts, 'field_names': field_names}

    return render(request, 'shifts/shiftList.html', context)


# 編輯班別
@login_required
def shift_edit(request, id=None):
    id = int(id)
    shift = Shift.objects.get(id=id)
    form = ShiftEditForm(request.POST or None, instance=shift)
    if form.is_valid():
        form.save()
        return redirect('/shifts/list')

    context = {'form': form, 'target': shift}
    return render(request, 'shifts/shiftEdit.html', context)


# 刪除班別
@login_required
def shift_delete(request, id=None):

    shift = Shift.objects.get(id=id)
    if request.user.is_staff:
        shift.delete()
        return redirect("/shifts/list")
    else:
        return redirect("/shifts/list")


def get_shifts(department):
    shifts = Shift.objects.filter(department=department, shift_type__in=[0, 1, 2])
    return shifts
