from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import DemandOfStation
from .forms import (DemandCreationForm, DemandEditForm)
from collections import defaultdict
import json

"""
人力需求管理
"""


# 建立需求
@login_required
def demand_create(request):
    form = DemandCreationForm()

    if request.method == 'POST':
        form = DemandCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/demands/list')

    context = {'form': form}

    return render(request, 'demands/demandCreate.html', context)


# 需求列表
@login_required
def demand_list(request):
    demands = DemandOfStation.objects.all()
    stations = set((x.shift.station for x in demands))
    stations = list(stations)
    demand_dict = defaultdict(lambda: defaultdict(dict))
    for demand in demands:
        demand_dict[demand.shift.station.name][str(demand.shift)][demand.level] = {
            'weekday': demand.weekday,
            'holiday': demand.holiday,
        }
    field_names = [(0, 'station')]
    context = {
        'demands': json.dumps(dict(demand_dict)),
        'stations': stations,
        'field_names': field_names,
    }
    return render(request, 'demands/demandList.html', context)


# 編輯需求
@login_required
def demand_edit(request):

    demand = DemandOfStation.objects.get(id=id)
    form = DemandEditForm(request.POST or None, instance=demand)
    if form.is_valid():
        form.save()
        return redirect('/demands/list')

    context = {'form': form, 'target': demand}
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
