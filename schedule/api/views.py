# django
from django.shortcuts import render

# restframework
from rest_framework import viewsets, generics, permissions, status
from rest_framework.decorators import (
    action, api_view, parser_classes,
    permission_classes)
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import BasePermission, SAFE_METHODS
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from rest_framework.parsers import JSONParser

# others
from datetime import datetime, timedelta
from calendar import monthrange
from .check import *
from .serializers import *
from account.views import cycle_analysis, get_cycle
from date.views import attr_list, red_dict
from demand.views import get_demands
from math import ceil, floor
from notifications.models import Notification
from notifications.signals import notify
from numpy.random import choice
from reservation.views import get_reserve_leave, get_promise_leave, get_official_leave, get_promise_other
from result.views import str_to_date, get_continue_days, get_workday_num, get_used_rest
from shift.views import get_shifts
from station.views import get_stations

# models
from account.models import CustomUser, Department, Liscense, DepartmentManager
from station.models import Station
from shift.models import Shift
from date.models import H_Calendar
from result.models import (Result, PreResult,
                           AfterResult, TimeAdjustment,
                           ExchangeApplication, HistoryResult)
from reservation.models import Reservation, PromiseShift
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

        return obj.user == request.user or obj.user.is_staff


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


get_all = openapi.Parameter('all', openapi.IN_QUERY,
                            description="全部或是單一部門", type=openapi.TYPE_BOOLEAN)
start_date = openapi.Parameter('start', openapi.IN_QUERY,
                               description="開始日期", type=openapi.TYPE_STRING)
start = openapi.Parameter('start', openapi.IN_QUERY,
                          description="開始日期", type=openapi.TYPE_STRING)
end_date = openapi.Parameter('end', openapi.IN_QUERY,
                             description="結束日期", type=openapi.TYPE_STRING)
end = openapi.Parameter('end', openapi.IN_QUERY,
                        description="結束日期", type=openapi.TYPE_STRING)
mode = openapi.Parameter('mode', openapi.IN_QUERY,
                         description="模式", type=openapi.TYPE_STRING)
month_head = openapi.Parameter('month_head', openapi.IN_QUERY,
                               description="月初日", type=openapi.TYPE_STRING)
uid = openapi.Parameter('uid', openapi.IN_QUERY,
                        description="使用者id", type=openapi.TYPE_STRING)
usertype = openapi.Parameter('type', openapi.IN_QUERY,
                             description="排班身份類型", type=openapi.TYPE_STRING)
date = openapi.Parameter('date', openapi.IN_QUERY,
                         description="日期", type=openapi.TYPE_STRING)
exchange_shift_type = openapi.Parameter('shift_type', openapi.IN_QUERY,
                                        description="欲換班的班別", type=openapi.TYPE_STRING)
follower = openapi.Parameter('follower', openapi.IN_QUERY,
                             description="跟班者", type=openapi.TYPE_STRING)
mentor = openapi.Parameter('mentor', openapi.IN_QUERY,
                           description="帶班者", type=openapi.TYPE_STRING)
adj_type = openapi.Parameter('type', openapi.IN_QUERY,
                             description="類別", type=openapi.TYPE_STRING)
adj_item = openapi.Parameter('item', openapi.IN_QUERY,
                             description="加減班選項", type=openapi.TYPE_STRING)
user_name = openapi.Parameter('name', openapi.IN_QUERY,
                              description="使用者姓名", type=openapi.TYPE_STRING)
month = openapi.Parameter('month', openapi.IN_QUERY,
                          description="月份(整數)", type=openapi.TYPE_INTEGER)
department = openapi.Parameter('department', openapi.IN_QUERY,
                               description="科別(id)", type=openapi.TYPE_INTEGER)
configs = openapi.Parameter('configs', openapi.IN_QUERY,
                            description="人力需求配置", type=openapi.TYPE_STRING)


