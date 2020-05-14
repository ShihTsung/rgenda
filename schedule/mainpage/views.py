# django modules
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from account.models import CustomUser


# 回傳所有員工類別的統計
def get_employee_status(dpmt):
    users = CustomUser.objects.filter(department=dpmt)
    return_data = [0, 0, 0, 0]
    for user in users:
        if user.type_of_user == 'Normal':
            return_data[0] += 1
        elif user.type_of_user == 'Pragnant':
            return_data[1] += 1
        elif user.type_of_user == 'Intern':
            return_data[2] += 1
        elif user.type_of_user == 'PartTime':
            return_data[3] += 1
        else:
            continue
    return return_data

# 首頁，分為使用者與管理者兩種
@login_required
def index(request):
    n, p, i, pt = get_employee_status(request.user.department)
    context = {
        'LANG': request.LANGUAGE_CODE,
        'Normal': n,
        'Pragnant': p,
        'Intern': i,
        'PartTime': pt
    }
    if request.user.is_staff:
        return render(request, 'mainpage/manager_index.html', context)
    else:
        return render(request, 'mainpage/employee_index.html', context)


def handler404(request, exception, template_name="404.html"):
    response = render(request, template_name)
    response.status_code = 404
    return response


def handler500(request, *args, **argv):
    response = render(request, '500.html', {})
    response.status_code = 500
    return response
