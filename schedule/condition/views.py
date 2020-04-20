from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Condition
from .forms import (ConditionCreationForm, ConditionEditForm)

"""
排班條件管理
"""

# 建立條件
@login_required
def condition_create(request):
    form = ConditionCreationForm()

    if request.method == 'POST':
        form = ConditionCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/conditions/list')

    context = {'form': form}

    return render(request, 'conditions/conditionCreate.html', context)


# 條件列表
@login_required
def condition_list(request):

    conditions = Condition.objects.all()
    context = {'conditions': condition_dict, 'stations': stations}

    return render(request, 'conditions/conditionList.html', context)


# 編輯條件
@login_required
def condition_edit(request, id=None):

    condition = Condition.objects.get(id=id)
    form = ConditionEditForm(request.POST or None, instance=condition)
    if form.is_valid():
        form.save()
        return redirect('/conditions/list')

    context = {'form': form, 'target': condition}
    return render(request, 'conditions/conditionEdit.html', context)


# 刪除條件
@login_required
def condition_delete(request, id=None):

    condition = Condition.objects.get(id=id)
    if request.user.is_staff:
        department.delete()
        return redirect("/conditions/list")
    else:
        return redirect("/conditions/list")