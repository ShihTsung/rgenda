import os
import pathlib
import random
import sys
import datetime
import django
import json
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
    from date.models import H_Calendar
    from station.models import Station
    from shift.models import Shift
    from demand.models import DemandOfStation
    from result.models import Result, PreResult, AfterResult

    print('clean database')
    Department.objects.all().delete()
    User.objects.all().delete()
    Station.objects.all().delete()
    Shift.objects.all().delete()
    H_Calendar.objects.all().delete()
    Result.objects.all().delete()
    PreResult.objects.all().delete()
    AfterResult.objects.all().delete()
    DemandOfStation.objects.all().delete()

# departments
    print('create departments')
    names = ['休息', '例假', '公假', 'oncall']
    types = ['有薪假', '有薪假', '有薪假', 'oncall']
    hours = [0, 0, 8, 0]
    department = Department.objects.create(name='D1', detail='健檢診所')
    for i in range(4):
        shift = Shift.objects.create(
            name=names[i],
            shift_type=types[i],
            start_time=datetime.time(hour=0, minute=0),
            end_time=datetime.time(hour=0, minute=0),
            department=department,
            work_hours=hours[i])
    # shift = Shift.objects.create(
    #     name='白班',
    #     shift_type='白班',
    #     start_time=datetime.time(hour=7, minute=0),
    #     end_time=datetime.time(hour=16, minute=0),
    #     department=department,
    #     work_hours=8)
    # shift = Shift.objects.create(
    #     name='小夜',
    #     shift_type='小夜',
    #     start_time=datetime.time(hour=15, minute=0),
    #     end_time=datetime.time(hour=0, minute=0),
    #     department=department,
    #     work_hours=8)
    # shift = Shift.objects.create(
    #     name='大夜',
    #     shift_type='大夜',
    #     start_time=datetime.time(hour=23, minute=0),
    #     end_time=datetime.time(hour=8, minute=0),
    #     department=department,
    #     work_hours=8)
    department = Department.objects.create(name='D2', detail='手術房')
    for i in range(4):
        shift = Shift.objects.create(
            name=names[i],
            shift_type=types[i],
            start_time=datetime.time(hour=0, minute=0),
            end_time=datetime.time(hour=0, minute=0),
            department=department,
            work_hours=hours[i])

    names = ['B1', 'B10', 'B15', 'B2', 'B3', 'B31', 'B4', 'B6', 'B8']
    start_hours = [7, 8, 8, 7, 7, 8, 8, 9, 8]
    start_mins = [0, 0, 3, 3, 3, 3, 0, 0, 0]
    end_hours = [15, 16, 12, 16, 16, 17, 17, 18, 12]
    end_mins = [30, 30, 30, 0, 30, 0, 0, 0, 0]
    for i in range(9):
        shift = Shift.objects.create(
            name=names[i],
            shift_type='白班',
            start_time=datetime.time(
                hour=start_hours[i], minute=start_mins[i]),
            end_time=datetime.time(hour=end_hours[i], minute=end_mins[i]),
            work_hours=end_hours[i]-start_hours[i],
            department=Department.objects.first()
        )
# superuser
    print('create a super user')
    user = User.objects.create_superuser(
        'circlepen', 'lyle.lai@redfalcon-hpc.com', 'redfalcon')
    user.role = 'admin'
    user.full_name = 'YiJu Lai'
    user.level = 3
    user.gender = 'male'
    user.is_senior = True
    user.job_title = '職稱'
    user.holiday_rest_num = 10
    user.special_rest_num = 10
    user.eid = 20190022
    user.hour_required = 100.0
    user.hour_realized = 0.0
    user.department = Department.objects.first()
    user.save()
    print('create user')

# test users
    names = ['惠如', '亭惠', '美芳', '靜音', '贈伊',
             '佳琪', '奕萍', '雯宣', '芝琳', '榕漩', '翔瑜',
             '文鈺', '笠瑜', '子媗', '欣沅', '詠萱', '欣羽',
             '語蒂', '立瑩', '培瑀', '孟婷', '力綺', '琦惠',
             '珮瑜', '杏華']

    for i in range(25):
        user = User.objects.create_user(
            f'user{i}', f'user{i}@redfalcon-hpc.com', 'redfalcon')
        user.role = 'user'
        user.full_name = names[i]
        user.level = 1
        user.job_title = '職稱'
        user.is_senior = False
        user.gender = 'female'
        user.holiday_rest_num = 40
        user.special_rest_num = 10
        user.eid = 12405142+i
        user.hour_required = 100
        user.hour_realized = 0
        user.department = Department.objects.first()
        user.save()

# days

    print('create days')
    daystmp = datetime.datetime.strptime('2020-01-01', '%Y-%m-%d')
    redday = True
    departments = Department.objects.all()
    d_ids = [x.id for x in departments]
    for i in range(520):
        attribute = {}
        if daystmp.weekday() in [5, 6]:
            redday = True
        else:
            redday = False
        for d in d_ids:
            attribute[d] = "1"
        newday = H_Calendar.objects.create(date=daystmp,
                                           red_day=redday,
                                           attribute=attribute)
        newday.save()
        daystmp += datetime.timedelta(days=1)
# station
    names = ['POR主控', 'POR', '洗滌區', '受檢', '麻醉科', '3F場控',
             '2F場控', '健康秘書', '一般', '腹超', '理學', 'EKGX+ASIX',
             '聽力', '眼科+眼底攝影', '外檢', '公假', '休假']

    print('create station')
    for i in range(15):
        station = Station.objects.create(
            department=Department.objects.first(),
            name=names[i]
        )
        station.save()

# demands
    stations = ['POR主控', 'POR', '洗滌區', '受檢', '麻醉科', '3F場控',
                '2F場控', '健康秘書', '一般', '腹超', '理學', 'EKGX+ASIX',
                '聽力', '眼科+眼底攝影', '外檢', '公假', '休假']
    workday = [1, 1, 2, 2, 1, 1, 1, 7, 1, 1, 1, 3, 1, 1, 1]
    holiday = [1, 1, 1, 1, 1, 1, 1, 5, 1, 0, 0, 3, 1, 1, 1]
    for i in range(15):
        shifts = ['B1', 'B10', 'B15', 'B2', 'B3', 'B31', 'B4', 'B6', 'B8']
        pick_shift = random.choice(shifts)
        for j in range(2):
            DemandOfStation.objects.create(
                shift=Shift.objects.get(name=pick_shift),
                station=Station.objects.get(name=stations[i]),
                level=j+1,
                config1=workday[i] if j == 0 else 0,
                config2=holiday[i] if j == 0 else 0
            )
    # 班表假資料
    department = Department.objects.first()
    users = list(User.objects.filter(can_be_scheduled=True,
                                     department=department))
    start = datetime.date(2020, 6, 1).strftime('%Y-%m-%d')
    end = datetime.date(2020, 7, 31).strftime('%Y-%m-%d')
    dates = list(H_Calendar.objects.filter(date__range=[start, end]))
    shifts = list(Shift.objects.filter(department=department))
    stations = list(Station.objects.filter(department=department))

    # user, date, station, shift
    for day in dates:
        for staff in users:
            station = random.choice(stations)
            shift = random.choice(shifts)
            Result.objects.create(
                user=staff,
                date=day.date,
                station=station,
                shift=shift
            )

    print('finish')

    return redirect('/')
