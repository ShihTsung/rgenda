from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Condition
from .forms import ConditionEditForm
from account.models import Department
from collections import defaultdict

"""
排班條件管理
"""


# 建立條件
@login_required
def condition_create(request):
    departments = Department.objects.all()
    for department in departments:
        condition = Condition.objects.create(
            department=department,
        )
        condition.save()
    return redirect("/condition/list")


# 條件列表
@login_required
def condition_list(request):
    conditions = Condition.objects.all()
    context = {
        'conditions': conditions,
        'field_names': {
            'Department': 0,
        },
    }
    return render(request, 'condition/conditionList.html', context)


# 編輯條件
@login_required
def condition_edit(request, id=None):
    condition = Condition.objects.get(id=id)
    form = ConditionEditForm(request.POST or None, instance=condition)
    if form.is_valid():
        form.save()
        return redirect('/condition/list')

    context = {'form': form, 'target': condition}
    return render(request, 'condition/conditionEdit.html', context)


# 刪除條件
@login_required
def condition_delete(request, id=None):
    condition = Condition.objects.get(id=id)
    if request.user.is_staff:
        condition.delete()
        return redirect("/condition/list")
    else:
        return redirect("/condition/list")