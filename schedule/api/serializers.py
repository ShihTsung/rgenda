from notifications.models import Notification
from rest_framework import serializers
from rest_framework.decorators import action
from account.models import CustomUser, Department, Liscense
from station.models import Station
from shift.models import Shift
from demand.models import DemandOfStation
from date.models import H_Calendar
from result.models import (Result, PreResult,
                           AfterResult, TimeAdjustment,
                           ExchangeApplication)
from reservation.models import Reservation, PromiseShift
from remarks.models import UserRemark, RemarkSquare, ResultRemark

# 部門/科別


class DepartmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Department
        fields = (
            'id', 'name', 'detail', 'limit_pre_schedule',
            'deadline_pre_schedule', 'reset', 'law_rule', 'schedule_rule',
            'admin_in_schedule', 'same_day_notice', 'date_start'
        )
        read_only_fields = ('id', )

# 帳號


class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = (
            'id', 'username', 'email', 'full_name', 'department', 'level',
            'is_senior', 'gender', 'role', 'type_of_user', 'can_be_scheduled',
            'holiday_rest_num', 'special_rest_num', 'hour_required',
            'hour_realized', 'eid', 'onboard_date')
        read_only_fields = ('id', )

# 帳號Get


class GetCustomUserSerializer(serializers.ModelSerializer):
    department = DepartmentSerializer()
    # start_time = serializers.SerializerMethodField()

    class Meta:
        model = CustomUser
        fields = (
            'id', 'username', 'email', 'full_name', 'department', 'level',
            'is_senior', 'gender', 'role', 'is_superuser', 'type_of_user',
            'can_be_scheduled', 'holiday_rest_num', 'special_rest_num',
            'hour_required', 'hour_realized', 'eid', 'onboard_date')
        read_only_fields = ('id', )


class CustomUserListSerializer(serializers.ModelSerializer):
    department = DepartmentSerializer()
    level = serializers.SerializerMethodField()
    pregnant = serializers.SerializerMethodField()
    schedule_state = serializers.SerializerMethodField()

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
    shift_num = serializers.SerializerMethodField()
    special_rest = serializers.SerializerMethodField()
    overtime = serializers.SerializerMethodField()
    diff = serializers.SerializerMethodField()

    def get_shift_num(self, obj):
        return 0

    def get_special_rest(self, obj):
        return 0

    def get_overtime(self, obj):
        return 0

    def get_diff(self, obj):
        return 0

    class Meta:
        model = CustomUser
        fields = (
            'id', 'username', 'email', 'department', 'can_be_scheduled',
            'is_senior', 'full_name', 'shift_num', 'special_rest',
            'overtime', 'diff'
        )

# 工作站Get


class GetStationSerializer(serializers.ModelSerializer):
    department = DepartmentSerializer()

    class Meta:
        model = Station
        fields = ('id', 'name', 'department')
        read_only_fields = ('id', )

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
    department = DepartmentSerializer()

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
        fields = ('id', 'name', 'shift_type', 'start_time',
                  'end_time', 'department', 'work_hours')
        read_only_fields = ('id',)

# 班別


class ShiftSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shift
        fields = ('id', 'name', 'shift_type', 'start_time', 'end_time',
                  'department', 'work_hours')
        read_only_fields = ('id',)

# 日期Get


class GetHCalendarSerializer(serializers.ModelSerializer):
    title = serializers.SerializerMethodField()
    start = serializers.CharField(source="date")
    id = serializers.CharField()
    extendedProps = serializers.SerializerMethodField()
    color = serializers.SerializerMethodField()
    className = serializers.SerializerMethodField()
    attribute = serializers.JSONField()

    class Meta:
        model = H_Calendar
        fields = ('id', 'title', 'start', 'color',
                  'className', 'extendedProps', 'red_day', 'attribute')
        read_only_fields = ("id",)

    def get_title(self, obj):
        if obj.red_day:
            return '假日'
        else:
            return '平日'

    def get_className(self, obj):
        return 'bigEvent'

    def get_color(self, obj):
        if obj.red_day:
            return 'red'
        else:
            return ''

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
    class Meta:
        model = PreResult
        fields = ('id', 'user', 'shift', 'date', 'station')

# 排班結果2


class ResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = Result
        fields = ('id', 'user', 'shift', 'date', 'station')


# 排班結果3


class AfterResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = AfterResult
        fields = ('id', 'user', 'shift', 'date', 'station')


class GetPreResultSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()
    shift = GetShiftSerializer()
    station = StationSerializer()

    class Meta:
        model = PreResult
        fields = ('id', 'user', 'shift', 'date', 'station')


class GetResultSerializer(serializers.ModelSerializer):
    user = GetCustomUserSerializer()
    shift = GetShiftSerializer()
    station = StationSerializer()
    shift_type = serializers.SerializerMethodField()

    def get_shift_type(self, obj):
        if obj.shift.shift_type == '白班':
            return 'A'
        elif obj.shift.shift_type == '小夜':
            return 'E'
        elif obj.shift.shift_type == '大夜':
            return 'N'
        elif obj.shift.shift_type == '有薪假':
            if obj.shift.name == "休息":
                return '休'
            if obj.shift.name == "例假":
                return '例'
            if obj.shift.name == "補休":
                return "補"
            if obj.shift.name == "特休":
                return "特"
            if obj.shift.name == "空班":
                return "空"
            if obj.shift.name == "公假":
                return "公"
            if obj.shift.name == "婚假":
                return "婚"
            if obj.shift.name == "喪假":
                return "喪"
            if obj.shift.name == "產假":
                return "產"
            if obj.shift.name == "生理假":
                return "生"
            if obj.shift.name == "國定假日":
                return "國"
        elif obj.shift.shift_type == '無薪假':
            if obj.shift.name == "無薪病假":
                return '病'
            if obj.shift.name == "事假":
                return '事'
            if obj.shift.name == "家庭照顧假":
                return '家'
        elif obj.shift.shift_type == 'oncall':
            return 'On'
        elif obj.shift.shift_type == '公假':
            return '公'
        else:
            return ''

    class Meta:
        model = Result
        fields = ('id', 'user', 'shift', 'date', 'station',
                  'shift_type')


class GetAfterResultSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()
    shift = GetShiftSerializer()
    station = StationSerializer()

    class Meta:
        model = AfterResult
        fields = ('id', 'user', 'shift', 'date', 'station')


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

    class Meta:
        model = DemandOfStation
        fields = ('id', 'shift', 'config1', 'config2',
                  'station', 'level')

# 保證假/班 Get


class GetPromiseShiftSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()

    class Meta:
        model = PromiseShift
        fields = ('id', 'user', 'date', 'shift_type')

# 保證假/班


class PromiseShiftSerializer(serializers.ModelSerializer):

    class Meta:
        model = PromiseShift
        fields = ('id', 'user', 'date', 'shift_type')


class TimeAdjustmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = TimeAdjustment
        fields = (
            'id', 'user', 'date', 'hours', 'adjustment_type',
            'adjustment_item', 'remark')


class LiscenseSerializer(serializers.ModelSerializer):

    class Meta:
        model = Liscense
        fields = '__all__'


class ExchangeApplicationSerializer(serializers.ModelSerializer):

    class Meta:
        model = ExchangeApplication
        fields = '__all__'


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
