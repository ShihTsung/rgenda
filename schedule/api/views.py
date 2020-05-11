from django.shortcuts import render
from rest_framework import viewsets, generics, permissions, status
from .serializers import *
"""(CustomUserSerializer,
ShiftSerializer,
StationSerializer,
DepartmentSerializer,
GetStationSerializer,
GetShiftSerializer,
GetCustomUserSerializer,
OnedaySerializer,
ReservationSerializer,
GetReservationSerializer
ResultSerializer,
GetResultSerializer,
PreResultSerializer,
GetPreResultSerializer,
AfterResultSerializer,
GetAfterResultSerializer,
)"""
from account.models import CustomUser, Department
from rest_framework.decorators import action
from rest_framework.response import Response
from datetime import datetime, timedelta
from rest_framework.permissions import BasePermission, SAFE_METHODS
from station.models import Station
from shift.models import Shift
from date.models import Oneday
from result.models import Result, PreResult, AfterResult
from reservation.models import Reservation, PromiseShift
from demand.models import DemandOfStation
from condition.models import Condition


class IsOwnerOrReadOnly(BasePermission):
    """
    Object-level permission to only allow owners of an object to edit it.
    Assumes the model instance has an `user` attribute.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        return obj.user == request.user or user.is_staff


class IsAdminOrReadOnly(BasePermission):
    def has_permission(self, request, view):
        if request.method in SAFE_METHODS:
            return True
        else:
            return request.user.role == 'admin' or request.user.is_superuser


class IsManagerOrReadOnly(BasePermission):
    def has_permission(self, request, view):
        if request.method in SAFE_METHODS:
            return True
        else:
            cond1 = request.user.role == 'admin'
            cond2 = request.user.role == 'manager'
            cond3 = request.user.is_superuser
            return cond1 or cond2 or cond3


class CustomUserViewSet(viewsets.ModelViewSet):
    queryset = CustomUser.objects.all().order_by('username')
    permission_classes = (IsManagerOrReadOnly, permissions.IsAuthenticated)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetCustomUserSerializer
        return CustomUserSerializer

    def get_object(self):
        pk = self.kwargs.get('pk')
        if pk == "curr":
            return self.request.user

        return super(CustomUserViewSet, self).get_object()

    def get_queryset(self):
        queryset = self.queryset
        mode = self.request.query_params.get('mode', None)
        dep = self.request.query_params.get('department', None)
        if dep:
            target = Department.objects.get(id=dep)
            return queryset.filter(department=target)
        if mode == 'onlyUser':
            return queryset.filter(is_staff=False)
        if mode == 'resource':
            user = self.request.user
            if user.role == 'manager':
                return queryset.filter(
                    department=user.department,
                    can_be_scheduled=True)
            if user.role == 'admin' or user.is_superuser:
                return queryset(can_be_scheduled=True)
        return queryset


class DepartmentViewSet(viewsets.ModelViewSet):
    queryset = Department.objects.all()
    serializer_class = DepartmentSerializer
    permission_classes = (IsManagerOrReadOnly,)


class ShiftViewSet(viewsets.ModelViewSet):
    queryset = Shift.objects.all()
    serializer_class = ShiftSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_queryset(self):
        queryset = self.queryset
        user = self.request.user
        if user.role == 'admin' or user.is_superuser:
            return queryset
        else:
            return queryset.filter(department=user.department)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetShiftSerializer
        return ShiftSerializer


class StationViewSet(viewsets.ModelViewSet):
    queryset = Station.objects.all()
    serializer_class = StationSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetStationSerializer
        return StationSerializer


class OnedayViewSet(viewsets.ModelViewSet):
    serializer_class = OnedaySerializer
    queryset = Oneday.objects.all()

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetOnedaySerializer
        return OnedaySerializer

    def get_queryset(self):
        if self.request.query_params:
            start = self.request.query_params.get('start')
            end = self.request.query_params.get('end')
            if not end:
                end = start
            return Oneday.objects.filter(date__range=[start[:10], end[:10]])
        else:
            return Oneday.objects.all()


class ResultViewSet(viewsets.ModelViewSet):
    queryset = Result.objects.all()
    serializer_class = ResultSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetResultSerializer
        return ResultSerializer


class PreResultViewSet(viewsets.ModelViewSet):
    queryset = PreResult.objects.all()
    serializer_class = PreResultSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetPreResultSerializer
        return PreResultSerializer


class AfterResultViewSet(viewsets.ModelViewSet):
    queryset = AfterResult.objects.all()
    serializer_class = AfterResultSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetAfterResultSerializer
        return AfterResultSerializer


class ReservationViewSet(viewsets.ModelViewSet):
    queryset = Reservation.objects.all()
    serializer_class = ReservationSerializer
    # 覆寫 create

    def create(self, request):
        condition = Condition.objects.get(department=request.user.department)
        max_reserve = condition.same_day_notice
        serializer = ReservationSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            # 算出同一天有多少reserve
            same_day_num = len(self.queryset.filter(
                date=serializer.validated_data['date']))
            # 如果超過最大值就在response塞警告
            if same_day_num > max_reserve:
                self.perform_create(serializer)
                headers = self.get_success_headers(serializer.data)
                serializer.data['alarm'] = 'too many same day'
                return Response(
                    {"alarm": "too many same day"},
                    status=status.HTTP_201_CREATED)
            # 否則response就是 data
            else:
                self.perform_create(serializer)
                headers = self.get_success_headers(serializer.data)
                return Response(
                    serializer.data,
                    status=status.HTTP_201_CREATED,
                    headers=headers)

    def get_queryset(self):
        queryset = self.queryset
        mode = self.request.query_params.get('mode', None)
        start = self.request.query_params.get('start', None)
        end = self.request.query_params.get('end', None)
        if mode == 'personal':
            return queryset.filter(
                user=self.request.user,
                date__range=[start[:10], end[:10]])
        return queryset

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetReservationSerializer
        return ReservationSerializer


class DemandViewSet(viewsets.ModelViewSet):
    queryset = DemandOfStation.objects.all()
    serializer_class = DemandSerializer

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetDemandSerializer
        return DemandSerializer


class PromiseShiftViewSet(viewsets.ModelViewSet):
    queryset = PromiseShift.objects.all()
    serializer_class = PromiseShiftSerializer

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetPromiseShiftSerializer
        return PromiseShiftSerializer

    def get_queryset(self):
        start = self.request.query_params.get('start', None)
        end = self.request.query_params.get('end', None)
        if self.request.query_params:
            return PromiseShift.objects.filter(date__range=[start[:10], end[:10]])
        else:
            return PromiseShift.objects.all()
