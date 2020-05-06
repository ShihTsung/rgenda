from django.shortcuts import render, redirect
from django.forms import inlineformset_factory
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import UserCreationForm, PasswordChangeForm
from django.contrib import messages
from django.contrib.auth import update_session_auth_hash


# Create your views here.
from .models import CustomUser, Department
from .forms import CustomUserCreationForm, CustomUserChangeForm, ImportForm
from .forms import DepartmentChangeForm, DepartmentCreationForm
from condition.models import Condition
from django.http import HttpResponse
import openpyxl
from datetime import datetime

"""
帳號管理
"""


# 新增使用者
@login_required
def registerPage(request):
    form = CustomUserCreationForm()
    is_super = request.user.is_superuser
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            # admin 才能建立 admin 帳號
            if form.cleaned_data.get('role') == 'admin':
                if request.user.role == 'admin' or is_super:
                    form.save()
                else:
                    messages.error(request, "Permission denied")
                    return redirect('/accounts/list')
            if form.cleaned_data.get('role') == 'manager':
                if request.user.role in ['manager', 'admin'] or is_super:
                    form.save()
                else:
                    messages.error(request, "Permission denied")
                    return redirect('/accounts/list')

            user = form.cleaned_data.get('username')
            messages.success(request, "Account was created for " + user)
    context = {'form': form}
    return render(request, 'registration/register.html', context)


# 使用者清單
@login_required
def userList(request):
    # admin 或 開發者顯示全部使用者，不然只會顯示同部門的使用者

    form = ImportForm()
    if request.method == 'POST':
        file = request.FILES['file']
        wb = openpyxl.load_workbook(file)
        try:
            ws = wb['Users']
        except KeyError:
            messages.error(request, 'Wrong sheet in the file')
            return redirect('/accounts/list')
        row0 = None
        raw_data = dict()
        users = CustomUser.objects.all()
        usernames = [user.username for user in users]
        eids = [user.eid for user in users]
        departments = [department.name for department in Department.objects.all()]
        for row in ws.iter_rows(values_only=True, max_row=1):
            row0 = row
        if row0 != ('Username', 'Email address', 'Full name', 'Department', 'Level', 'Gender', 'Role', 'Can Be Scheduled', 'Type', 'Employee ID', 'Onboard Date'):
            messages.error(request, row0)
            return redirect('/accounts/list')
        for row in ws.iter_rows(values_only=True, min_row=3):
            error_message = check_excel(row, usernames, departments, eids, raw_data)
            if error_message:
                messages.error(request, error_message)
                return redirect('/accounts/list')
        for name in raw_data:
            user = CustomUser(
                username=name,
                email=raw_data[name]['email address'],
                department=raw_data[name]['department'],
                full_name=raw_data[name]['full name'],
                level=raw_data[name]['level'],
                role=raw_data[name]['role'],
                gender=raw_data[name]['gender'],
                type_of_user=raw_data[name]['type'],
                can_be_scheduled=raw_data[name]['can be scheduled'],
                eid=raw_data[name]['employee id'],
                onboard_date=raw_data[name]['onboard date'],
            )
            user.save()
            messages.success(request, 'Users import success')
        return redirect('/accounts/list')
    if request.user.role == 'admin' or request.user.is_superuser:
        users = CustomUser.objects.all()
    else:
        users = CustomUser.objects.filter(department=request.user.department)

    field_names = [
        (0, 'username'),
        (1, 'name'),
        (3, 'role'),
        (4, 'department')
    ]
    context = {
        'users': users,
        'field_names': field_names,
        'form': form,
        'modal_form_title': 'Import User',
    }
    return render(request, 'registration/userList.html', context)


