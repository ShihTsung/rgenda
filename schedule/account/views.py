from django.shortcuts import render, redirect
from django.forms import inlineformset_factory
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import UserCreationForm, PasswordChangeForm
from django.contrib import messages
from django.contrib.auth import update_session_auth_hash


# Create your views here.
from .models import TYPE_CHOICES, CustomUser, Department, DepartmentManager
from .forms import CustomUserCreationForm, CustomUserChangeForm, ImportForm
from .forms import DepartmentChangeForm, DepartmentCreationForm
from django.http import FileResponse
from datetime import datetime, timedelta, time
from django.templatetags.static import static
from collections import defaultdict
import openpyxl
from station.models import Station
from shift.models import Shift
from notifications.signals import notify
from datetime import time
from numpy.random import choice
from result.models import ExchangeApplication


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
            form.save()
            user = form.cleaned_data.get('username')
            messages.success(request, f"使用者 {user} 新增成功！")
            return redirect('/accounts/list')
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
        manager_num = defaultdict(int)
        for user in users:
            if user.role == 'manager':
                manager_num[user.department.detail] += 1
        departments = [
            department.detail for department in Department.objects.all()]
        for row in ws.iter_rows(values_only=True, max_row=1):
            row0 = row
        if row0 != (None, '帳號', '密碼', '電子信箱', '員工編號', '姓名', '科別', '職稱', '職級', '性別', '權限', '排班身份', '其他', '排班狀況', '到職日'):
            messages.error(request, row0)
            print(row0)
            return redirect('/accounts/list')
        for row in ws.iter_rows(values_only=True, min_row=2):
            if row[0] == '範例':
                continue
            error_message = check_excel(
                row, usernames, departments, eids, manager_num, raw_data)
            if error_message == 'END':
                break
            elif error_message:
                messages.error(request, '' + error_message)
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
                type_of_user=raw_data[name]['user type'],
                eid=raw_data[name]['employee id'],
                onboard_date=raw_data[name]['onboard date'],
                pregnant=raw_data[name]['pregnant'],
                can_be_scheduled=raw_data[name]['can be scheduled'],
                job_title=raw_data[name]['job title'],
            )
            user.set_password(raw_data[name]['password'])
            user.save()
        messages.success(request, '使用者建立成功!')
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


