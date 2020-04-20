import os
import pathlib
import random
import sys
from datetime import timedelta
import django
from django.utils import timezone
from django.shortcuts import render, redirect

back = os.path.dirname
BASE_DIR = back(back(os.path.abspath(__file__)))
sys.path.append(BASE_DIR)


def initial(request):
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "schedule.settings")
    django.setup()
    from account.models import CustomUser as User
    from account.models import Department
    if User.objects.all():
        print('clean database')
        User.objects.all().delete()
# superuser
        print('create a super user')
        user = User.objects.create_superuser(
            'circlepen', 'lyle.lai@redfalcon-hpc.com', 'redfalcon')
# departments
    for d in Department.objects.all():
        d.delete()
    department = Department.objects.create(name='RD', detail='研發部')
    department.save()
    print('finish')
    return redirect('/')
