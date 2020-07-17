from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Station
from .forms import (StationCreationForm, StationEditForm)
from shift.models import Shift
from demand.models import DemandOfStation
"""
工作站管理
"""

# 建立工作站
@login_required
def station_create(request):
    form = StationCreationForm()

    if request.method == 'POST':
        form = StationCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/stations/list')

    context = {'form': form}

    return render(request, 'stations/stationCreate.html', context)


# 工作站列表
@login_required
def station_list(request):
    stations = Station.objects.order_by('name')
    field_names = [(0, 'name'), (1, 'department')]
    context = {'stations': stations, 'field_names': field_names}

    return render(request, 'stations/stationList.html', context)


# 編輯工作站
@login_required
def station_edit(request, id=None):

    station = Station.objects.get(id=id)
    form = StationEditForm(request.POST or None, instance=station)
    if form.is_valid():
        form.save()
        return redirect('/stations/list')

    context = {'form': form, 'target': station}
    return render(request, 'stations/stationEdit.html', context)


# 刪除工作站
@login_required
def station_delete(request, id=None):

    station = Station.objects.get(id=id)
    if request.user.is_staff:
        station.delete()
        return redirect("/stations/list")
    else:
        return redirect("/stations/list")