def check_excel(row, users, departments, eids, manager_num, data):
    """
    :param row: (
            0:
            1: 帳號
            2: 密碼
            3: 電子信箱
            4: 員工編號
            5: 姓名
            6: 科別
            7: 職稱
            8: 職級
            9: 性別
            10: 權限
            11: 排班身份
            12: 其他
            13: 排班狀況
            14: 到職日
        )
    :param users:
    :param departments:
    :param eids:
    :param data:
    :return:
    """
    role_dict = {
        'N1': 1,
        'N2': 2,
        'N3': 3,
        'N4': 4,
        'Nn': 5,
    }
    user_type_dict = {
        '正職人員': 0,
        '資深正職人員': 1,
        '行政職人員': 2,
        '新進人員': 3,
        '兼職人員': 4,
        '實習生': 5,
    }
    if not row[1]:
        return 'END'
    if row[1] in users:
        return '第' + str(row[0]) + '筆 "帳號"重複'
    users.append(row[1])

    if not row[2]:
        return '第' + str(row[0]) + '筆 "密碼"不可空白'

    if not row[3]:
        return '第' + str(row[0]) + '筆 "電子信箱"不可空白'
    if '@' not in row[3]:
        return '第' + str(row[0]) + '筆 "電子信箱"格式不符'

    if not row[4]:
        return '第' + str(row[0]) + '筆 "員工編號"不可空白'
    if row[4] in eids:
        return '第' + str(row[0]) + '筆 "員工編號"重複'
    eids.append(row[4])

    if not row[5]:
        return '第' + str(row[0]) + '筆 "姓名"不可空白'

    if not row[6]:
        return '第' + str(row[0]) + '筆 "科別"不可空白'
    if not row[6] in departments:
        return '第' + str(row[0]) + '筆 "科別"不存在'

    if not row[7]:
        return '第' + str(row[0]) + '筆 "職稱"不可空白'

    if not row[8]:
        return '第' + str(row[0]) + '筆 "職級"不可空白'
    if not row[8] in ['N1', 'N2', 'N3', 'N4', 'Nn']:
        return '第' + str(row[0]) + '筆 "職級"格式不符'

    if not row[9]:
        return '第' + str(row[0]) + '筆 "性別"不可空白'
    if not row[9] in ['男', '女']:
        return '第' + str(row[0]) + '筆 "性別"請填 男/女'

    if not row[10]:
        return '第' + str(row[0]) + '筆 "權限"不可空白'
    if not row[10] in ['管理員', '使用者']:
        return '第' + str(row[0]) + '筆 "權限"請填 管理員/使用者'
    if row[10] == '管理員':
        manager_num[row[6]] += 1
        if manager_num[row[6]] > 2:
            return '第' + str(row[0]) + '筆 該科管理員人數超過2位'

    if not row[11]:
        return '第' + str(row[0]) + '筆 "排班身份"不可空白'
    if not row[11] in ['資深正職人員', '正職人員', '行政職人員', '新進人員', '兼職人員', '實習生']:
        return '第' + str(row[0]) + '筆 "排班身份"請填 資深正職人員/正職人員/行政職人員/新進人員/兼職人員/實習生'

    if not row[12]:
        return '第' + str(row[0]) + '筆 "其他"不可空白'
    if not row[12] in ['無', '妊娠或哺乳期']:
        return '第' + str(row[0]) + '筆 "其他"請填 無/妊娠或哺乳期'

    if not row[13]:
        return '第' + str(row[0]) + '筆 "排班狀況"不可空白'
    if not row[13] in ['正常排班', '暫停排班']:
        return '第' + str(row[0]) + '筆 "其他"請填 正常排班/暫停排班'

    if not row[14]:
        return '第' + str(row[0]) + '筆 "到職日"不可空白'
    if not type(row[14]) is datetime:
        return '第' + str(row[0]) + '筆 "到職日"格式不符'

    data[row[1]] = {
        'password': row[2],
        'email address': row[3],
        'employee id': row[4],
        'full name': row[5],
        'department': Department.objects.get(detail=row[6]),
        'level': role_dict[row[8]],
        'gender': 'male' if row[9] == '男' else 'female',
        'role': 'manager' if row[10] == '管理員' else 'user',
        'user type': user_type_dict[row[11]],
        'pregnant': True if row[12] == '妊娠或哺乳期' else False,
        'can be scheduled': True if row[13] == '正常排班' else False,
        'onboard date': row[14],
        'job title': str(row[7]),
    }
    return ''


@login_required
def download_empty_excel(request):
    file = open('static/RgendaUsers.xlsx', 'rb')
    return FileResponse(file)


