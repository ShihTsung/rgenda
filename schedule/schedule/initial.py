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
    from demand.models import DemandOfStation, DemandUserTable
    from result.models import Result, PreResult, AfterResult, TimeAdjustment

    print('clean database')
    User.objects.all().delete()
    Department.objects.all().delete()
    TimeAdjustment.objects.all().delete()
    Station.objects.all().delete()
    Shift.objects.all().delete()
    H_Calendar.objects.all().delete()
    Result.objects.all().delete()
    PreResult.objects.all().delete()
    AfterResult.objects.all().delete()
    DemandOfStation.objects.all().delete()
    DemandUserTable.objects.all().delete()

# departments
    print('create departments')
    names = ['休息', '例假', '公假', 'oncall', '事假', '家庭照顧假', '無薪病假', '產假', '生理假', '特休', '補休', '婚假',
             '計薪病假', '喪假', '安胎休養假', '產檢假', '陪產假']
    types = [5, 5, 3, 4, 6, 6, 6, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
    hours = [0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    department = Department.objects.create(
        name='D1',
        detail='7AB病房',
        law_rule=1,
        schedule_rule=1,
    )
    for i in range(len(names)):
        shift = Shift.objects.create(
            name=names[i],
            shift_type=types[i],
            start_time=datetime.time(hour=0, minute=0),
            end_time=datetime.time(hour=0, minute=0),
            department=department,
            work_hours=hours[i],
        )

    names = ['D', 'E', '行政']
    shift_types = [0, 1, 7]
    start_hours = [8, 16, 8]
    start_mins = [0, 0, 0]
    end_hours = [16, 0, 17]
    end_mins = [0, 0, 0]
    for i in range(3):
        shift = Shift.objects.create(
            name=names[i],
            shift_type=shift_types[i],
            start_time=datetime.time(
                hour=start_hours[i], minute=start_mins[i]),
            end_time=datetime.time(hour=end_hours[i], minute=end_mins[i]),
            work_hours=8,
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
    user.job_title = '職稱'
    user.type_of_user = 1
    user.holiday_rest_num = 10
    user.special_rest_num = 10
    user.eid = 20190022
    user.hour_required = 100.0
    user.hour_realized = 0.0
    user.department = Department.objects.first()
    user.save()
#     print('create user')

# # test users
#     names = ['惠如', '亭惠', '美芳', '靜音', '贈伊',
#              '佳琪', '奕萍', '雯宣', '芝琳', '榕漩', '翔瑜',
#              '文鈺', '笠瑜', '子媗', '欣沅', '詠萱', '欣羽',
#              '語蒂', '立瑩', '培瑀', '孟婷', '力綺', '琦惠',
#              '珮瑜', '杏華']
#
#     for i in range(25):
#         user = User.objects.create_user(
#             f'user{i}', f'user{i}@redfalcon-hpc.com', 'redfalcon')
#         user.role = 'user'
#         user.full_name = names[i]
#         user.level = 1
#         user.job_title = '職稱'
#         user.type_of_user = random.randint(0, 1)
#         user.gender = 'female'
#         user.holiday_rest_num = 40
#         user.special_rest_num = 10
#         user.eid = 12405142+i
#         user.hour_required = 100
#         user.hour_realized = 0
#         user.department = Department.objects.first()
#         user.save()

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
            if daystmp.weekday() in [5, 6]:
                attribute[d] = "2"
            else:
                attribute[d] = "1"
        newday = H_Calendar.objects.create(date=daystmp,
                                           red_day=redday,
                                           attribute=attribute)
        newday.save()
        daystmp += datetime.timedelta(days=1)
# station
    names = ['護理站', '休假', '公假', '行政']

    print('create station')
    for name in names:
        station = Station.objects.create(
            department=Department.objects.first(),
            name=name,
        )

# demands
    demand0 = DemandOfStation.objects.create(
        station=Station.objects.get(name='護理站'),
        shift=Shift.objects.get(name='D'),
        level=1,
        config1=7,
        config2=4,
    )
    demand1 = DemandOfStation.objects.create(
        station=Station.objects.get(name='護理站'),
        shift=Shift.objects.get(name='D'),
        level=2,
        config1=4,
        config2=2,
    )
    demand2 = DemandOfStation.objects.create(
        station=Station.objects.get(name='護理站'),
        shift=Shift.objects.get(name='E'),
        level=1,
        config1=5,
        config2=3,
    )
    demand3 = DemandOfStation.objects.create(
        station=Station.objects.get(name='護理站'),
        shift=Shift.objects.get(name='E'),
        level=2,
        config1=2,
        config2=1,
    )

    # # 班表假資料
    # department = Department.objects.first()
    # users = list(User.objects.filter(can_be_scheduled=True,
    #                                  department=department))
    # start = datetime.date(2020, 6, 1).strftime('%Y-%m-%d')
    # end = datetime.date(2020, 7, 31).strftime('%Y-%m-%d')
    # dates = list(H_Calendar.objects.filter(date__range=[start, end]))
    # shifts = list(Shift.objects.filter(department=department))
    # stations = list(Station.objects.filter(department=department))
    #
    # # user, date, station, shift
    # for day in dates:
    #     for staff in users:
    #         station = random.choice(stations)
    #         shift = random.choice(shifts)
    #         Result.objects.create(
    #             user=staff,
    #             date=day.date,
    #             station=station,
    #             shift=shift
    #         )
    # print('add adjustments')
    # users = list(User.objects.all())[:10]
    #
    # for x in users:
    #     month = random.randint(1, 12)
    #     day = random.randint(1, 28)
    #     TimeAdjustment.objects.create(
    #         user=x,
    #         date=datetime.date(2020, month, day),
    #         hours=random.randint(1, 3),
    #         adjustment_type=0,
    #         adjustment_item=0
    #     )

    print('finish')

    return redirect('/')
