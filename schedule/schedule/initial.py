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
    from condition.models import Condition
    from demand.models import DemandOfStation

    print('clean database')
    User.objects.all().delete()

# departments
    for d in Department.objects.all():
        d.delete()
    print('create departments')
    department = Department.objects.create(name='RD', detail='研發部')
    condition = Condition.objects.create(
        department=department,
    )
    condition.save()
    department.save()
    department = Department.objects.create(name='FC', detail='財務部')
    condition = Condition.objects.create(
        department=department,
    )
    condition.save()
    department.save()

# superuser
    print('create a super user')
    user = User.objects.create_superuser(
        'circlepen', 'lyle.lai@redfalcon-hpc.com', 'redfalcon')
    user.role = 'admin'
    user.full_name = 'YiJu Lai'
    user.level = 3
    user.gender = 'male'
    user.holiday_rest_num = 10
    user.special_rest_num = 10
    user.eid = 20190022
    user.hour_required = 100.0
    user.hour_realized = 0.0
    user.department = Department.objects.first()
    user.save()


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
    names = ['Request', 'Off', '公假']
    types = ['休假', '休假', '公假']
    hours = [0, 0, 8]

    for i in range(3):
        shift = Shift.objects.create(
            name=names[i],
            shift_type=types[i],
            start_hour=24,
            start_min=0,
            end_hour=24,
            end_min=0,
            station=Station.objects.last(),
            work_hours=hours[i])
        shift.save()
    station.save()

# shift
    print('create shift')
    shift = Shift.objects.create(
        name="shift1",
        shift_type="白班",
        start_hour=8,
        start_min=0,
        end_hour=16,
        end_min=30,
        station=Station.objects.first()
    )
    for i in range(1, 5):
        demand = DemandOfStation.objects.create(
            shift=shift,
            level=i,
            weekday=0,
            holiday=0
        )
        demand.save()
    shift.save()

    print('finish')

    return redirect('/')