# 使用者詳細資料
@login_required
def userDetail(request, id):
    user = CustomUser.objects.get(id=id)
    colors = ["#EAEAEA", '#A6C2CE', '#84B1ED', '#37419A']
    if user.level <= 4:
        user_color = colors[user.level-1]
    else:
        user_color = '#000000'

    user.gender_text = '男' if user.gender == 'male' else '女'
    user.type_of_user_text = TYPE_CHOICES[user.type_of_user][1]

    applications = ExchangeApplication.objects.filter(user_receive=user)
    unused = user.special_rest_num - user.special_rest_num_used
    rules = ['一般工時，7休2', '雙週變形工時，14休4',
             '四週變形工時，28休8', '八週變形工時，56休16']
    rule = rules[user.department.law_rule]
    return render(request,
                  'registration/detail.html',
                  {'target_user': user,
                   'user_color': user_color,
                   'applications': applications,
                   'unused': unused,
                   'rule': rule})


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
            messages.error(request, "權限不足")
            return redirect('/accounts/list')
    form = CustomUserChangeForm(request.POST or None, instance=choosed_user)

    if request.method == 'POST' and form.is_valid():
        form.save()
        if form.cleaned_data['pregnant'] == True:
            user = CustomUser.objects.get(id=id)
            user.can_be_scheduled = False
            user.save()
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
            names = ['休息', '例假', '公假', 'oncall', '事假', '家庭照顧假', '無薪病假', '產假', '生理假', '特休', '補休', '婚假',
                     '計薪病假', '喪假', '安胎休養假', '產檢假', '陪產假']
            types = [5, 5, 3, 4, 6, 6, 6, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
            hours = [0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            for i in range(len(names)):
                shift = Shift.objects.create(
                    name=names[i],
                    shift_type=types[i],
                    start_time=time(hour=0, minute=0),
                    end_time=time(hour=0, minute=0),
                    department=department,
                    work_hours=hours[i])
            shift = Shift.objects.create(
                name='白班',
                shift_type=0,
                start_time=time(hour=7, minute=0),
                end_time=time(hour=16, minute=0),
                department=department,
                work_hours=8)
            shift = Shift.objects.create(
                name='小夜',
                shift_type=1,
                start_time=time(hour=15, minute=0),
                end_time=time(hour=0, minute=0),
                department=department,
                work_hours=8)
            shift = Shift.objects.create(
                name='大夜',
                shift_type=2,
                start_time=time(hour=23, minute=0),
                end_time=time(hour=8, minute=0),
                department=department,
                work_hours=8)
            shift = Shift.objects.create(
                name='行政',
                shift_type=0,
                start_time=time(hour=8, minute=0),
                end_time=time(hour=17, minute=0),
                department=department,
                work_hours=8)
            for name in ['休假', '公假', '行政']:
                Station.objects.create(department=department, name=name)
            messages.success(
                request,
                f'科別 {department.name} 新增成功'
            )
            notify.send(
                sender=request.user,
                recipient=CustomUser.objects.all(),
                target=department,
                level='info',
                verb=f'{request.user.full_name} 建立了新的科別',
                description='/departments/list')
            return redirect('/departments/list')
    context = {'form': form}
    return render(request, 'department/departmentCreate.html', context)


# 部門清單
@login_required
def departmentList(request):
    if request.user.role == 'admin':
        departments = Department.objects.all()
    else:
        departments = Department.objects.get(
            id=request.user.department.id
        )
    field_names = [
        (0, 'name'),
        (1, 'detail'),
    ]
    users = CustomUser.objects.all()
    context = {
        'departments': departments,
        'field_names': field_names,
        'users': users,
    }
    return render(request, 'department/departmentList.html', context)


@login_required
def departmentDetail(request, id):
    department = Department.objects.get(id=id)
    managers = CustomUser.objects.filter(role='manager', department=department)
    context = {
        'department': department,
        'managers': managers,
    }
    return render(request, 'department/detail.html', context)


def get_or_none(classmodel, **kwargs):
    try:
        return classmodel.objects.get(**kwargs)
    except classmodel.DoesNotExist:
        return None

# 編輯部門
@login_required
def departmentEdit(request, id=None):
    id = int(id)
    department = Department.objects.get(id=id)
    form = DepartmentChangeForm(request.POST or None,
                                instance=department,
                                )
    if form.is_valid() and request.method == "POST":
        form.save()
        mgrtable = get_or_none(DepartmentManager, department=department)
        mgr1 = int(form.data['mgr1']) if form.data['mgr1'] else None
        mgr2 = int(form.data['mgr2']) if form.data['mgr2'] else None
        mgr1_obj = get_or_none(CustomUser, id=mgr1)
        mgr2_obj = get_or_none(CustomUser, id=mgr2)

        if mgrtable:
            mgrtable.manager_one = mgr1_obj
            mgrtable.manager_two = mgr2_obj
        else:
            mgrtable = DepartmentManager.objects.create(
                department=department,
                manager_one=mgr1_obj,
                manager_two=mgr2_obj
            )
        new_managers = [form.data['mgr1'], form.data['mgr2']]
        users = CustomUser.objects.filter(department=department)
        for user in users:
            if user.role != 'admin':
                if str(user.id) in new_managers:
                    user.role = 'manager'
                else:
                    user.role = 'user'
                user.save()
        return redirect('/departments/list')

    context = {'form': form, 'target': department, 'id': id}
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


def cycle_analysis(department, input_date):
    date_start = department.date_start
    rule = department.law_rule
    date_diff = (input_date - date_start).days
    return {
        'cycle_no': date_diff // (7 * 2 ** rule),
        'day_no': date_diff % (7 * 2 ** rule),
    }


def get_cycle(department, cycle_no):
    date_first = department.date_start + timedelta(
        days=7 * 2 ** department.law_rule * cycle_no)

    return [date_first + timedelta(days=i) for i in range(
        7 * 2 ** department.law_rule)]


def assign_user(department, proportion):
    """
    依照比例分配白班/小夜/大夜值班名單並盡量符合人員分級
    尚未加入部分人員不值特定班種的分配
    待處理: 孕婦不值 pm 22:00 ~ am 6:00 的班
    :param department:
    :param proportion:
    :return:
    """
    users = {
        4: CustomUser.objects.filter(department=department, can_be_scheduled=True, level=4),
        3: CustomUser.objects.filter(department=department, can_be_scheduled=True, level=3),
        2: CustomUser.objects.filter(department=department, can_be_scheduled=True, level=2),
        1: CustomUser.objects.filter(department=department, can_be_scheduled=True, level=1),
    }
    users_nums = {
        4: len(users[4]),
        3: len(users[3]),
        2: len(users[2]),
        1: len(users[1]),
        'sum': 0,
    }
    users_nums['sum'] = sum(users_nums.values())

    proportion_sum = proportion['白班']['sum'] + \
        proportion['小夜']['sum'] + proportion['大夜']['sum']
    count_output = {
        '白班': round(users_nums['sum'] * proportion['白班']['sum'] / proportion_sum),
        '小夜': round(users_nums['sum'] * proportion['小夜']['sum'] / proportion_sum),
        '大夜': round(users_nums['sum'] * proportion['大夜']['sum'] / proportion_sum),
    }
    output = {
        '白班': {
            1: list(),
            2: list(),
            3: list(),
            4: list(),
        },
        '小夜': {
            1: list(),
            2: list(),
            3: list(),
            4: list(),
        },
        '大夜': {
            1: list(),
            2: list(),
            3: list(),
            4: list(),
        },
    }
    user_pool = list()
    for i in [4, 3, 2]:
        user_pool += users[i]
        quota = dict()
        if proportion['白班'][i] + proportion['小夜'][i] + proportion['大夜'][i] > len(user_pool):
            total = proportion['白班'][i] + \
                proportion['小夜'][i] + proportion['大夜'][i]
            quota['白班'] = min(
                round(len(user_pool) * proportion['白班'][i] / total), count_output['白班'])
            quota['小夜'] = min(
                round(len(user_pool) * proportion['小夜'][i] / total), count_output['小夜'])
            quota['大夜'] = min(
                round(len(user_pool) * proportion['大夜'][i] / total), count_output['大夜'])
        else:
            quota['白班'] = min(proportion['白班'][i], count_output['白班'])
            quota['小夜'] = min(proportion['小夜'][i], count_output['小夜'])
            quota['大夜'] = min(proportion['大夜'][i], count_output['大夜'])
        for st in quota:
            if quota[st]:
                chosen_users = choice(user_pool, quota[st], replace=False)
                for user in chosen_users:
                    user_pool.remove(user)
                    output[st][user.level].append(user)
                    count_output[st] -= 1
    user_pool += users[1]
    for st in count_output:
        if count_output[st]:
            chosen_users = choice(user_pool, count_output[st], replace=False)
            for user in chosen_users:
                user_pool.remove(user)
                output[st][user.level].append(user)
    return output


def license_audit(request):
    return render(request, 'registration/license.html')
