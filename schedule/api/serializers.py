from notifications.models import Notification
from rest_framework import serializers
from rest_framework.decorators import action
from account.models import CustomUser, Department, Liscense, DepartmentManager
from station.models import Station
from shift.models import Shift
from demand.models import DemandOfStation, DemandUserTable
from date.models import H_Calendar
from result.models import (Result, PreResult,
                           AfterResult, TimeAdjustment,
                           ExchangeApplication)
from reservation.models import Reservation, PromiseShift
from remarks.models import (
    UserRemark, RemarkSquare,
    ResultRemark, PreResultRemark)
import datetime
# 部門/科別


class DepartmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = Department
        fields = (
            'id', 'name', 'detail', 'limit_pre_schedule',
            'deadline_pre_schedule', 'reset', 'law_rule', 'schedule_rule',
            'admin_in_schedule', 'same_day_notice', 'date_start',
            'start_of_week', 'can_rest_redday',
            'overtime_rule'
        )
        read_only_fields = ('id', )


class GetDepartmentSerializer(serializers.ModelSerializer):
    managers = serializers.SerializerMethodField()

    def get_managers(self, obj):
        try:
            mgrs = DepartmentManager.objects.get(department=obj)
            mgr1 = mgrs.manager_one
            mgr2 = mgrs.manager_two

            mgr1_dict = {
                'id': mgr1.id,
                'name': mgr1.full_name,
            } if mgr1 else {}
            mgr2_dict = {
                'id': mgr2.id,
                'name': mgr2.full_name
            } if mgr2 else {}
            ret = {
                'manager1': mgr1_dict,
                'manager2': mgr2_dict
            }
        except DepartmentManager.DoesNotExist:
            ret = {

            }

        return ret

    class Meta:
        model = Department
        fields = ('id', 'name', 'detail', 'limit_pre_schedule',
                  'deadline_pre_schedule', 'reset', 'law_rule',
                  'schedule_rule', 'admin_in_schedule',
                  'same_day_notice', 'date_start',
                  'start_of_week', 'can_rest_redday', 'overtime_rule',
                  'managers'
                  )


class SimpleDepartmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Department
        fields = (
            'id', 'name', 'detail'
        )
        read_only_fields = ('id', )


# 帳號


class CustomUserSerializer(serializers.ModelSerializer):
    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.select_related(
            'department')

        return queryset

    class Meta:
        model = CustomUser
        fields = (
            'id', 'username', 'email', 'full_name', 'department', 'level',
            'gender', 'role', 'type_of_user', 'can_be_scheduled',
            'holiday_rest_num', 'special_rest_num', 'hour_required',
            'hour_realized', 'eid', 'onboard_date')
        read_only_fields = ('id', )

# 帳號Get


class GetCustomUserSerializer(serializers.ModelSerializer):
    department = SimpleDepartmentSerializer()
    # start_time = serializers.SerializerMethodField()
    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.select_related(
            'department')

        return queryset

    class Meta:
        model = CustomUser
        fields = (
            'id', 'username', 'email', 'full_name', 'department', 'level',
            'gender', 'role', 'is_superuser', 'type_of_user', 'pregnant',
            'can_be_scheduled', 'holiday_rest_num', 'special_rest_num',
            'hour_required', 'hour_realized', 'eid', 'onboard_date')
        read_only_fields = ('id', )


class DepartmentManagerSerializer(serializers.ModelSerializer):
    class Meta:
        model = DepartmentManager
        fields = (
            'id', 'department', 'manager_one', 'manager_two'
        )
        read_only_fields = ('id', )


class CustomUserListSerializer(serializers.ModelSerializer):
    department = DepartmentSerializer()
    level = serializers.SerializerMethodField()
    pregnant = serializers.SerializerMethodField()
    schedule_state = serializers.SerializerMethodField()

    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.select_related(
            'department')

        return queryset

    def get_level(self, obj):
        if obj.level <= 4:
            return 'N' + str(obj.level)
        elif obj.level == 5:
            return 'Nn'
        else:
            return ''

    def get_pregnant(self, obj):
        if obj.pregnant:
            return "妊娠/哺乳期"
        else:
            return ""

    def get_schedule_state(self, obj):
        if obj.can_be_scheduled:
            return "正常排班"
        else:
            return "暫停排班"

    class Meta:
        model = CustomUser
        fields = (
            'id', 'username', 'full_name', 'department', 'can_be_scheduled',
            'level', 'eid', 'type_of_user', 'pregnant', 'schedule_state'

        )
        read_only_fields = ('id', )


