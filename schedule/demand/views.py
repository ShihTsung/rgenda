from django.shortcuts import render, redirect, HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import DemandOfStation
from .forms import (DemandCreationForm, DemandEditForm)
from collections import defaultdict
from shift.models import Shift
from station.models import Station
from datetime import datetime, timedelta
from date.views import attr_list, red_list
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
    form.fields['station'].queryset = Station.objects.filter(
        department=department)
    is_super = request.user.is_superuser
    if request.method == 'POST':
        form = DemandCreationForm(request.POST)
        if form.is_valid():
            for is_senior in [True, False]:
                demend = DemandOfStation.objects.create(
                    shift=Shift.objects.get(id=request.POST.get('shift')),
                    station=Station.objects.get(
                        id=request.POST.get('station')),
                    is_senior=is_senior,
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
            demand_dict[demand.station.department.name + '-' + demand.station.name][demand.shift.name][demand.level] = {
                'config1': demand.config1,
                'config2': demand.config2,
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
                    demand.config1 = val
                if key[-1] == 'h':
                    demand.config2 = val
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
                'config1': demand.config1,
                'config2': demand.config2,
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


def get_demands(department, start_date, end_date, group_by_level=False):
    date_list = [start_date + timedelta(days=i)
                 for i in range((end_date - start_date).days + 1)]
    attrs = attr_list(start_date, end_date)

    reds = red_list(start_date, end_date)
    output = {
        '白班': dict(),
        '小夜': dict(),
        '大夜': dict(),
    }
    demands = {
        '白班': DemandOfStation.objects.filter(shift__department=department, shift__shift_type='白班'),
        '小夜': DemandOfStation.objects.filter(shift__department=department, shift__shift_type='小夜'),
        '大夜': DemandOfStation.objects.filter(shift__department=department, shift__shift_type='大夜'),
    }
    if group_by_level:
        for st in ['白班', '小夜', '大夜']:
            for i, d in enumerate(date_list):
                output[st][str(d)] = {
                    1: 0,
                    2: 0,
                    3: 0,
                    4: 0,
                }
                output[st][str(d)]['red'] = reds[i]
                for demand in demands[st]:
                    if attrs[i] == 'workday':
                        output[st][str(d)][demand.level] += demand.workday
                    elif attrs[i] == 'holiday':
                        output[st][str(d)][demand.level] += demand.holiday
    else:
        for st in ['白班', '小夜', '大夜']:
            for i, d in enumerate(date_list):
                output[st][str(d)] = {
                    1: dict(),
                    2: dict(),
                    3: dict(),
                    4: dict(),
                }

                for demand in demands[st]:
                    if attrs[i] == 'workday':
                        output[st][str(d)][demand.level][str(demand.station)] = demand.workday
                    elif attrs[i] == 'holiday':
                        output[st][str(d)][demand.level][str(demand.station)] = demand.holiday
                    else:
                        output[st][str(d)][demand.level][str(demand.station)] = 0
    return output
