from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import DemandOfStation
from .forms import (DemandCreationForm, DemandEditForm)

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
    demand_dict = {x.name: [] for x in stations}
    for i in stations:
        for d in demands:
            if d.shift.station.name == i.name:
                demand_dict[i.name].append(d)
    output = []
    for k in demand_dict.keys():
        output.append(demand_dict[k])
    field_names = [(0, 'station'), (1, 'shift'), (2, 'level')]

    context = {
        'demands': demand_dict,
        'stations': stations,
        'field_names': field_names
               }

    return render(request, 'demands/demandList.html', context)


# 編輯需求
@login_required
def demand_edit(request, id=None):

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