class GetResourceUserSerializer(serializers.ModelSerializer):

    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.select_related(
            'department')

        return queryset

    class Meta:
        model = CustomUser
        fields = (
            'id', 'username', 'email', 'department', 'can_be_scheduled',
            'full_name', 'type_of_user', 'eid', 'level'
        )

# 工作站Get


class GetStationSerializer(serializers.ModelSerializer):
    department = DepartmentSerializer()

    class Meta:
        model = Station
        fields = ('id', 'name', 'department')
        read_only_fields = ('id', )


class SimpleStationSerializer(serializers.ModelSerializer):

    class Meta:
        model = Station
        fields = ('id', 'name')


# 工作站


class StationSerializer(serializers.ModelSerializer):

    class Meta:
        model = Station
        fields = ('id', 'name', 'department')
        read_only_fields = ('id', )

# 班別Get


class GetShiftSerializer(serializers.ModelSerializer):
    start_time = serializers.SerializerMethodField()
    end_time = serializers.SerializerMethodField()
    department = SimpleDepartmentSerializer()

    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.select_related(
            'department')

        return queryset

    def get_start_time(self, obj):
        hour = str(obj.start_time.hour)
        minute = str(obj.start_time.minute)
        return ('0'+hour)[-2:]+':'+('0'+minute)[-2:]

    def get_end_time(self, obj):
        hour = str(obj.end_time.hour)
        minute = str(obj.end_time.minute)
        return ('0'+hour)[-2:]+':'+('0'+minute)[-2:]

    class Meta:
        model = Shift
        fields = ('id', 'name', 'code', 'shift_type', 'start_time',
                  'end_time', 'department', 'work_hours')
        read_only_fields = ('id',)

# 班別


class ShiftSerializer(serializers.ModelSerializer):
    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.select_related(
            'department')

        return queryset

    class Meta:
        model = Shift
        fields = ('id', 'name', 'code', 'shift_type', 'start_time', 'end_time',
                  'department', 'work_hours')
        read_only_fields = ('id',)


class SimpleShiftSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shift
        fields = ('id', 'name', 'code', 'shift_type', 'work_hours')
        read_only_fields = ('id',)

# 日期Get


class GetHCalendarSerializer(serializers.ModelSerializer):
    title = serializers.SerializerMethodField()
    start = serializers.CharField(source="date")
    id = serializers.CharField()
    extendedProps = serializers.SerializerMethodField()
    className = serializers.SerializerMethodField()
    attribute = serializers.JSONField()

    class Meta:
        model = H_Calendar
        fields = ('id', 'title', 'start',
                  'className', 'extendedProps', 'red_day', 'attribute')
        read_only_fields = ("id",)

    def get_title(self, obj):
        if obj.red_day:
            return '假日'
        else:
            return '平日'

    def get_className(self, obj):
        return 'bigEvent'

    def get_extendedProps(self, obj):

        return{
            'locked': obj.locked,
        }

# 日期


class HCalendarSerializer(serializers.ModelSerializer):
    attribute = serializers.JSONField()

    class Meta:
        model = H_Calendar
        fields = ('id',  'date', 'attribute', 'locked', 'red_day')
        read_only_fields = ("id",)

# 排班結果1


class PreResultSerializer(serializers.ModelSerializer):
    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.prefetch_related(
            'shift', 'shift__department')
        queryset = queryset.prefetch_related(
            'station', 'station__department')
        queryset = queryset.prefetch_related(
            'user', 'user__department')
        return queryset

    class Meta:
        model = PreResult
        fields = ('id', 'user', 'shift', 'date', 'station')

# 排班結果2


class ResultSerializer(serializers.ModelSerializer):
    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.prefetch_related(
            'shift', 'shift__department')
        queryset = queryset.prefetch_related(
            'station', 'station__department')
        queryset = queryset.prefetch_related(
            'user', 'user__department')
        return queryset

    class Meta:
        model = Result
        fields = ('id', 'user', 'shift', 'date', 'station')


# 排班結果3


class AfterResultSerializer(serializers.ModelSerializer):
    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.prefetch_related(
            'shift', 'shift__department')
        queryset = queryset.prefetch_related(
            'station', 'station__department')
        queryset = queryset.prefetch_related(
            'user', 'user__department')
        return queryset

    class Meta:
        model = AfterResult
        fields = ('id', 'user', 'shift', 'date', 'station')


