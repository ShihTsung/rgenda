"""
清空並灌入初始 seed 資料（部門、班別、日曆、職場、需求、admin user）。

原本是 /init/ HTTP route（無認證、會被任何人觸發 wipe DB）。
搬到 management command 後只能在容器內由有 shell 權限的人執行。

用法:
    python manage.py seed_initial --confirm
"""
import datetime
from django.core.management.base import BaseCommand, CommandError
from django.db import transaction


class Command(BaseCommand):
    help = "清空並灌入初始 seed 資料（會刪除既有資料，需要 --confirm）"

    def add_arguments(self, parser):
        parser.add_argument(
            '--confirm',
            action='store_true',
            help='確認執行（會刪除既有資料）',
        )

    def handle(self, *args, **options):
        if not options['confirm']:
            raise CommandError(
                "此命令會刪除以下表的所有資料：\n"
                "  CustomUser, Department, Shift, Station, H_Calendar,\n"
                "  Result, PreResult, AfterResult, TimeAdjustment,\n"
                "  DemandOfStation, DemandUserTable,\n"
                "  UserRemark, RemarkSquare, ResultRemark, PreResultRemark\n"
                "確認後請加 --confirm 重新執行。"
            )

        from account.models import CustomUser as User, Department
        from date.models import H_Calendar
        from station.models import Station
        from shift.models import Shift
        from demand.models import DemandOfStation, DemandUserTable
        from result.models import Result, PreResult, AfterResult, TimeAdjustment
        from remarks.models import UserRemark, RemarkSquare, ResultRemark, PreResultRemark

        with transaction.atomic():
            self.stdout.write('clean database')
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
            UserRemark.objects.all().delete()
            RemarkSquare.objects.all().delete()
            ResultRemark.objects.all().delete()
            PreResultRemark.objects.all().delete()

            self.stdout.write('create departments')
            leave_names = ['休息', '例假', '公假', 'oncall', '事假', '家庭照顧假',
                           '無薪病假', '產假', '生理假', '特休', '補休', '婚假', '計薪病假',
                           '喪假', '安胎休養假', '產檢假', '陪產假', '國定假日']
            leave_types = [5, 5, 3, 4, 6, 6, 6, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
            leave_hours = [0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            department = Department.objects.create(
                name='D1',
                detail='7AB病房',
                law_rule=1,
                schedule_rule=1,
            )
            for i in range(len(leave_names)):
                Shift.objects.create(
                    name=leave_names[i],
                    shift_type=leave_types[i],
                    start_time=datetime.time(hour=0, minute=0),
                    end_time=datetime.time(hour=0, minute=0),
                    department=department,
                    work_hours=leave_hours[i],
                )

            shift_names = ['D', 'E', '行政']
            shift_types = [0, 1, 7]
            start_hours = [8, 16, 8]
            end_hours = [16, 0, 17]
            for i in range(3):
                Shift.objects.create(
                    name=shift_names[i],
                    shift_type=shift_types[i],
                    start_time=datetime.time(hour=start_hours[i], minute=0),
                    end_time=datetime.time(hour=end_hours[i], minute=0),
                    work_hours=8,
                    department=department,
                )

            self.stdout.write('create a super user')
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
            user.department = department
            user.save()

            self.stdout.write('create days')
            daystmp = datetime.datetime.strptime('2020-01-01', '%Y-%m-%d')
            d_ids = list(Department.objects.values_list('id', flat=True))
            for _ in range(520):
                redday = daystmp.weekday() in [5, 6]
                attribute = {str(d): ("2" if redday else "1") for d in d_ids}
                H_Calendar.objects.create(
                    date=daystmp,
                    red_day=redday,
                    attribute=attribute,
                )
                daystmp += datetime.timedelta(days=1)

            self.stdout.write('create station')
            for name in ['護理站', '休假', '公假', '行政']:
                Station.objects.create(department=department, name=name)

            DemandOfStation.objects.create(
                station=Station.objects.get(name='護理站'),
                shift=Shift.objects.get(name='D'),
                level=1, config1=7, config2=4,
            )
            DemandOfStation.objects.create(
                station=Station.objects.get(name='護理站'),
                shift=Shift.objects.get(name='D'),
                level=2, config1=4, config2=2,
            )
            DemandOfStation.objects.create(
                station=Station.objects.get(name='護理站'),
                shift=Shift.objects.get(name='E'),
                level=1, config1=5, config2=3,
            )
            DemandOfStation.objects.create(
                station=Station.objects.get(name='護理站'),
                shift=Shift.objects.get(name='E'),
                level=2, config1=2, config2=1,
            )

        self.stdout.write(self.style.SUCCESS('finish'))
