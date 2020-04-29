from django.shortcuts import render
from rest_framework import viewsets, generics, permissions
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
from reservation.models import Reservation
from demand.models import DemandOfStation


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
    permission_classes = (IsAdminOrReadOnly, permissions.IsAuthenticated)

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
        if mode == 'onlyUser':
            return queryset.filter(is_staff=False)
        return queryset


class DepartmentViewSet(viewsets.ModelViewSet):
    queryset = Department.objects.all()
    serializer_class = DepartmentSerializer
    permission_classes = (IsManagerOrReadOnly,)


class ShiftViewSet(viewsets.ModelViewSet):
    queryset = Shift.objects.all()
    serializer_class = ShiftSerializer
    permission_classes = (IsManagerOrReadOnly,)

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

    def get_queryset(self):
        queryset = self.queryset
        mode = self.request.query_params.get('mode', None)
        if mode == 'personal':
            return queryset.filter(user=self.request.user)
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