def get_type(shift):
    if shift.shift_type in [0, 1, 2]:
        return shift.code
    elif shift.shift_type == 5:
        if shift.name == "休息":
            return '休'
        if shift.name == "例假":
            return '例'
        if shift.name == "補休":
            return "補"
        if shift.name == "特休":
            return "特"
        if shift.name == "空班":
            return "空"
        if shift.name == "婚假":
            return "婚"
        if shift.name == "喪假":
            return "喪"
        if shift.name == "產假":
            return "產"
        if shift.name == "生理假":
            return "生"
        if shift.name == "國定假日":
            return "國"
    elif shift.shift_type == 6:
        if shift.name == "無薪病假":
            return '病'
        if shift.name == "事假":
            return '事'
        if shift.name == "家庭照顧假":
            return '家'
    elif shift.shift_type == 4:
        if shift.code == '':
            return 'On'
        else:
            return shift.code
    elif shift.shift_type == 3:
        return '公'
    elif shift.shift_type == 7:
        return shift.code
    else:
        return ''


class GetPreResultSerializer(serializers.ModelSerializer):
    shift = SimpleShiftSerializer()
    station = SimpleStationSerializer()
    shift_type = serializers.SerializerMethodField()

    def get_shift_type(self, obj):
        return get_type(obj.shift)

    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.prefetch_related(
            'shift', 'shift__department')
        queryset = queryset.prefetch_related(
            'station', 'station__department')
        queryset = queryset.prefetch_related(
            'user', 'user__department')
        return queryset

    class Meta:
        model = PreResult
        fields = ('id', 'user', 'shift', 'date', 'station', 'shift_type')


class GetResultSerializer(serializers.ModelSerializer):
    # user = CustomUserSerializer()
    shift = SimpleShiftSerializer()
    station = SimpleStationSerializer()
    shift_type = serializers.SerializerMethodField()

    def get_shift_type(self, obj):
        return get_type(obj.shift)

    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.prefetch_related(
            'shift', 'shift__department')
        queryset = queryset.prefetch_related(
            'station', 'station__department')
        queryset = queryset.prefetch_related(
            'user', 'user__department')
        return queryset

    class Meta:
        model = Result
        fields = ('id', 'user', 'shift', 'date', 'station',
                  'shift_type')


class GetAfterResultSerializer(serializers.ModelSerializer):
    shift = SimpleShiftSerializer()
    station = SimpleStationSerializer()
    shift_type = serializers.SerializerMethodField()
    @staticmethod
    def setup_eager_loading(queryset):
        queryset = queryset.select_related(
            'shift', 'shift__department')
        queryset = queryset.select_related(
            'station', 'station__department')
        queryset = queryset.select_related(
            'user', 'user__department')
        return queryset

    def get_shift_type(self, obj):
        return get_type(obj.shift)

    class Meta:
        model = AfterResult
        fields = ('id', 'user', 'shift', 'date', 'station', 'shift_type')


class ReservationSerializer(serializers.ModelSerializer):
    date = serializers.DateField(input_formats=['%Y-%m-%d', 'iso-8601'])

    class Meta:
        model = Reservation
        fields = ('id', 'user', 'date')


class GetReservationSerializer(serializers.ModelSerializer):
    # user = CustomUserSerializer()
    user = serializers.IntegerField(source="user.id")

    class Meta:
        model = Reservation
        fields = ('id', 'user', 'date')

# 人力需求


class DemandSerializer(serializers.ModelSerializer):

    class Meta:
        model = DemandOfStation
        fields = ('id', 'shift', 'config1', 'config2',
                  'station', 'level')


class GetDemandSerializer(serializers.ModelSerializer):
    shift = ShiftSerializer()
    station = StationSerializer()
    people = serializers.SerializerMethodField()

    def get_people(self, obj):
        res = []
        p_set = DemandUserTable.objects.filter(demand=obj)
        for p in p_set:
            level = 2 if p.user.type_of_user == 1 else 1
            res.append({
                'id': p.user.id,
                'full_name': p.user.full_name,
                'level': level,
                'demand_user_id': p.id})
        return res

    class Meta:
        model = DemandOfStation
        fields = ('id', 'shift', 'config1', 'config2',
                  'station', 'level', 'people')

# 保證假/班 Get


class GetPromiseShiftSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()

    class Meta:
        model = PromiseShift
        fields = ('id', 'user', 'date', 'shift_type', 'hours', 'remark')

# 保證假/班


class PromiseShiftSerializer(serializers.ModelSerializer):

    class Meta:
        model = PromiseShift
        fields = ('id', 'user', 'date', 'shift_type', 'hours', 'remark')


