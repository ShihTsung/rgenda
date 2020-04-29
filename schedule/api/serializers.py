from rest_framework import serializers
from rest_framework.decorators import action
from account.models import CustomUser, Department
from station.models import Station
from shift.models import Shift
from demand.models import DemandOfStation
from date.models import Oneday
from result.models import Result, PreResult, AfterResult
from reservation.models import Reservation


class DepartmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Department
        fields = ('id', 'name', 'detail')
        read_only_fields = ('id', )


class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = (
            'id', 'username', 'email', 'full_name', 'department', 'level',
            'gender', 'role', 'type_of_user', 'can_be_scheduled',
            'holiday_rest_num', 'special_rest_num', 'hour_required',
            'hour_realized', 'eid', 'onboard_date')
        read_only_fields = ('id', )


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


class GetStationSerializer(serializers.ModelSerializer):
    department = DepartmentSerializer()

    class Meta:
        model = Station
        fields = ('id', 'name', 'department')
        read_only_fields = ('id', )


class StationSerializer(serializers.ModelSerializer):

    class Meta:
        model = Station
        fields = ('id', 'name', 'department')
        read_only_fields = ('id', )


class GetShiftSerializer(serializers.ModelSerializer):
    station = StationSerializer()

    class Meta:
        model = Shift
        fields = ('id', 'name', 'shift_type', 'start_hour', 'start_min',
                  'end_hour', 'end_min', 'station', 'work_hours')
        read_only_fields = ('id',)


class ShiftSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shift
        fields = ('id', 'name', 'shift_type', 'start_hour', 'start_min',
                  'end_hour', 'end_min', 'station', 'work_hours')
        read_only_fields = ('id',)


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


class OnedaySerializer(serializers.ModelSerializer):
    class Meta:
        model = Oneday
        fields = ('id',  'date', 'attribute', 'locked')
        read_only_fields = ("id",)


class PreResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = PreResult
        fields = ('id', 'user', 'year', 'shift', 'date', 'overtime')


class ResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = Result
        fields = ('id', 'user', 'year', 'shift', 'date', 'overtime')


class AfterResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = AfterResult
        fields = ('id', 'user', 'year', 'shift', 'date', 'overtime')


class GetPreResultSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()
    shift = ShiftSerializer()

    class Meta:
        model = PreResult
        fields = ('id', 'user', 'year', 'shift', 'date', 'overtime')


class GetResultSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()
    shift = ShiftSerializer()

    class Meta:
        model = Result
        fields = ('id', 'user', 'year', 'shift', 'date', 'overtime')


class GetAfterResultSerializer(serializers.ModelSerializer):
    user = CustomUserSerializer()
    shift = ShiftSerializer()

    class Meta:
        model = AfterResult
        fields = ('id', 'user', 'year', 'shift', 'date', 'overtime')


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


class DemandSerializer(serializers.ModelSerializer):
    class Meta:
        model = DemandOfStation
        fields = ('shift', 'level', 'weekday', 'holiday')


class GetDemandSerializer(serializers.ModelSerializer):
    shift = ShiftSerializer()

    class Meta:
        model = DemandOfStation
        fields = ('shift', 'level', 'weekday', 'holiday')