def check_excel(row, users, departments, eids, data):
    """
    :param row: (
            0: Username,
            1: Email Address,
            2: Full name,
            3: Department,
            4: Level,
            5: Gender,
            6: Role,
            7: Can Be Scheduled,
            8: Type,
            9: Employee ID,
            10: Onboard Date,
        )
    :param users:
    :param departments:
    :param eids:
    :param data:
    :return:
    """
    if row[0] in users or row[0] in data:
        return 'Repeat "username" ' + row[0]
    if row[1] and '@' not in row[1]:
        return 'Invalid "email address" for ' + row[0]
    if not row[2]:
        return '"Full name" is required for ' + row[0]
    if not row[3]:
        return '"Department" is required for ' + row[0]
    if not row[3] in departments:
        return 'Invalid "department" for ' + row[0]
    if not row[4]:
        return '"Level" is required for ' + row[0]
    if not row[4] in [1, 2, 3]:
        return 'Invalid "level" for ' + row[0]
    if not row[5]:
        return '"Gender" is required for ' + row[0]
    if not row[5] in ['M', 'F']:
        return 'Invalid "gender" for ' + row[0]
    if not row[6]:
        return '"Role" is required for ' + row[0]
    if not row[6] in ['admin', 'manager', 'user']:
        return 'Invalid "role" for ' + row[0]
    if not row[7]:
        return '"Can be scheduled" is required for ' + row[0]
    if not row[7] in ['Y', 'N']:
        return 'Invalid "can be scheduled" for ' + row[0]
    if not row[8]:
        return '"Type" is required for ' + row[0]
    if not row[8] in ['Normal', 'Pregnant', 'PartTime', 'Intern']:
        return 'Invalid "type" for ' + row[0]
    if not row[9]:
        return '"Employee ID" is required for ' + row[0]
    if str(row[9]) in eids:
        return '"Employee ID" is repeat for ' + row[0]
    eids.append(str(row[9]))
    if not row[10]:
        return '"Onboard date" is required for ' + row[0]
    if not type(row[10]) is datetime:
        return 'Invalid "onboard date" for ' + row[0] + ', ' + str(type(row[10]))
    data[row[0]] = {
        'email address': row[1],
        'full name': row[2],
        'department': Department.objects.get(name=row[3]),
        'level': row[4],
        'gender': row[5],
        'role': row[6],
        'can be scheduled': True if row[7] == 'Y' else False,
        'type': row[8],
        'employee id': row[9],
        'onboard date': row[10],
    }
    return ''


# 使用者詳細資料
@login_required
def detail(request, id):
    user = CustomUser.objects.get(id=id)
    return render(request, 'registration/detail.html', {'target_user': user})


# 刪除使用者資料
@login_required
def destroy(request, id=None):
    user = CustomUser.objects.get(id=id)
    # admin 不能刪除自己
    if request.user.role == 'admin' and request.user.id != user.id:
        name = user.username
        user.delete()
        messages.success(request, name+'已經被刪除')
        return redirect("/accounts/list")
    elif request.user.role == 'manager':
        if user.role not in ['manager', 'admin']:
            name = user.username
            user.delete()
            messages.success(request, name+'已經被刪除')
        return redirect("/accounts/list")
    else:
        return redirect("/accounts/list")


# 使用者資料編輯
@login_required
def update(request, id=None):
    id = int(id)
    choosed_user = CustomUser.objects.get(id=id)
    if choosed_user.is_superuser:
        if not request.user.is_superuser:
            # raise PermissionError("you don't have permission")
            messages.error(request, "you don't have permission ")
            return redirect('/accounts/list')
    form = CustomUserChangeForm(request.POST or None, instance=choosed_user)
    if form.is_valid():
        form.save()
        return redirect('/accounts/list')

    context = {'form': form, 'target': choosed_user}
    return render(request, 'registration/userEdit.html', context)


"""
部門管理
"""
# 新增部門


@login_required
def departmentCreate(request):
    form = DepartmentCreationForm()
    if request.method == 'POST':
        form = DepartmentCreationForm(request.POST)
        if form.is_valid():
            form.save()
            department = Department.objects.last()
            condition = Condition.objects.create(
                department=department,
            )
            condition.save()
            messages.success(request, "Department was created for "+department.name)
            return redirect('/departments/list')
    context = {'form': form}
    return render(request, 'department/departmentCreate.html', context)


# 部門清單
@login_required
def departmentList(request):
    departments = Department.objects.all()
    field_names = [
        (0, 'name'),
        (1, 'detail')
        ]
    context = {
        'departments': departments,
        'field_names': field_names
    }
    return render(request, 'department/departmentList.html', context)


# 編輯部門
@login_required
def departmentEdit(request, id=None):
    id = int(id)
    department = Department.objects.get(id=id)
    form = DepartmentChangeForm(request.POST or None, instance=department)
    if form.is_valid():
        form.save()
        return redirect('/departments/list')

    context = {'form': form, 'target': department}
    return render(request, 'department/departmentEdit.html', context)


# 刪除部門
@login_required
def departmentDelete(request, id=None):
    department = Department.objects.get(id=id)
    if request.user.is_staff:
        department.delete()
        return redirect("/departments/list")
    else:
        return redirect("/departments/list")