class TimeAdjustmentSerializer(serializers.ModelSerializer):
    adjustment_item_text = serializers.SerializerMethodField()

    def get_adjustment_item_text(self, obj):
        texts = ['工作日加班', '休息日出勤',
                 '國定假日出勤', '空班出勤', 'On Call出勤',
                 '機構減班', '員工自假']
        return texts[obj.adjustment_item]

    class Meta:
        model = TimeAdjustment
        fields = (
            'id', 'user', 'date', 'hours', 'adjustment_type',
            'adjustment_item', 'adjustment_item_text', 'remark')


class LiscenseSerializer(serializers.ModelSerializer):

    class Meta:
        model = Liscense
        fields = '__all__'


class ExchangeApplicationSerializer(serializers.ModelSerializer):

    class Meta:
        model = ExchangeApplication
        fields = '__all__'


class GetExchangeApplicationSerializer(serializers.ModelSerializer):
    apply_result = serializers.SerializerMethodField()
    receive_result = serializers.SerializerMethodField()

    def get_apply_result(self, obj):
        # date = datetime.datetime.strptime(obj.date_start, '%Y-%m-%d').date()
        date = obj.date_start
        try:
            ret = Result.objects.get(user=obj.user_apply, date=date)
            ret = {
                'user': {'id': ret.user.id, 'name': ret.user.full_name},
                'date': ret.date.strftime('%Y-%m-%d'),
                'shift': {
                    'id': ret.shift.id, 'name': ret.shift.name,
                    'shift_type': ret.shift.shift_type,
                    'start': ret.shift.start_time,
                    'end': ret.shift.end_time
                },
                'station': {
                    'id': ret.station.id, 'name': ret.station.name,
                }
            }
        except Result.DoesNotExist:
            ret = ''
        return ret

    def get_receive_result(self, obj):
        # date = datetime.datetime.strptime(obj.date_start, '%Y-%m-%d').date()
        date = obj.date_start
        try:
            ret = Result.objects.get(user=obj.user_receive, date=date)
            ret = {
                'user': {'id': ret.user.id, 'name': ret.user.full_name},
                'date': ret.date.strftime('%Y-%m-%d'),
                'shift': {
                    'id': ret.shift.id, 'name': ret.shift.name,
                    'shift_type': ret.shift.shift_type,
                    'start': ret.shift.start_time,
                    'end': ret.shift.end_time
                },
                'station': {'id': ret.station.id, 'name': ret.station.name}
            }
        except Result.DoesNotExist:
            ret = ''
        return ret

    class Meta:
        model = ExchangeApplication
        fields = (
            'id', 'user_apply', 'user_receive',
            'date_start', 'date_end', 'application_status',
            'receive_result', 'apply_result')


class NotificationSerializer(serializers.ModelSerializer):
    """
        FIELDS_INCLUDED

        id :                        INT
        level:                      VARCHAR
        unread:                     TINYINT
        actor_object_id:            VARCHAR
        verb:                       VARCHAR
        description:                LONGTEXT
        target_object_id:           VARCHAR
        action_object_object_id:    INT
        timestamp:                  DATETIME
        public:                     TINYINT
        deleted:                    TINYINT
        emailed:                    TINYINT
        data:                       LONGTEXT
        recipient_id:               INT
        actor_content_type:         INT
        target_content_type:        INT
        action_object_content_type: INT
    """
    actor = serializers.SerializerMethodField()
    target = serializers.SerializerMethodField()

    def get_actor(self, obj):
        if obj.actor_object_id:
            id = int(obj.actor_object_id)
            return CustomUser.objects.get(id=id).full_name
        else:
            return None

    def get_target(self, obj):

        if obj.target_object_id:
            id = int(obj.target_object_id)
            return Department.objects.get(id=id).detail
        else:
            return None

    class Meta:
        model = Notification
        fields = '__all__'


class UserRemarkSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserRemark
        fields = '__all__'


class RemarkSquareSerializer(serializers.ModelSerializer):
    class Meta:
        model = RemarkSquare
        fields = '__all__'


class ResultRemarkSerializer(serializers.ModelSerializer):
    class Meta:
        model = ResultRemark
        fields = '__all__'


class PreResultRemarkSerializer(serializers.ModelSerializer):
    class Meta:
        model = PreResultRemark
        fields = '__all__'


class DemandUserTableSerializer(serializers.ModelSerializer):

    class Meta:
        model = DemandUserTable
        fields = '__all__'
