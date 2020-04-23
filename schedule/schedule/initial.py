import os
import pathlib
import random
import sys
import datetime
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
    from date.models import Oneday
    from station.models import Station
    from shift.models import Shift

    print('clean database')
    User.objects.all().delete()
# superuser
    print('create a super user')
    user = User.objects.create_superuser(
        'circlepen', 'lyle.lai@redfalcon-hpc.com', 'redfalcon')
# departments
    for d in Department.objects.all():
        d.delete()
    print('create departments')
    department = Department.objects.create(name='RD', detail='研發部')
    department.save()
    department = Department.objects.create(name='FC', detail='財務部')
    department.save()

# days

    print('create days')
    for d in Oneday.objects.all():
        d.delete()
    daystmp = datetime.datetime.strptime('2020-01-01', '%Y-%m-%d')
    work_or_holiday = ""

    for i in range(520):
        if daystmp.weekday() in [5, 6]:
            work_or_holiday = "holiday"
        else:
            work_or_holiday = "workday"
        newday = Oneday.objects.create(date=daystmp, attribute=work_or_holiday)
        newday.save()
        daystmp += datetime.timedelta(days=1)

    # station
    print('create station')
    for s in Station.objects.all():
        s.delete()
    department = Department.objects.first()
    station = Station.objects.create(name="station1", department=department)
    station.save()

    print('create shift')
    shift = Shift.objects.create(
        name="shift1",
        shift_type="白班",
        start_hour=8,
        start_min=0,
        end_hour=16,
        end_min=30
    )
    shift.save()

    print('finish')

    return redirect('/')
