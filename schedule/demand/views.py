from django.shortcuts import render, redirect, HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import DemandOfStation
from .forms import (DemandCreationForm, DemandEditForm)
from collections import defaultdict
from shift.models import Shift
from station.models import Station
import json

"""
人力需求管理
"""


# 建立需求
@login_required
def demand_create(request):
    department = request.user.department
    form = DemandCreationForm()
    form.fields['shift'].queryset = Shift.objects.filter(department=department,
                                                         shift_type__in=['白班', '小夜', '大夜', 'oncall'])
    form.fields['station'].queryset = Station.objects.filter(department=department)
    is_super = request.user.is_superuser
    if request.method == 'POST':
        form = DemandCreationForm(request.POST)
        if form.is_valid():
            for level in [1, 2, 3, 4]:
                demend = DemandOfStation.objects.create(
                    shift=Shift.objects.get(id=request.POST.get('shift')),
                    station=Station.objects.get(id=request.POST.get('station')),
                    level=level,
                )
            return redirect('/demands/list')
    context = {'form': form}
    if request.user.role in ['admin', 'manager']:
        return render(request, 'demands/demandCreate.html', context)
    else:
        return redirect('/demands/list')


# 需求列表
@login_required
def demand_list(request):
    is_super = request.user.is_superuser
    demands = DemandOfStation.objects.all()
    demand_dict = defaultdict(lambda: defaultdict(dict))
    for demand in demands:
        cond1 = demand.station.department == request.user.department
        cond2 = request.user.role == 'admin'
        if cond1 or cond2 or is_super:
            demand_dict[demand.station.name][str(demand.shift)][demand.level] = {
                'weekday': demand.weekday,
                'holiday': demand.holiday,
            }
    field_names = [(0, 'station')]
    context = {
        'demands': json.dumps(dict(demand_dict)),
        'field_names': field_names,
    }
    return render(request, 'demands/demandList.html', context)


# 編輯需求
@login_required
def demand_edit(request):
    is_super = request.user.is_superuser
    if request.method == 'POST':
        for key, val in request.POST.items():
            if key != 'csrfmiddlewaretoken':
                demand = DemandOfStation.objects.get(pk=int(key[:-1]))
                if key[-1] == 'w':
                    demand.weekday = val
                if key[-1] == 'h':
                    demand.holiday = val
                demand.save()
        return redirect('/demands/list')
    demands = DemandOfStation.objects.all()
    demand_dict = defaultdict(lambda: defaultdict(dict))
    for demand in demands:
        cond1 = demand.station.department == request.user.department
        cond2 = request.user.role == 'admin'
        if cond1 or cond2 or is_super:
            demand_dict[demand.station.name][str(demand.shift)][demand.level] = {
                'id': demand.id,
                'weekday': demand.weekday,
                'holiday': demand.holiday,
                'LANG': request.LANGUAGE_CODE
            }
    form = DemandEditForm()
    context = {
        'demands': json.dumps(dict(demand_dict)),
        'form': form,
    }
    return render(request, 'demands/demandEdit.html', context)


# 刪除需求
@login_required
def demand_delete(request, id=None):

    demand = DemandOfStation.objects.get(id=id)
    if request.user.is_staff:
        demand.delete()
        return redirect("/demands/list")
    else:
        return redirect("/demands/list")
