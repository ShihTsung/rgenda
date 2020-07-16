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
    from demand.models import DemandOfStation
    from result.models import Result, PreResult, AfterResult

    print('clean database')
    Department.objects.all().delete()
    User.objects.all().delete()
    Station.objects.all().delete()
    Shift.objects.all().delete()
    Oneday.objects.all().delete()
    Result.objects.all().delete()
    PreResult.objects.all().delete()
    AfterResult.objects.all().delete()

# departments
    print('create departments')
    department = Department.objects.create(name='RD', detail='研發部')
    station = Station.objects.create(
        department=department,
        name="None")
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
            department = department,
            work_hours=hours[i])
    department = Department.objects.create(name='FC', detail='財務部')
    station = Station.objects.create(
        department=department,
        name="None")
    for i in range(3):
        shift = Shift.objects.create(
            name=names[i],
            shift_type=types[i],
            start_hour=24,
            start_min=0,
            end_hour=24,
            end_min=0,
            department=department,
            work_hours=hours[i])

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
    print('create user')
    people = [{
        'name': 'Max',
        'email': 'max.chen@redfalcon-hpc.com',
        'password': 'redfalcon',
        'level': 3,
        'gender': 'male',
        'holiday_rest_num': 10,
        'special_rest_num': 10,
        'eid': 12345678,
        'hour_required': 100.0,
        'hour_realized': 0.0,
        'department': Department.objects.first()
    },
        {
        'name': 'Peter',
        'email': 'peter.chen@redfalcon-hpc.com',
        'password': 'redfalcon',
        'level': 4,
        'gender': 'male',
        'holiday_rest_num': 10,
        'special_rest_num': 10,
        'eid': 12345678,
        'hour_required': 100.0,
        'hour_realized': 0.0,
        'department': Department.objects.first()
    },
        {
        'name': 'Allison',
        'email': 'allison.chen@redfalcon-hpc.com',
        'password': 'redfalcon',
        'level': 3,
        'gender': 'female',
        'holiday_rest_num': 10,
        'special_rest_num': 10,
        'eid': 12345678,
        'hour_required': 100.0,
        'hour_realized': 0.0,
        'department': Department.objects.first()
    },
        {
        'name': 'jenny',
        'email': 'jenny.chin@redfalcon-hpc.com',
        'password': 'redfalcon',
        'level': 3,
        'gender': 'female',
        'holiday_rest_num': 10,
        'special_rest_num': 10,
        'eid': 12345678,
        'hour_required': 100.0,
        'hour_realized': 0.0,
        'department': Department.objects.first()
    },
    ]
    for i in range(4):
        user = User.objects.create_user(
            people[i]['name'], people[i]['email'], people[i]['password']
        )
        user.role = 'user'
        user.full_name = 'user' + str(i)
        user.level = people[i]['level']
        user.gender = people[i]['gender']
        user.holiday_rest_num = people[i]['holiday_rest_num']
        user.special_rest_num = people[i]['special_rest_num']
        user.eid = people[i]['eid']
        user.hour_required = people[i]['hour_required']
        user.hour_realized = people[i]['hour_realized']
        user.department = Department.objects.first()
        user.save()

# days

    print('create days')
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
    station = Station.objects.create(
        department=Department.objects.first(),
        name='工站一'
    )
    station = Station.objects.create(
        department=Department.objects.first(),
        name='工站二'
    )
    station = Station.objects.create(
        department=Department.objects.first(),
        name='工站三'
    )

# shift
    print('create shift')
    for i in range(7):
        st = random.choice(['白班', '小夜', '大夜'])
        shift = Shift.objects.create(
            name="shift"+str(i),
            shift_type=st,
            start_hour=8,
            start_min=0,
            end_hour=16,
            end_min=30,
            department=Department.objects.first()
        )
        shift.save()

    print('finish')

    return redirect('/')
