from rest_framework import serializers
from rest_framework.decorators import action
from account.models import CustomUser, Department
from station.models import Station
from shift.models import Shift
from demand.models import DemandOfStation
from date.models import Oneday
from result.models import Result, PreResult, AfterResult, TimeAdjustment
from reservation.models import Reservation, PromiseShift

# 部門/科別


class DepartmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Department
        fields = ('id', 'name', 'detail')
        read_only_fields = ('id', )

# 帳號


class CustomUserSerializer(serializers.ModelSerializer):
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
    department = DepartmentSerializer()

    class Meta:
        model = CustomUser
        fields = (
            'id', 'username', 'email', 'full_name', 'department', 'level',
            'gender', 'role', 'is_superuser', 'type_of_user',
            'can_be_scheduled', 'holiday_rest_num', 'special_rest_num',
            'hour_required', 'hour_realized', 'eid', 'onboard_date')
        read_only_fields = ('id', )

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


class GetOnedaySerializer(serializers.ModelSerializer):
    title = serializers.CharField(source="attribute")
    start = serializers.CharField(source="date")
    id = serializers.CharField()
    extendedProps = serializers.SerializerMethodField()
    color = serializers.SerializerMethodField()
    className = serializers.SerializerMethodField()

    class Meta:
        model = Oneday
        fields = ('id', 'title', 'start', 'color',
                  'className', 'extendedProps')
        read_only_fields = ("id",)

    def get_className(self, obj):
        return 'bigEvent'

    def get_color(self, obj):
        if obj.attribute == 'holiday':
            return 'red'
        else:
            return ''

    def get_extendedProps(self, obj):

        return{
            'locked': obj.locked,
        }

# 日期


class OnedaySerializer(serializers.ModelSerializer):
    class Meta:
        model = Oneday
        fields = ('id',  'date', 'attribute', 'locked')
        read_only_fields = ("id",)

# 排班結果1


class PreResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = PreResult
        fields = ('id', 'user', 'shift', 'date', 'time_adjustment', 'station')

# 排班結果2


class ResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = Result
        fields = ('id', 'user', 'shift', 'date', 'time_adjustment', 'station')

# 排班結果3


class AfterResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = AfterResult
        fields = ('id', 'user', 'shift', 'date', 'time_adjustment', 'station')


class GetPreResultSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()
    shift = GetShiftSerializer()
    station = StationSerializer()

    class Meta:
        model = PreResult
        fields = ('id', 'user', 'shift', 'date', 'time_adjustment', 'station')


class GetResultSerializer(serializers.ModelSerializer):
    user = GetCustomUserSerializer()
    shift = GetShiftSerializer()
    station = StationSerializer()

    class Meta:
        model = Result
        fields = ('id', 'user', 'shift', 'date', 'time_adjustment', 'station')


class GetAfterResultSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()
    shift = GetShiftSerializer()
    station = StationSerializer()

    class Meta:
        model = AfterResult
        fields = ('id', 'user', 'shift', 'date', 'time_adjustment', 'station')


class ReservationSerializer(serializers.ModelSerializer):
    date = serializers.DateField(input_formats=['%Y-%m-%d', 'iso-8601'])

    class Meta:
        model = Reservation
        fields = ('id', 'user', 'year', 'date')


class GetReservationSerializer(serializers.ModelSerializer):
    # user = CustomUserSerializer()
    user = serializers.IntegerField(source="user.id")

    class Meta:
        model = Reservation
        fields = ('id', 'user', 'year', 'date')

# 人力需求


class DemandSerializer(serializers.ModelSerializer):
    class Meta:
        model = DemandOfStation
        fields = ('id', 'shift', 'level', 'weekday', 'holiday', 'station')


class GetDemandSerializer(serializers.ModelSerializer):
    shift = ShiftSerializer()
    station = StationSerializer()

    class Meta:
        model = DemandOfStation
        fields = ('id', 'shift', 'level', 'weekday', 'holiday', 'station')

# 保證假/班 Get


class GetPromiseShiftSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()
    shift = ShiftSerializer()

    class Meta:
        model = PromiseShift
        fields = ('id', 'user', 'year', 'date', 'shift')

# 保證假/班


class PromiseShiftSerializer(serializers.ModelSerializer):

    class Meta:
        model = PromiseShift
        fields = ('id', 'user', 'year', 'date', 'shift')


class TimeAdjustmentSerializer(serializers.ModelSerializer):

    class Meta:
        model = TimeAdjustment
        fields = ('id', 'hour', 'adjustment_type', 'remark')