class CustomUserViewSet(viewsets.ModelViewSet):
    queryset = CustomUser.objects.all().order_by('username')
    permission_classes = (IsManagerOrReadOnly, permissions.IsAuthenticated)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            mode = self.request.query_params.get('mode', None)
            if mode == 'resource':
                return GetResourceUserSerializer
            if mode == 'table':
                return CustomUserListSerializer
            return GetCustomUserSerializer
        return CustomUserSerializer

    def get_object(self):
        pk = self.kwargs.get('pk')
        if pk == "curr":
            return self.request.user

        return super().get_object()

    def get_queryset(self):
        queryset = CustomUser.objects.all()
        queryset = self.get_serializer_class().setup_eager_loading(queryset)
        mode = self.request.query_params.get('mode', None)
        dep = self.request.query_params.get('department', None)
        t = self.request.query_params.get('type', None)

        if mode == 'onlyUser':
            queryset = queryset.filter(is_staff=False)
        if mode == 'resource':
            user = self.request.user
            queryset = queryset.filter(
                department=user.department,
                can_be_scheduled=True)
        if t:
            queryset = queryset.filter(type_of_user=int(t))
        if mode == 'table':
            user = self.request.user
            queryset = queryset.filter(department=user.department)
        if dep is not None:
            target = Department.objects.get(id=dep)
            queryset = queryset.filter(department=target)
        return queryset

    @swagger_auto_schema(
        operation_summary='獲得使用者清單',
        operation_description='GET 的說明',
        manual_parameters=[mode, department, usertype]
    )
    def list(self, request, *args, **kwargs):
        """

        mode=onlyUser: 去掉系統管理員
        mode=resource: 只顯示請求發送者同部門且可排班的人
        department=k : 顯示id=k 的科別內所有人
        type=n :       過濾某個類型的人
        (0, 正職)
        (1, 資深正職)
        (2, 行政職)
        (3, 新進人員)
        (4, 兼職人員)
        (5, 實習生)

        """
        return super().list(self, request, *args, **kwargs)

    @swagger_auto_schema(
        operation_summary='新增使用者',
        operation_description='POST 的說明',
    )
    def create(self, request, *args, **kwargs):
        return super().create(self, request, *args, **kwargs)

    @swagger_auto_schema(
        operation_summary='獲得個別使用者',
        operation_description='GET 單一個體的說明',
    )
    def retrieve(self, request, pk=None, *args, **kwargs):
        return super().retrieve(self, request, *args, **kwargs)

    @swagger_auto_schema(
        operation_summary='更新使用者資料',
        operation_description='PUT 的說明',
    )
    def update(self, request, pk=None, partial=False, *args, **kwargs):
        return super().update(request, pk, partial, *args, **kwargs)

    @swagger_auto_schema(
        operation_summary='部分更新',
        operation_description='PATCH 的說明',
    )
    def partial_update(self, request, pk=None, *args, **kwargs):
        return super().partial_update(request, pk, *args, **kwargs)

    @swagger_auto_schema(
        operation_summary='刪除使用者',
        operation_description='DELETE 的說明',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


class TimeAdjustmentViewSet(viewsets.ModelViewSet):
    queryset = TimeAdjustment.objects.all()
    serializer_class = TimeAdjustmentSerializer
    permission_classes = (permissions.IsAuthenticated,)

    def get_queryset(self):
        queryset = TimeAdjustment.objects.all()
        if self.request.query_params:
            start = self.request.query_params.get('start')
            end = self.request.query_params.get('end')
            uid = self.request.query_params.get('uid')
            adj_type = self.request.query_params.get('type')
            adj_item = self.request.query_params.get('item')

            if adj_type:
                queryset = queryset.filter(
                    adjustment_type=int(adj_type)
                )
            if adj_item:
                queryset = queryset.filter(
                    adjustment_item=int(adj_item)
                )
            if start and end:
                queryset = queryset.filter(
                    date__range=[start[:10], end[:10]]
                )
            if uid:
                target = CustomUser.objects.get(id=uid)
                queryset = queryset.filter(user=target)

        return queryset

    @swagger_auto_schema(
        operation_summary='加減班清單',
        operation_description='''列出所有加減班清單

        type:

            (0, '增加時數'),
            (1, '減少時數'),

        item:

            (0, '工作日加班'),
            (1, '休息日出勤'),
            (2, '國定假日出勤'),
            (3, '空班出勤'),
            (4, 'On Call出勤'),
            (5, '機構減班'),
        ''',
        manual_parameters=[
            start_date, end_date, uid, adj_type, adj_item
        ]
    )
    def list(self, request, *args, **kwargs):
        return super().list(self, request, *args, **kwargs)

    @swagger_auto_schema(
        operation_summary='新增加減班',
        operation_description='增加一筆加減班',
    )
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        data = serializer.data
        texts = ['工作日加班', '休息日出勤',
                 '國定假日出勤', '空班出勤', 'On Call出勤',
                 '機構減班', '員工自假']
        data['adjustment_item_text'] = texts[data['adjustment_item']]
        return Response(data, status=status.HTTP_201_CREATED, headers=headers)

    @swagger_auto_schema(
        operation_summary='刪除加減班',
        operation_description='DELETE 的說明',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


class DepartmentViewSet(viewsets.ModelViewSet):
    queryset = Department.objects.all()
    serializer_class = DepartmentSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetDepartmentSerializer
        return DepartmentSerializer

    def get_queryset(self):
        if self.request.user.role == 'admin':
            return Department.objects.all()
        return Department.objects.filter(id=self.request.user.department.id)


class DepartmentManagerViewSet(viewsets.ModelViewSet):
    queryset = DepartmentManager.objects.all()
    serializer_class = DepartmentManagerSerializer
    permission_classes = (permissions.IsAuthenticated,)


class ShiftViewSet(viewsets.ModelViewSet):
    queryset = Shift.objects.all()
    serializer_class = ShiftSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_queryset(self):
        queryset = Shift.objects.all()
        user = self.request.user
        if self.request.query_params:
            if self.request.query_params.get('all') == "True":
                queryset = queryset
            else:
                queryset = queryset.filter(department=user.department)
        else:
            queryset = queryset.filter(department=user.department)

        return queryset

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetShiftSerializer
        return ShiftSerializer

    @swagger_auto_schema(
        operation_summary='獲得班別清單',
        operation_description='GET 的說明',
        manual_parameters=[get_all]
    )
    def list(self, request, *args, **kwargs):
        return super().list(self, request, *args, **kwargs)

    @swagger_auto_schema(
        operation_summary='刪除班別',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


class StationViewSet(viewsets.ModelViewSet):
    queryset = Station.objects.all()
    serializer_class = StationSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetStationSerializer
        return StationSerializer

    def get_queryset(self):
        queryset = Station.objects.all()
        department = self.request.query_params.get('department')
        if department:
            d = Department.objects.filter(id=int(department)).first()
            queryset = queryset.filter(department=d)
        user = self.request.user
        if user.role == 'admin':
            queryset = queryset
        else:
            queryset = queryset.filter(
                department=user.department
            )
        return queryset

    @swagger_auto_schema(
        operation_summary='刪除工作站',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


class HCalendarViewSet(viewsets.ModelViewSet):
    serializer_class = HCalendarSerializer
    queryset = H_Calendar.objects.all()

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetHCalendarSerializer
        return HCalendarSerializer

    def get_queryset(self):
        queryset = H_Calendar.objects.all()
        if self.request.query_params:
            start = self.request.query_params.get('start')
            end = self.request.query_params.get('end')
            if start and end:
                queryset = queryset.filter(date__range=[start[:10], end[:10]])
        return queryset


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


class ResultViewSet(viewsets.ModelViewSet):
    queryset = Result.objects.all()
    serializer_class = ResultSerializer
    permission_classes = (IsManagerOrReadOnly, permissions.IsAuthenticated)

    def get_serializer_class(self):
        if self.request.method == 'GET':

            return GetResultSerializer
        return ResultSerializer

    def get_queryset(self):
        queryset = Result.objects.all()
        queryset = self.get_serializer_class().setup_eager_loading(queryset)
        if self.request.query_params:
            start = self.request.query_params.get('start')
            end = self.request.query_params.get('end')
            mode = self.request.query_params.get('mode', None)
            if start and end:
                queryset = queryset.filter(date__range=[start[:10], end[:10]])

            if mode == 'personal':
                queryset = queryset.filter(user=self.request.user)

        return queryset

    @swagger_auto_schema(
        operation_summary='獲得排班結果清單',
        operation_description='GET 的說明',
        manual_parameters=[start_date, end_date]
    )
    def list(self, request, *args, **kwargs):
        return super().list(self, request, *args, **kwargs)

    @swagger_auto_schema(
        operation_summary='更新資料',
        operation_description='PATCH 更改result',
    )
    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(
            instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)

        if getattr(instance, '_prefetched_objects_cache', None):
            # If 'prefetch_related' has been applied to a queryset, we need to
            # forcibly invalidate the prefetch cache on the instance.
            instance._prefetched_objects_cache = {}
        data = serializer.data
        shift = Shift.objects.get(id=data['shift'])

        data['shift_type'] = get_type(shift)
        return Response(data)


class PreResultViewSet(viewsets.ModelViewSet):
    queryset = PreResult.objects.all()
    serializer_class = PreResultSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetPreResultSerializer
        return PreResultSerializer

    def get_queryset(self):
        queryset = PreResult.objects.all()
        queryset = self.get_serializer_class().setup_eager_loading(queryset)
        if self.request.query_params:
            start = self.request.query_params.get('start')
            end = self.request.query_params.get('end')
            if start and end:
                queryset = PreResult.objects.filter(
                    date__range=[start[:10], end[:10]])
        return queryset

    @swagger_auto_schema(
        operation_summary='新增preresult',
        operation_description='增加新的筆班表',
    )
    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        data = serializer.data
        shift = Shift.objects.get(id=data['shift'])
        data['shift_type'] = get_type(shift)
        return Response(data, status=status.HTTP_201_CREATED, headers=headers)

    @swagger_auto_schema(
        operation_summary='更新資料',
        operation_description='PATCH 更改pre-result',
    )
    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(
            instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)

        if getattr(instance, '_prefetched_objects_cache', None):
            # If 'prefetch_related' has been applied to a queryset, we need to
            # forcibly invalidate the prefetch cache on the instance.
            instance._prefetched_objects_cache = {}
        data = serializer.data
        shift = Shift.objects.get(id=data['shift'])

        data['shift_type'] = get_type(shift)
        return Response(data)


class AfterResultViewSet(viewsets.ModelViewSet):
    queryset = AfterResult.objects.all()
    serializer_class = AfterResultSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetAfterResultSerializer
        return AfterResultSerializer

    def get_queryset(self):
        queryset = AfterResult.objects.all()
        queryset = self.get_serializer_class().setup_eager_loading(queryset)
        if self.request.query_params:
            start = self.request.query_params.get('start')
            end = self.request.query_params.get('end')
            if start and end:
                queryset = AfterResult.objects.filter(
                    date__range=[start[:10], end[:10]])
        return queryset


# 預排假 api
class ReservationViewSet(viewsets.ModelViewSet):
    queryset = Reservation.objects.all()
    serializer_class = ReservationSerializer
    permission_classes = (permissions.IsAuthenticated,)
    # 覆寫 create

    def create(self, request, *args, **kwargs):
        max_reserve = request.user.department.same_day_notice
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


# 人力配置 api
class DemandViewSet(viewsets.ModelViewSet):
    queryset = DemandOfStation.objects.all()
    serializer_class = DemandSerializer

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetDemandSerializer
        return DemandSerializer

    def get_queryset(self):
        queryset = DemandOfStation.objects.all()
        user = self.request.user
        dep = self.request.query_params.get('department')
        if not user.role == 'admin':
            stations = Station.objects.filter(department=user.department)
            queryset = queryset.filter(station__in=list(stations))
        if dep:
            dep_obj = Department.objects.get(id=int(dep))
            stations = Station.objects.filter(department=dep_obj)
            queryset = queryset.filter(station__in=list(stations))
        return queryset

    @swagger_auto_schema(
        operation_summary='新增Demand',
    )
    def create(self, request, pk=None, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        d = serializer.validated_data
        print(d)
        station = Station.objects.get(id=d['station'].id)
        shift = Shift.objects.get(id=d['shift'].id)
        try:
            DemandOfStation.objects.get(
                station=station,
                shift=shift,
                level=d['level']
            )
            return Response({'message': 'already exist'})
        except DemandOfStation.DoesNotExist:
            self.perform_create(serializer)
            headers = self.get_success_headers(serializer.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED,
                headers=headers)

    @swagger_auto_schema(
        operation_summary='刪除Demand',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


# 保證班 api
class PromiseShiftViewSet(viewsets.ModelViewSet):
    queryset = PromiseShift.objects.all()
    serializer_class = PromiseShiftSerializer
    permission_classes = (IsManagerOrReadOnly,)

# 重寫 create 根據 combo 產生複數的班
    @swagger_auto_schema(
        operation_summary='新增預排假勤',
    )
    def create(self, request, *args, **kwargs):
        """
        shift_type 分類
        0, 1, 2是無薪假
        2 之後的是有薪假

        (0, '事假'),
        (1, '家庭照顧假'),
        (2, '無薪病假'),
        (3, '公假'),
        (4, '產假'),
        (5, '例/休'),
        (6, '生理假'),
        (7, '特休'),
        (8, '補休'),
        (9, '婚假'),
        (10, '計薪病假'),
        (11, '喪假'),
        (12, '安胎休養假'),
        (13, '產檢假'),
        (14, '陪產假'),
        """
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(
            serializer.data, status=status.HTTP_201_CREATED,
            headers=headers)

    @swagger_auto_schema(
        operation_summary='刪除保證班',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetPromiseShiftSerializer
        return PromiseShiftSerializer

    def get_queryset(self):
        queryset = PromiseShift.objects.all()
        start = self.request.query_params.get('start', None)
        end = self.request.query_params.get('end', None)
        htype = self.request.query_params.get('shift_type', None)
        uid = self.request.query_params.get('uid', None)
        if self.request.query_params:
            if start and end:
                queryset = PromiseShift.objects.filter(
                    date__range=[start[:10], end[:10]])
            if htype:
                if htype == '3':
                    queryset = queryset.filter(
                        shift_type=3
                    )
                elif htype == '7':
                    queryset = queryset.filter(
                        shift_type=7
                    )
                else:
                    queryset = queryset.exclude(
                        shift_type__in=[3, 7]
                    )
            if uid:
                queryset = queryset.filter(
                    user=CustomUser.objects.get(id=int(uid))
                )

        return queryset


# 證照管理 api
class LiscenseViewSet(viewsets.ModelViewSet):
    queryset = Liscense.objects.all()
    serializer_class = LiscenseSerializer
    permission_classes = (permissions.IsAuthenticated,)

    def get_queryset(self):
        if self.request.query_params:
            mode = self.request.query_params.get('mode')
            uid = self.request.query_params.get('uid')
            if mode == 'personal' and uid:
                user = CustomUser.objects.get(id=int(uid))
                return Liscense.objects.filter(user=user)
            else:
                return Liscense.objects.all()
        return Liscense.objects.all()

    @swagger_auto_schema(
        operation_summary='刪除證照',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


# 換班 api
class ExchangeApplicationViewSet(viewsets.ModelViewSet):
    queryset = ExchangeApplication.objects.all()
    serializer_class = ExchangeApplicationSerializer
    permission_classes = (permissions.IsAuthenticated,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetExchangeApplicationSerializer
        return ExchangeApplicationSerializer

    def get_queryset(self):
        queryset = ExchangeApplication.objects.all()
        if self.request.query_params:
            mode = self.request.query_params.get('mode')
            if mode == 'personal':
                queryset = queryset.filter(
                    user_receive=self.request.user)
        return queryset

    @swagger_auto_schema(
        operation_summary='刪除調班',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )

# 排班檢查 api


@swagger_auto_schema(
    methods=['get', 'post'],
    operation_summary='檢查排班結果，回傳有問題的班',
    manual_parameters=[date, department]
)
@api_view(['GET', 'POST'])
@permission_classes([permissions.IsAuthenticated, ])
@parser_classes([JSONParser])
def check_result_api(request):
    res_data = {}
    if request.query_params:
        department = request.query_params.get('department')
        start_date = request.query_params.get('date')
        if start_date and department:
            date = datetime.datetime.strptime(
                start_date, '%Y-%m-%d'
            )
            res_data = check_pre_result(department, date.month)
    return Response(res_data)


# 通知的api
class NotificationViewSet(viewsets.ModelViewSet):
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer
    permission_classes = (permissions.IsAuthenticated,)

    def get_queryset(self):
        user = self.request.user
        queryset = Notification.objects.filter(recipient_id=int(user.id))
        return queryset

    @swagger_auto_schema(
        operation_summary='刪除通知',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


# 取得每天的白班，小夜，大夜總人數（總班表管理）

@swagger_auto_schema(
    methods=['get'],
    operation_summary='取得指定期間，每天三班的總人數',
    manual_parameters=[start_date, end_date])
@api_view(['GET'])
@permission_classes([permissions.IsAuthenticated, ])
@parser_classes([JSONParser])
def total_per_day_api(request):
    results = {}
    ret = []
    if request.query_params:
        start = request.query_params.get('start')
        end = request.query_params.get('end')
        q_set = request.query_params.get('set')

        dates = H_Calendar.objects.filter(date__range=[start, end])
        d = request.user.department
        demands = DemandOfStation.objects.prefetch_related('shift')\
            .prefetch_related('shift__department').all()

        time_adjustments = TimeAdjustment.objects.prefetch_related('user')\
            .exclude(remark__exact='')\
            .filter(
                date__range=[start, end],
                adjustment_type=0,
                adjustment_item__in=[0, 1, 2, 3, 4]
        )
        users = [
            u for u in CustomUser.objects.filter(
                department=d).exclude(type_of_user__in=[3, 5])]
        # demand 設定的人數
        for date in dates:
            date_str = date.date.strftime('%Y-%m-%d')
            results[date_str] = {'0': 0, '1': 0, '2': 0}
            config = int(date.attribute[str(d.id)])
            for demand in demands:
                if demand.shift.department == d:
                    s_type = demand.shift.shift_type
                    if s_type in [0, 1, 2]:
                        if config == 1:
                            results[date_str][str(s_type)] += demand.config1
                        elif config == 2:
                            results[date_str][str(s_type)] += demand.config2
                        else:
                            results[date_str][str(s_type)] += 0
            if date.attribute[str(d.id)] == '0':
                results[date_str] = {'0': 0, '1': 0, '2': 0}
        if q_set == 'result':
            db_results = Result.objects.prefetch_related('shift')\
                .filter(
                date__range=[start, end],
                user__in=users
            )
        else:
            db_results = PreResult.objects.prefetch_related('shift')\
                .filter(
                date__range=[start, end],
                user__in=users
            )
        diff_set = {}
        # 實際排出來的人數
        for date in dates:
            date_str = date.date.strftime('%Y-%m-%d')
            diff_set[date_str] = {'0': 0, '1': 0, '2': 0}
        for r in db_results:
            if r.shift.shift_type in [0, 1, 2]:
                diff_set[
                    r.date.strftime('%Y-%m-%d')][str(r.shift.shift_type)] += 1
        for adj in time_adjustments:
            date_str = adj.date.strftime('%Y-%m-%d')
            if adj.remark == '白班':
                diff_set[date_str]['0'] += 1
            if adj.remark == '小夜':
                diff_set[date_str]['1'] += 1
            if adj.remark == '大夜':
                diff_set[date_str]['2'] += 1
        ret = []
        for date in dates:
            date_str = date.date.strftime('%Y-%m-%d')
            change_dict = {'0': 'D', '1': 'E', '2': 'N'}
            new_obj = {
                'date': date_str
            }
            for i in ['0', '1', '2']:
                new_obj[change_dict[i]] = [
                    results[date_str][i], diff_set[date_str][i]
                ]
            ret.append(new_obj)

    return Response(ret)


@swagger_auto_schema(
    methods=['get'],
    operation_summary='把所有通知標為已讀',
    manual_parameters=[start_date, end_date])
@api_view(['GET'])
@permission_classes([permissions.IsAuthenticated, ])
@parser_classes([JSONParser])
def mark_all_notices_read(request):
    notices = Notification.objects.all()
    if request.user.role == 'admin' or request.user.is_superuser:
        notices.mark_all_as_read()
        return Response({'status': 'success'})
    else:
        return Response({'status': 'permission denied'})


class UserRemarkViewSet(viewsets.ModelViewSet):
    queryset = UserRemark.objects.all()
    serializer_class = UserRemarkSerializer
    permission_classes = (permissions.IsAuthenticated,)

    @swagger_auto_schema(
        operation_summary='刪除使用者備註',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


class RemarkSquareViewSet(viewsets.ModelViewSet):
    queryset = RemarkSquare.objects.all()
    serializer_class = RemarkSquareSerializer
    permission_classes = (permissions.IsAuthenticated,)

    @swagger_auto_schema(
        operation_summary='刪除備註方塊',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


class ResultRemarkViewSet(viewsets.ModelViewSet):
    queryset = ResultRemark.objects.all()
    serializer_class = ResultRemarkSerializer
    permission_classes = (permissions.IsAuthenticated,)

    @swagger_auto_schema(
        operation_summary='刪除班表備註',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


class PreResultRemarkViewSet(viewsets.ModelViewSet):
    queryset = PreResultRemark.objects.all()
    serializer_class = PreResultRemarkSerializer
    permission_classes = (permissions.IsAuthenticated,)

    @swagger_auto_schema(
        operation_summary='刪除預排班表備註',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


@swagger_auto_schema(
    methods=['get'],
    operation_summary='前月班表紀錄',
    manual_parameters=[month_head])
@api_view(['GET'])
@permission_classes([permissions.IsAuthenticated, ])
@parser_classes([JSONParser])
def last_month_continue(request):
    department = request.user.department
    users = User.objects.filter(department=department, can_be_scheduled=True)
    month_head = request.GET.get('month_head')
    date0 = datetime.datetime.strptime(month_head, '%Y-%m-%d').date()
    output = dict()
    type_dict = {
        '0': 'A',
        '1': 'E',
        '2': 'N',
        '3': '公',
        '7': '政',
    }
    for user in users:
        output[user.id] = list()
        results = Result.objects.filter(
            user=user, date__gte=date0 - timedelta(days=7),
            date__lte=date0 - timedelta(days=1)).order_by('date')
        for result in results:
            if result.shift.shift_type in [0, 1, 2, 3, 7]:
                output[user.id].append(str(result.shift.shift_type))
            else:
                output[user.id] = list()
        outstr = ''
        for x in output[user.id]:
            outstr += type_dict[x]
        output[user.id] = outstr

    return Response(output)


class DemandUserTableViewset(viewsets.ModelViewSet):
    queryset = DemandUserTable.objects.all()
    serializer_class = DemandUserTableSerializer
    permission_classes = (permissions.IsAuthenticated,)

    @swagger_auto_schema(
        operation_summary='刪除User跟Demand的關係',
    )
    def destroy(self, request, pk=None, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        res = {'message': 'success'}
        return Response(
            data=res,
            status=status.HTTP_200_OK,
        )


@swagger_auto_schema(
    methods=['get'],
    operation_summary='取得可換班使用者',
    manual_parameters=[date, exchange_shift_type],
)
@api_view(['GET'])
@parser_classes([JSONParser])
def exchangeable_user(request):
    """
    取得可換班的使用者
    :param user: 欲換班的使用者
    :return: 申請換班的日期
    :exchange_shift_type: 申請要換的班別
    """
    from datetime import datetime, timedelta
    user = request.user
    exchange_date = str_to_date(request.GET.get('date'))
    exchange_shift_type = request.GET.get('exchange_shift_type')
    try:
        to_change_result = Result.objects.get(user=user, date=exchange_date)
        to_change_work_time, to_change_off_time = get_work_time(
            to_change_result)
    except Result.DoesNotExist:
        return Response({
            'users': None,
            'messages': 'Result Not Found',
        })
    try:
        result_options = Result.objects.filter(
            user__department=user.department, date=exchange_date,
            shift__shift_type=exchange_shift_type).exclude(user=user)
    except Result.DoesNotExist:
        return Response({
            'users': None,
            'messages': 'None',
        })
    user_options = [result.user.id for result in result_options]
    for result in result_options:
        work_time, off_time = get_work_time(result)
        # 1. 前後班別休息時間是否間隔11小時
        # 申請者
        try:
            pre_result = Result.objects.get(
                user=user, date=exchange_date - timedelta(days=1))
            _, last_off_time = get_work_time(pre_result)
            if work_time - last_off_time < timedelta(hours=11):
                user_options.remove(result.user.id)
                continue
        except Result.DoesNotExist:
            pass
        try:
            next_result = Result.objects.get(
                user=user, date=exchange_date + timedelta(days=1))
            next_work_time, _ = get_work_time(next_result)
            if next_work_time - off_time < timedelta(hours=11):
                user_options.remove(result.user.id)
                continue
        except Result.DoesNotExist:
            pass
        # 接受者
        try:
            pre_result = Result.objects.get(
                user=result.user, date=exchange_date - timedelta(days=1))
            _, last_off_time = get_work_time(pre_result)
            if to_change_work_time - last_off_time < timedelta(hours=11):
                user_options.remove(result.user.id)
                continue
        except Result.DoesNotExist:
            pass
        try:
            next_result = Result.objects.get(
                user=result.user, date=exchange_date + timedelta(days=1))
            next_work_time, _ = get_work_time(next_result)
            if next_work_time - to_change_off_time < timedelta(hours=11):
                user_options.remove(result.user.id)
                continue
        except Result.DoesNotExist:
            pass
        # 2. 是否連續上班(原本休息才需要檢查)
        # 申請者
        if to_change_result.shift.name == '休息':

            results = Result.objects.filter(user=user, date__in=[
                                            exchange_date + timedelta(days=i) for i in range(-6, 7)]).order_by('date')
            shift_types = [exchange_shift_type if r.date ==
                           exchange_date else r.shift_type for r in results]

            count = 0
            for st in shift_types:
                if st in [0, 1, 2, 3, 7]:
                    count += 1
                    if count == 7:
                        user_options.remove(result.user.id)
                        break
                else:
                    count = 0
        # 接受者
        if result.shift.name == '休息':
            results = Result.objects.filter(user=result.user, date__in=[
                                            exchange_date + timedelta(days=i) for i in range(-6, 7)]).order_by('date')
            shift_types = [to_change_result.shift_type if r.date ==
                           exchange_date else r.shift_type for r in results]
            count = 0
            for st in shift_types:
                if st in [0, 1, 2, 3, 7]:
                    count += 1
                    if count == 7:
                        user_options.remove(result.user.id)
                        break
                else:
                    count = 0
    return Response({
        'users': user_options,
        'messages': 'Success',
    })


@swagger_auto_schema(
    methods=['get', ],
    operation_summary='跟班設定',
    manual_parameters=[start_date, end_date, follower, mentor]
)
@api_view(['GET'])
@permission_classes([permissions.IsAuthenticated, ])
@parser_classes([JSONParser])
def follow_shift_api(request):
    mentor = request.query_params.get('mentor')
    follower = request.query_params.get('follower')
    start = request.query_params.get('start')
    end = request.query_params.get('end')
    mentor_object = CustomUser.objects.get(id=int(mentor))
    follower_object = CustomUser.objects.get(id=int(follower))
    mentor_results = Result.objects.filter(
        user=mentor_object,
        date__range=[start, end]
    )
    Result.objects.filter(
        user=follower_object,
        date__range=[start, end]
    ).delete()
    for r in mentor_results:
        Result.objects.create(
            user=follower_object,
            date=r.date,
            station=r.station,
            shift=r.shift
        )

    return Response(
        data={'status': 'success'},
        status=status.HTTP_200_OK,
    )


@swagger_auto_schema(
    methods=['get', ],
    operation_summary='預排班表跟班設定',
    manual_parameters=[start_date, end_date, follower, mentor]
)
@api_view(['GET'])
@permission_classes([permissions.IsAuthenticated, ])
@parser_classes([JSONParser])
def preResult_follow_shift_api(request):
    mentor = request.query_params.get('mentor')
    follower = request.query_params.get('follower')
    start = request.query_params.get('start')
    end = request.query_params.get('end')
    mentor_object = CustomUser.objects.get(id=int(mentor))
    follower_object = CustomUser.objects.get(id=int(follower))
    mentor_results = PreResult.objects.filter(
        user=mentor_object,
        date__range=[start, end]
    )
    PreResult.objects.filter(
        user=follower_object,
        date__range=[start, end]
    ).delete()
    for r in mentor_results:
        PreResult.objects.create(
            user=follower_object,
            date=r.date,
            station=r.station,
            shift=r.shift
        )

    return Response(
        data={'status': 'success'},
        status=status.HTTP_200_OK,
    )


@swagger_auto_schema(
    methods=['get'],
    operation_summary='可支援人力',
    manual_parameters=[start, end],
)
@api_view(['GET'])
@parser_classes([JSONParser])
def users_can_support(request):
    from datetime import datetime, timedelta
    date_start = str_to_date(request.GET.get('start'))
    date_end = str_to_date(request.GET.get('end'))
    date_list = [date_start + timedelta(days=i)
                 for i in range((date_end - date_start).days + 1)]
    output = dict()
    for d in date_list:
        output[str(d)] = list()
    shifts = Shift.objects.filter(
        department=request.user.department, shift_type__in=[0, 1, 2, 7])
    for d in date_list:
        try:
            results = Result.objects.filter(
                date=d, shift__shift_type__in=[4, 5, 6])
        except Result.DoesNotExist:
            continue

        for result in results:
            output[str(d)].append({
                'id': result.user.id,
                'shift': result.shift.id,
                'can_support_shift': list(),
            })
            # 篩選班別名稱
            if result.shift.name not in ['休息', 'oncall']:
                continue
            # 篩選連續工作超過6天
            result_list = Result.objects.filter(user=result.user, date__in=[
                                                d + timedelta(days=i) for i in range(-6, 7)]).order_by('date')
            working_list = [1 if r.shift.shift_type in [
                0, 1, 2, 3, 7] or r.date == d else 0 for r in result_list]
            count = 0
            continue_over_6 = False
            for r in working_list:
                if r:
                    count += 1
                else:
                    count = 0
                if count > 6:
                    continue_over_6 = True
                    break
            if continue_over_6:
                continue
            # 篩選前後班表休息時間不足11小時
            try:
                pre_result = Result.objects.get(
                    user=result.user, date=d - timedelta(days=1))
                _, last_off_time = get_work_time(pre_result)
            except Result.DoesNotExist:
                last_off_time = datetime.combine(
                    d - timedelta(days=1), time(0, 0, 0))
            try:
                next_result = Result.objects.get(
                    user=result.user, date=d + timedelta(days=1))
                next_work_time, _ = get_work_time(next_result)
            except Result.DoesNotExist:
                next_work_time = datetime.combine(
                    d + timedelta(days=1), time(23, 59, 59))

            for shift in shifts:
                if shift.start_time > shift.end_time:
                    work_time = datetime.combine(d, shift.start_time)
                    off_time = datetime.combine(
                        d, shift.end_time) + timedelta(days=1)
                else:
                    work_time = datetime.combine(d, shift.start_time)
                    off_time = datetime.combine(d, shift.end_time)
                if work_time - last_off_time >= timedelta(hours=11) and next_work_time - off_time >= timedelta(hours=11):
                    output[str(d)][-1]['can_support_shift'].append(shift.id)
    return Response(output)


@swagger_auto_schema(
    methods=['post'],
    operation_summary='配置建議人數',
)
@api_view(['POST'])
@parser_classes([JSONParser])
def suggest_user_num(request, date_str):
    """
    計算人力配置的建議人數
    計算方式以週期為單位
    :param request:
    :param date_str:
    :return:
    """
    from datetime import date, timedelta

    date_str = date_str.split('-')
    year = int(date_str[0])
    month = int(date_str[1])
    date_0 = date(year=year, month=month, day=1)
    date_1 = date(year=year + 1, month=1, day=1) - timedelta(days=1) if month == 12 \
        else date(year=year, month=month + 1, day=1) - timedelta(days=1)
    configs = request.data
    department = request.user.department

    output = [{
        'type_of_user': 'senior',
        'suggest_num': max(configs['level1']['config1'], configs['level1']['config2']),
    }, {
        'type_of_user': 'total',
        'suggest_num': max(configs['level2']['config1'], configs['level2']['config2']),
    }]

    ca = cycle_analysis(department, date_0)
    cycle_no = ca['cycle_no']
    cycle0 = get_cycle(department, cycle_no)
    cycle = cycle0
    cycle_list = [cycle]
    while cycle[-1] < date_1:
        cycle_no += 1
        cycle = get_cycle(department, cycle_no)
        cycle_list.append(cycle)

    for c in cycle_list:
        demand_s, demand_t = 0, 0
        attrs = attr_list(department.id, c[0], c[-1])
        reds = red_dict(c[0], c[-1])
        z_num = len(c) / 7
        r_num = list(reds.values()).count(True) - z_num
        d_num = 0
        for i, d in enumerate(c):
            if date_0 <= d <= date_1:
                d_num += 1
                if attrs[i] == '1':
                    demand_s += configs['level2']['config1']
                    demand_t += configs['level1']['config1'] + \
                        configs['level2']['config1']
                elif attrs[i] == '2':
                    demand_s += configs['level1']['config2']
                    demand_t += configs['level2']['config2'] + \
                        configs['level1']['config2']
        z_num = ceil(d_num / 7)
        r_num = floor(r_num * d_num / len(c))
        workday_num = d_num - z_num - r_num

        output[0]['suggest_num'] = max(
            output[0]['suggest_num'], ceil(demand_s / workday_num))
        output[1]['suggest_num'] = max(
            output[1]['suggest_num'], ceil(demand_t / workday_num))

    return Response(output)


@swagger_auto_schema(
    methods=['get'],
    operation_summary='手動重排',
    manual_parameters=[start, end],
)
@api_view(['GET'])
@parser_classes([JSONParser])
def recreate_result(request):
    department = request.user.department

    try:
        date_start = str_to_date(request.GET.get('start'))
        date_end = str_to_date(request.GET.get('end'))

        date_last = date_start - timedelta(days=1)
    except ValueError:
        return Response({
            'message': 'wrong date input',
        })

    # 檢查班表是否已建立
    try:
        exist = Result.objects.filter(
            date=date_start, user__department=department)
        if len(exist):
            return Response({
                'message': 'results already exist',
            })
    except Result.DoesNotExist:
        pass

    PreResult.objects.filter(user__department=department,
                             date__gte=date_start, date__lte=date_end).delete()

    # 日期資料
    date_list = [date_start + timedelta(days=i)
                 for i in range((date_end - date_start).days + 1)]
    attrs = attr_list(department.id, date_start, date_end)
    reds = red_dict(date_start, date_end)

    # 連續工作天、預排假、保證假、公假
    continue_dict = get_continue_days(department, date_start)
    reserve_leave_dict = get_reserve_leave(department, date_start, date_end)
    promise_leave_dict = get_promise_leave(department, date_start, date_end)
    promise_other_dict = get_promise_other(department, date_start, date_end)
    official_leave_dict = get_official_leave(department, date_start, date_end)

    rest_dict = {
        0: '事假',
        1: '家庭照顧假',
        2: '無薪病假',
        # 3: '公假',
        4: '產假',
        # 5: '例/休',
        6: '生理假',
        7: '特休',
        8: '補休',
        9: '婚假',
        10: '計薪病假',
        11: '喪假',
        12: '安胎休養假',
        13: '產檢假',
        14: '陪產假',
    }

    # create cycle list
    ca = cycle_analysis(department, date_start)
    cycle_no = ca['cycle_no']
    cycle0 = get_cycle(department, cycle_no)
    cycle = cycle0
    cycle_list = [cycle]
    while cycle[-1] < date_end:
        cycle_no += 1
        cycle = get_cycle(department, cycle_no)
        cycle_list.append(cycle)

    # 印出每個cycle的第一天
    print([c[0] for c in cycle_list])

    # cycle0已排好的(前月的)班表
    used_rest = get_used_rest(department, cycle0[0], date_start)

    # get all stations, shifts in department
    stations = get_stations(department)
    shifts = get_shifts(department)

    output = dict()

    # 例假/休息用的 shift & station
    station_rest = Station.objects.get(
        department=department,
        name='休假',
    )
    station_official_leave = Station.objects.get(
        department=department,
        name='公假',
    )
    shift_rest0 = Shift.objects.get(
        department=department,
        name='例假',
    )
    shift_rest1 = Shift.objects.get(
        department=department,
        name='休息',
    )
    shift_official_leave = Shift.objects.get(
        department=department,
        name='公假',
    )

    for station in stations:
        for shift in shifts:

            # 排1工作站1班別
            user_pool = dict()
            workday_dict = dict()
            demands = get_demands(station, shift)

            # diff_dict 紀錄需求偏差
            diff_dict = dict()

            for demand in demands:

                # 當前level的user
                user_current_level = list()

                # 建立參與排班的user池 & output
                if not demand['users']:
                    continue
                for user in demand['users']:
                    user_current_level.append(user.id)
                    user_pool.update({
                        user.id: {
                            'holiday_rest': user.holiday_rest_num - user.holiday_rest_num_used,
                            'reserve_leave': reserve_leave_dict[user.id],
                            'promise_leave': promise_leave_dict[user.id],
                            'promise_other': [str_to_date(d) for d in promise_other_dict[user.id]],
                            'official_leave': official_leave_dict[user.id],
                        },
                    })

                    output[user.id] = dict()
                    output[user.id][str(date_last)] = continue_dict[user.id]
                    for d in date_list:
                        if d in official_leave_dict[user.id]:
                            output[user.id][str(d)] = 1
                        else:
                            output[user.id][str(d)] = 0
                    workday_dict[user.id] = dict()

                # 建立需求單
                demand_dict = dict()
                for ind, d in enumerate(date_list):
                    if attrs[ind] == '0':
                        demand_dict[str(d)] = 0
                    elif attrs[ind] == '1':
                        demand_dict[str(d)] = demand['demand'].config1
                    elif attrs[ind] == '2':
                        demand_dict[str(d)] = demand['demand'].config2

                # 調整預排假，若人數許可則改為保證假
                for d in date_list:
                    count_reserve = 0
                    count_promise = 0
                    user_l = list()
                    for user_id in user_current_level:
                        if d in user_pool[user_id]['reserve_leave']:
                            count_reserve += 1
                            user_l.append(user_id)
                        elif d in (user_pool[user_id]['promise_leave'] + user_pool[user_id]['promise_other'] + user_pool[user_id]['official_leave']):
                            count_promise += 1
                    if len(user_current_level) - count_promise - count_reserve > demand_dict[str(d)]:
                        for user_id in user_l:
                            user_pool[user_id]['reserve_leave'].remove(d)
                            user_pool[user_id]['promise_leave'].append(d)

                # for cycle 計算班表
                for ind, cycle in enumerate(cycle_list):

                    # set workday_dict
                    if ind == 0:
                        for user in demand['users']:
                            workday_dict[user.id][ind] = get_workday_num(
                                user.id, cycle[0], cycle[-1], start=date_start)
                    elif ind == len(cycle_list) - 1:
                        for user in demand['users']:
                            workday_dict[user.id][ind] = get_workday_num(
                                user.id, cycle[0], cycle[-1], end=date_end)
                    else:
                        for user in demand['users']:
                            workday_dict[user.id][ind] = get_workday_num(
                                user.id, cycle[0], cycle[-1])

                    # 計算可工作天數、需求數
                    total_demands = sum(
                        [demand_dict[str(d)] for d in cycle if date_start <= d <= date_end])
                    total_workdays = sum([workday_dict[user_id][ind]
                                          for user_id in user_pool])

                    # 計算需求校正參數
                    diff = total_workdays - total_demands
                    day_num = len(
                        [d for d in cycle if date_start <= d <= date_end])
                    diff_q = diff // day_num
                    diff_r = diff % day_num

                    for _ in range(10000):

                        # 產生需求校正list和指標
                        diff_list = [
                            diff_q for d in cycle if date_start <= d <= date_end]
                        if demand['demand'].level == 1:
                            adjust_weight = [
                                1 if i in diff_dict[ind] else 100 for i in range(day_num)]
                            weight_sum = sum(adjust_weight)
                            adjust_weight = [
                                i / weight_sum for i in adjust_weight]
                            adjust_index = choice(
                                day_num, diff_r, p=adjust_weight, replace=False)
                        else:
                            adjust_index = choice(
                                day_num, diff_r, replace=False)
                        for i in range(day_num):
                            if i in adjust_index:
                                diff_list[i] += 1
                        diff_ind = 0

                        # 每次回圈重設 temp_output、weight_workday、weight_holiday_rest
                        # create temp_output
                        temp_output = deepcopy(output)

                        # set weight, start calculating
                        weight_workday = dict(
                            [(user_id, workday_dict[user_id][ind]) for user_id in user_pool])
                        weight_holiday_rest = dict(
                            [(user_id, user_pool[user_id]['holiday_rest']) for user_id in user_pool])
                        for d in cycle:
                            if date_start <= d <= date_end:

                                # user可排人選
                                options = list()

                                # 必帶人數
                                assign_num = 0

                                for user_id, user_data in user_pool.items():

                                    # 若有公假則工作天數-1
                                    if d in user_data['official_leave']:
                                        weight_workday[user_id] -= 1

                                    # 特殊假、公假、保證假、工作天不足 略過
                                    if d in (user_data['promise_leave'] + user_data['official_leave'] + user_data[
                                            'promise_other']) or weight_workday[user_id] == 0 or temp_output[user_id][
                                            str(d)] != 0:
                                        continue
                                    s = 0
                                    d_n = d - timedelta(days=1)
                                    d_p = d + timedelta(days=1)
                                    while str(d_n) in temp_output[user_id]:
                                        if temp_output[user_id][str(d_n)] != 0:
                                            s += temp_output[user_id][str(d_n)]
                                            d_n = d_n - timedelta(days=1)
                                        else:
                                            break
                                    while str(d_p) in temp_output[user_id]:
                                        if temp_output[user_id][str(d_p)] != 0:
                                            s += temp_output[user_id][str(d_p)]
                                            d_p = d_p + timedelta(days=1)
                                        else:
                                            break
                                    if s < 6:
                                        # 檢查是否必帶
                                        if str(d - timedelta(days=1)) in temp_output[user_id] and \
                                                str(d - timedelta(days=2)) in temp_output[user_id]:
                                            if temp_output[user_id][str(d - timedelta(days=1))] == 1 and \
                                                    temp_output[user_id][str(d - timedelta(days=2))] == 0:
                                                temp_output[user_id][str(
                                                    d)] = 1
                                                assign_num += 1
                                                weight_workday[user_id] -= 1
                                            else:
                                                options.append(user_id)
                                        else:
                                            if temp_output[user_id][str(d - timedelta(days=1))] == 1:
                                                temp_output[user_id][str(
                                                    d)] = 1
                                                assign_num += 1
                                                weight_workday[user_id] -= 1
                                            else:
                                                options.append(user_id)

                                # 需求小於等於被指定人數or需求等於0 直接進入下一天
                                if demand_dict[str(d)] + diff_list[diff_ind] <= assign_num or \
                                        demand_dict[str(d)] + diff_list[diff_ind] <= 0:
                                    continue

                                # 可排人數不足or需求小於等於被指定人數 跳出
                                if len(options) < demand_dict[str(d)] + diff_list[diff_ind] - assign_num:
                                    break

                                # 預排假權重(100倍)
                                weight_reserve_leave = dict()
                                for user_id in options:
                                    if d in user_pool[user_id]['reserve_leave']:
                                        weight_reserve_leave[user_id] = 1
                                    else:
                                        weight_reserve_leave[user_id] = 100

                                weight = list()
                                if reds[str(d)]:
                                    # 若為休假日 則剩餘 可休假假日數 越少的人被排到的機率越高
                                    for user_id in options:
                                        weight.append(weight_workday[user_id] * weight_reserve_leave[user_id] *
                                                      (100 - weight_holiday_rest[user_id]) * 1000 + 1)
                                else:
                                    for user_id in options:
                                        weight.append(
                                            weight_workday[user_id] * weight_reserve_leave[user_id] * 1000 + 1)
                                weight_sum = sum(weight)
                                weight = [w / weight_sum for w in weight]

                                try:
                                    on_duty = choice(options, demand_dict[str(d)] + diff_list[diff_ind] - assign_num,
                                                     p=weight, replace=False)
                                except ValueError:
                                    for user_id in options:
                                        print(user_id, weight_workday[user_id])
                                    
                                for user_id in user_pool:
                                    if user_id in on_duty:
                                        temp_output[user_id][str(d)] = 1
                                        weight_workday[user_id] -= 1
                                        if reds[str(d)] and user_id not in user_current_level:
                                            weight_holiday_rest[user_id] += 1
                                    elif reds[str(d)] and user_id in user_current_level:
                                        weight_holiday_rest[user_id] -= 1
                                diff_ind += 1
                        else:
                            # 成功排完 1 cycle
                            # 儲存結果
                            output = temp_output
                            print(station.name, shift.name, 'Cycle', str(ind), 'Success in 10000')

                            # 儲存剩餘工作天 & 可休假假日數
                            for user_id in user_pool:
                                workday_dict[user_id][ind] = weight_workday[user_id]
                                user_pool[user_id]['holiday_rest'] = weight_holiday_rest[user_id]

                            # 若 demand.level == 2, 紀錄 diff_list
                            if demand['demand'].level == 2:
                                diff_dict[ind] = adjust_index

                            # 結束迴圈
                            break
                    else:
                        # 嘗試10000次皆失敗，強制產生班表，不必滿足所有需求
                        # 嘗試排班100次，取最滿足需求的結果
                        best_temp_output = None
                        demand_loss = total_demands

                        best_weight_workday = dict()
                        best_weight_holiday_rest = dict()

                        for _ in range(100):

                            # 產生需求校正list
                            diff_list = [
                                diff_q for d in cycle if date_start <= d <= date_end]
                            if demand['demand'].level == 1:
                                adjust_weight = [
                                    1 if i in diff_dict[ind] else 100 for i in range(day_num)]
                                weight_sum = sum(adjust_weight)
                                adjust_weight = [
                                    i / weight_sum for i in adjust_weight]
                                adjust_index = choice(
                                    day_num, diff_r, p=adjust_weight, replace=False)
                            else:
                                adjust_index = choice(
                                    day_num, diff_r, replace=False)
                            for i in range(day_num):
                                if i in adjust_index:
                                    diff_list[i] += 1
                            diff_ind = 0

                            # 每次回圈重設 weight_workday、weight_holiday_rest
                            temp_demand_loss = 0
                            temp_output = deepcopy(output)

                            # set weight, start calculating
                            weight_workday = dict(
                                [(user_id, workday_dict[user_id][ind]) for user_id in user_pool])
                            weight_holiday_rest = dict(
                                [(user_id, user_pool[user_id]['holiday_rest']) for user_id in user_pool])

                            for d in cycle:
                                if date_start <= d <= date_end:

                                    # user可排人選
                                    options = list()

                                    # 必帶人數
                                    assign_num = 0

                                    for user_id, user_data in user_pool.items():

                                        # 若有公假則工作天數-1
                                        if d in user_data['official_leave']:
                                            weight_workday[user_id] -= 1

                                        # 特殊假、公假、保證假、工作天不足 略過
                                        if d in (user_data['promise_leave'] + user_data['official_leave'] +
                                                 user_data['promise_other']) or weight_workday[user_id] == 0 or \
                                                temp_output[user_id][str(d)] != 0:
                                            continue
                                        s = 0
                                        d_n = d - timedelta(days=1)
                                        d_p = d + timedelta(days=1)
                                        while str(d_n) in temp_output[user_id]:
                                            if temp_output[user_id][str(d_n)] != 0:
                                                s += temp_output[user_id][str(d_n)]
                                                d_n = d_n - timedelta(days=1)
                                            else:
                                                break
                                        while str(d_p) in temp_output[user_id]:
                                            if temp_output[user_id][str(d_p)] != 0:
                                                s += temp_output[user_id][str(d_p)]
                                                d_p = d_p + timedelta(days=1)
                                            else:
                                                break
                                        if s < 6:
                                            # 檢查是否必帶
                                            if str(d - timedelta(days=1)) in temp_output[user_id] and \
                                                    str(d - timedelta(days=2)) in temp_output[user_id]:
                                                if temp_output[user_id][str(d - timedelta(days=1))] == 1 and \
                                                        temp_output[user_id][str(d - timedelta(days=2))] == 0:
                                                    temp_output[user_id][str(
                                                        d)] = 1
                                                    assign_num += 1
                                                    weight_workday[user_id] -= 1
                                                else:
                                                    options.append(user_id)
                                            else:
                                                if temp_output[user_id][str(d - timedelta(days=1))] == 1:
                                                    temp_output[user_id][str(
                                                        d)] = 1
                                                    assign_num += 1
                                                    weight_workday[user_id] -= 1
                                                else:
                                                    options.append(user_id)

                                    # 需求小於等於被指定人數 直接進入下一天
                                    if demand_dict[str(d)] + diff_list[diff_ind] <= assign_num:
                                        continue

                                    if len(options) <= demand_dict[str(d)] + diff_list[diff_ind] - assign_num:
                                        # 可排人數不足或等於需求 所有可排人員皆排班 記錄差額
                                        temp_demand_loss += demand_dict[str(
                                            d)] + diff_list[diff_ind] - len(options)
                                        for user_id in user_pool:
                                            if user_id in options:
                                                temp_output[user_id][str(
                                                    d)] = 1
                                                weight_workday[user_id] -= 1
                                                if reds[str(d)] and user_id not in user_current_level:
                                                    weight_holiday_rest[user_id] += 1
                                            elif reds[str(d)] and user_id in user_current_level:
                                                weight_holiday_rest[user_id] -= 1
                                    else:
                                        # 預排假權重
                                        weight_reserve_leave = dict()
                                        for user_id in options:
                                            if d in user_pool[user_id]['reserve_leave']:
                                                weight_reserve_leave[user_id] = 1
                                            else:
                                                weight_reserve_leave[user_id] = 10

                                        weight = list()
                                        if reds[str(d)]:
                                            for user_id in options:
                                                weight.append(
                                                    weight_workday[user_id] * weight_reserve_leave[user_id] * (
                                                        100 - weight_holiday_rest[user_id]) * 1000 + 1)
                                        else:
                                            for user_id in options:
                                                weight.append(weight_workday[user_id] * weight_reserve_leave[
                                                    user_id] * 1000 + 1)
                                        weight_sum = sum(weight)
                                        weight = [
                                            w / weight_sum for w in weight]
                                        on_duty = choice(
                                            options, demand_dict[str(d)] + diff_list[diff_ind] - assign_num, p=weight,
                                            replace=False)
                                        for user_id in user_pool:
                                            if user_id in on_duty:
                                                temp_output[user_id][str(
                                                    d)] = 1
                                                weight_workday[user_id] -= 1
                                                if reds[str(d)] and user_id not in user_current_level:
                                                    weight_holiday_rest[user_id] += 1
                                            elif reds[str(d)] and user_id in user_current_level:
                                                weight_holiday_rest[user_id] -= 1
                                    diff_ind += 1

                            if temp_demand_loss < demand_loss:
                                demand_loss = temp_demand_loss
                                best_temp_output = temp_output
                                best_weight_workday = weight_workday
                                best_weight_holiday_rest = weight_holiday_rest

                                # 若 demand.level == 2, 紀錄 diff_list
                                if demand['demand'].level == 2:
                                    diff_dict[ind] = adjust_index

                        output = best_temp_output

                        # 儲存剩餘工作天 & 可休假假日數
                        for user_id in user_pool:
                            workday_dict[user_id][ind] = best_weight_workday[user_id]
                            user_pool[user_id]['holiday_rest'] = best_weight_holiday_rest[user_id]

            for user_id in user_pool:
                user = CustomUser.objects.get(id=user_id)

                output[user_id].pop(str(date_last))
                q = used_rest[user_id]

                # 天數指標
                ind_date = 0

                for ind, cycle in enumerate(cycle_list):

                    # 計算cycle天數並取得例休假總天數
                    cycle_len = 7 * 2 ** department.law_rule

                    # 計算例休天數
                    z_num = 2 ** department.law_rule

                    # 第一個週期
                    if ind == 0:
                        # 調整週期長
                        cycle_len = len([d for d in cycle if d >= date_start])

                        # 取得總休假日數
                        rest_num = list(output[user_id].values())[
                            ind_date:ind_date + cycle_len].count(0)

                        for st in q:
                            if st == '例':
                                z_num -= 1

                        options = ['例'] * z_num + ['休'] * (rest_num - z_num)
                    # 最後一個週期
                    elif ind == len(cycle_list) - 1:
                        rest_num = list(output[user_id].values())[
                            ind_date:ind_date + cycle_len].count(0)
                        z_num = round(
                            z_num * len([d for d in cycle if d <= date_end]) / cycle_len)
                        options = ['例'] * z_num + ['休'] * (rest_num - z_num)
                    else:
                        rest_num = list(output[user_id].values())[
                            ind_date:ind_date + cycle_len].count(0)
                        options = ['例'] * z_num + ['休'] * (rest_num - z_num)
                    ind_date += cycle_len

                    q = q[-6:]
                    for d in cycle:
                        if date_start <= d <= date_end:
                            # 增加公假Result
                            if d in user_pool[user_id]['official_leave']:
                                output[user_id][str(d)] = '工'
                                PreResult.objects.create(
                                    user=user,
                                    shift=shift_official_leave,
                                    date=d,
                                    station=station_official_leave,
                                )
                            # 增加上班Result
                            elif output[user_id][str(d)] == 1:
                                output[user_id][str(d)] = '工'
                                PreResult.objects.create(
                                    user=user,
                                    shift=shift,
                                    date=d,
                                    station=station,
                                )
                            # 增加特殊假Result
                            elif d in user_pool[user_id]['promise_other']:
                                output[user_id][str(d)] = '特'
                                PreResult.objects.create(
                                    user=user,
                                    shift=Shift.objects.get(
                                        department=department, name=rest_dict[promise_other_dict[user_id][str(d)]]),
                                    date=d,
                                    station=station_rest,
                                )
                                if '休' in options:
                                    options.remove('休')
                            # 增加例假 or 休息Result
                            else:
                                if '例' not in q and '例' in options:
                                    options.remove('例')
                                    output[user_id][str(d)] = '例'
                                    PreResult.objects.create(
                                        user=user,
                                        shift=shift_rest0,
                                        date=d,
                                        station=station_rest,
                                    )
                                elif '休' in options:
                                    options.remove('休')
                                    output[user_id][str(d)] = '休'
                                    PreResult.objects.create(
                                        user=user,
                                        shift=shift_rest1,
                                        date=d,
                                        station=station_rest,
                                    )
                                else:
                                    options.remove('例')
                                    output[user_id][str(d)] = '例'
                                    PreResult.objects.create(
                                        user=user,
                                        shift=shift_rest0,
                                        date=d,
                                        station=station_rest,
                                    )
                            q.append(output[user_id][str(d)])
                            if len(q) > 6:
                                q.pop(0)

    # 行政職
    try:
        user_admin = CustomUser.objects.filter(type_of_user=2)
        station_admin = Station.objects.get(department=department, name='行政')
        shift_admin = Shift.objects.get(department=department, name='行政')

        for user in user_admin:
            for i, d in enumerate(date_list):
                if reds[str(d)] or attrs[i] == '0':
                    if d.isoweekday() == 7:
                        PreResult.objects.create(
                            user=user,
                            shift=shift_rest0,
                            date=d,
                            station=station_rest,
                        )
                    else:
                        PreResult.objects.create(
                            user=user,
                            shift=shift_rest1,
                            date=d,
                            station=station_rest,
                        )
                elif d in official_leave_dict[user.id]:
                    PreResult.objects.create(
                        user=user,
                        shift=shift_official_leave,
                        date=d,
                        station=station_official_leave,
                    )
                elif str(d) in promise_other_dict[user.id]:
                    PreResult.objects.create(
                        user=user,
                        shift=Shift.objects.get(department=department,
                                                name=rest_dict[promise_other_dict[user.id][str(d)]]),
                        date=d,
                        station=station_rest,
                    )
                else:
                    PreResult.objects.create(
                        user=user,
                        shift=shift_admin,
                        date=d,
                        station=station_admin,
                    )
    except CustomUser.DoesNotExist:
        pass

    return Response({
        'message': 'Success',
    })
