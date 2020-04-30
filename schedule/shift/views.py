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
            last_shift = Shift.objects.last()
            for i in range(1, 4):
                demand = DemandOfStation.objects.create(
                    shift=last_shift,
                    level=i,
                    weekday=0,
                    holiday=0
                )
                demand.save()
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
    field_names = [(0, 'name'), (1, 'shift_type'), (4, 'station')]
    for shift in shifts:
        shift.show_start_hour = int_to_time_str(shift.start_hour)
        shift.show_start_min = int_to_time_str(shift.start_min)
        shift.show_end_hour = int_to_time_str(shift.end_hour)
        shift.show_end_min = int_to_time_str(shift.end_min)

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
