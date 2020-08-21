# django
from django.shortcuts import render

# restframework
from rest_framework import viewsets, generics, permissions, status
from rest_framework.decorators import (
    action, api_view, parser_classes,
    permission_classes)
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import BasePermission, IsAuthenticated, SAFE_METHODS
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from rest_framework.parsers import JSONParser

# others
from datetime import datetime, timedelta
from .check import *
from .serializers import *
from notifications.models import Notification
from notifications.signals import notify
from result.views import str_to_date

# models
from account.models import CustomUser, Department, Liscense, DepartmentManager
from station.models import Station
from shift.models import Shift
from date.models import H_Calendar
from result.models import (Result, PreResult,
                           AfterResult, TimeAdjustment, ExchangeApplication)
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
end_date = openapi.Parameter('end', openapi.IN_QUERY,
                             description="結束日期", type=openapi.TYPE_STRING)
mode = openapi.Parameter('mode', openapi.IN_QUERY,
                         description="模式", type=openapi.TYPE_STRING)
month_head = openapi.Parameter('month_head', openapi.IN_QUERY,
                               description="月初日", type=openapi.TYPE_STRING)
uid = openapi.Parameter('uid', openapi.IN_QUERY,
                        description="使用者id", type=openapi.TYPE_STRING)
department = openapi.Parameter('department', openapi.IN_QUERY,
                               description="科別", type=openapi.TYPE_STRING)
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
                               description="部門(id)", type=openapi.TYPE_INTEGER)


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
    permission_classes = (IsAuthenticated,)

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


class DepartmentViewSet(viewsets.ModelViewSet):
    queryset = Department.objects.all()
    serializer_class = DepartmentSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetDepartmentSerializer
        return DepartmentSerializer

    def get_queryset(self):
        return Department.objects.filter(id=self.request.user.department.id)


class DepartmentManagerViewSet(viewsets.ModelViewSet):
    queryset = DepartmentManager.objects.all()
    serializer_class = DepartmentManagerSerializer
    permission_classes = (IsAuthenticated,)


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
        if self.request.query_params:
            start = self.request.query_params.get('start')
            end = self.request.query_params.get('end')
            if not end:
                end = start
            return H_Calendar.objects.filter(date__range=[start[:10], end[:10]])
        else:
            return H_Calendar.objects.all()


def get_type(shift):
    if shift.shift_type == 0:
        return 'A'
    elif shift.shift_type == 1:
        return 'E'
    elif shift.shift_type == 2:
        return 'N'
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
        return 'On'
    elif shift.shift_type == 3:
        return '公'
    else:
        return ''


class ResultViewSet(viewsets.ModelViewSet):
    queryset = Result.objects.all()
    serializer_class = ResultSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':

            return GetResultSerializer
        return ResultSerializer

    def get_queryset(self):
        if self.request.query_params:
            start = self.request.query_params.get('start')
            end = self.request.query_params.get('end')
            mode = self.request.query_params.get('mode', None)
            if not end:
                end = start
            if mode == 'personal':
                return Result.objects.filter(
                    date__range=[start[:10], end[:10]],
                    user=self.request.user)
            return Result.objects.filter(date__range=[start[:10], end[:10]])
        return Result.objects.all()

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
        if self.request.query_params:
            start = self.request.query_params.get('start')
            end = self.request.query_params.get('end')
            if not end:
                end = start
            return PreResult.objects.filter(date__range=[start[:10], end[:10]])
        return PreResult.objects.all()


class AfterResultViewSet(viewsets.ModelViewSet):
    queryset = AfterResult.objects.all()
    serializer_class = AfterResultSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetAfterResultSerializer
        return AfterResultSerializer

    def get_queryset(self):
        if self.request.query_params:
            start = self.request.query_params.get('start')
            end = self.request.query_params.get('end')
            if not end:
                end = start
            return AfterResult.objects.filter(
                date__range=[start[:10], end[:10]])
        return AfterResult.objects.all()


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
    def create(self, request, *args, **kwargs):
        r_data = request.data
        combo = int(r_data['combo'])
        date_obj = datetime.datetime.strptime(
            r_data['date'], '%Y-%m-%d').date()
        if combo > 10:
            return Response(
                'can not create more than 10 promise per time',
                status=status.HTTP_400_BAD_REQUEST)
        for i in range(combo):
            r_data['date'] = date_obj.strftime('%Y-%m-%d')
            r_data['year'] = r_data['date'][:4]
            serializer = self.get_serializer(data=r_data)
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)
            date_obj += timedelta(days=1)
        headers = self.get_success_headers(serializer.data)
        return Response(
            serializer.data,
            status=status.HTTP_201_CREATED,
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
        start = self.request.query_params.get('start', None)
        end = self.request.query_params.get('end', None)
        if self.request.query_params:
            return PromiseShift.objects.filter(
                date__range=[start[:10], end[:10]])
        else:
            return PromiseShift.objects.all()


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
    manual_parameters=[month, department]
)
@api_view(['GET', 'POST'])
@permission_classes([IsAuthenticated])
@parser_classes([JSONParser])
def check_result_api(request):
    res_data = {}
    if request.query_params:
        department = request.query_params.get('department')
        month = request.query_params.get('month')

        res_data = check_result(department, int(month))
    return Response(res_data)


# 通知的api
class NotificationViewSet(viewsets.ModelViewSet):
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer
    permission_classes = (permissions.IsAuthenticated,)

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
@permission_classes([IsAuthenticated])
@parser_classes([JSONParser])
def total_per_day_api(request):
    results = {}
    ret = []
    if request.query_params:
        start = request.query_params.get('start')
        end = request.query_params.get('end')

        dates = H_Calendar.objects.filter(date__range=[start, end])
        d = request.user.department
        demands = DemandOfStation.objects.all()
        users = [u for u in CustomUser.objects.filter(department=d)]
        for date in dates:
            date_str = date.date.strftime('%Y-%m-%d')
            results[date_str] = {'0': 0, '1': 0, '2': 0}
            config = 1
            for demand in demands:
                if demand.shift.department == d:
                    s_type = demand.shift.shift_type
                    if s_type in [0, 1, 2]:
                        if config == 1:
                            results[date_str][str(s_type)] += demand.config1
                        elif config == 2:
                            results[date_str][str(s_type)] += demand.config2
                        else:
                            results[date_str][str(s_type)] = 0
        db_results = Result.objects.filter(
            date__range=[start, end], user__in=users)
        diff_set = {}
        for date in dates:
            date_str = date.date.strftime('%Y-%m-%d')
            diff_set[date_str] = {'0': 0, '1': 0, '2': 0}
        for r in db_results:
            if r.shift.shift_type in [0, 1, 2]:
                diff_set[
                    r.date.strftime('%Y-%m-%d')][str(r.shift.shift_type)] += 1
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
@permission_classes([IsAuthenticated])
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


@swagger_auto_schema(
    methods=['get'],
    operation_summary='前月班表紀錄',
    manual_parameters=[month_head])
@api_view(['GET'])
@permission_classes([IsAuthenticated])
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
        '3': '公'
    }
    for user in users:
        output[user.id] = list()
        results = Result.objects.filter(
            user=user, date__gte=date0 - timedelta(days=7),
            date__lte=date0 - timedelta(days=1)).order_by('date')
        for result in results:
            if result.shift.shift_type in [0, 1, 2, 3]:
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
    except Result.DoesNotExist:
        return Response({
            'users': None,
            'messages': 'Result Not Found',
        })
    try:
        result_options = Result.objects.filter(user__department=user.department, date=exchange_date,
                                               shift__shift_type=exchange_shift_type).exclude(user=user)
    except Result.DoesNotExist:
        return Response({
            'users': None,
            'messages': 'None',
        })
    user_options = [result.user.id for result in result_options]
    for result in result_options:
        # 1. 前後班別休息時間是否間隔11小時
        # 申請者
        try:
            pre_result = Result.objects.get(
                user=user, date=exchange_date - timedelta(days=1))
            if pre_result.shift.shift_type == 2 and pre_result.shift.end_time < pre_result.shift.start_time:
                last_off_time = datetime.combine(
                    exchange_date, pre_result.shift.end_time)
            elif pre_result.shift.shift_type in [0, 1, 2]:
                last_off_time = datetime.combine(
                    pre_result.date, pre_result.shift.end_time)
            else:
                last_off_time = datetime.combine(
                    pre_result.date, time(0, 0, 0))
            if datetime.combine(exchange_date, result.shift.start_time) - last_off_time < timedelta(hours=11):
                user_options.remove(result.user.id)
                continue
        except Result.DoesNotExist:
            pass
        try:
            next_result = Result.objects.get(
                user=user, date=exchange_date + timedelta(days=1))
            if result.shift.shift_type == 2 and result.shift.start_time > result.shift.end_time:
                off_time = datetime.combine(
                    exchange_date + timedelta(days=1), result.shift.end_time)
            elif result.shift.shift_type in [0, 1, 2]:
                off_time = datetime.combine(
                    exchange_date, result.shift.end_time)
            else:
                off_time = datetime.combine(exchange_date, time(0, 0, 0))
            if next_result.shift.shift_type in [0, 1, 2] and datetime.combine(exchange_date + timedelta(days=1), next_result.shift.start_time) - datetime.combine(exchange_date, result.shift.end_time) < timedelta(hours=11):
                user_options.remove(result.user.id)
                continue
        except Result.DoesNotExist:
            pass
        # 接受者
        try:
            pre_result = Result.objects.get(
                user=result.user, date=exchange_date - timedelta(days=1))
            if pre_result and pre_result.shift.shift_type in [0, 1, 2] and datetime.combine(exchange_date, to_change_result.shift.start_time) - datetime.combine(exchange_date - timedelta(days=1), pre_result.shift.end_time) < timedelta(hours=11):
                user_options.remove(result.user.id)
                continue
        except Result.DoesNotExist:
            pass
        try:
            next_result = Result.objects.get(
                user=result.user, date=exchange_date + timedelta(days=1))
            if next_result and next_result.shift.shift_type in [0, 1, 2] and datetime.combine(exchange_date + timedelta(days=1), next_result.shift.start_time) - datetime.combine(exchange_date, to_change_result.shift.end_time) < timedelta(hours=11):
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
                if st in [0, 1, 2, 3]:
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
                if st in [0, 1, 2, 3]:
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
@permission_classes([IsAuthenticated])
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
    methods=['get'],
    operation_summary='可支援人力',
    manual_parameters=[date],
)
@api_view(['GET'])
@parser_classes([JSONParser])
def users_can_support(request):
    from datetime import datetime, timedelta
    target_date = str_to_date(request.GET.get('date'))
    output = list()
    try:
        results = Result.objects.filter(
            date=target_date, shift__name__in=['休息', 'oncall'])
    except Result.DoesNotExist:
        return Response(output)

    for result in results:
        output.append({
            'id': result.user.id,
            'shift_type': result.shift.shift_type,
            'can_support': list(),
        })
        result_list = Result.objects.filter(user=result.user, date__in=[
                                            target_date + timedelta(days=i) for i in range(-6, 7)]).order_by('date')
        count = 0
        for r in result_list:
            if r.shift.shift_type in [0, 1, 2, 3]:
                count += 1
            else:
                count = 0
            if count > 6:
                continue
        try:
            pre_result = Result.objects.get(
                user=result.user, date=target_date - timedelta(days=1))
            if pre_result.shift.shift_type == 2 and pre_result.shift.start_time > pre_result.shift.end_time:
                last_off_time = datetime.combine(
                    target_date, pre_result.shift.end_time)
            elif pre_result.shift.shift_type in [0, 1, 2]:
                last_off_time = datetime.combine(
                    pre_result.date, pre_result.shift.end_time)
            else:
                last_off_time = datetime.combine(
                    pre_result.date, time(0, 0, 0))
        except Result.DoesNotExist:
            last_off_time = datetime.combine(pre_result.date, time(0, 0, 0))
        try:
            next_result = Result.objects.get(
                user=result.user, date=target_date + timedelta(days=1))
            if next_result.shift.shift_type in [0, 1, 2]:
                next_start_time = datetime.combine(
                    target_date + timedelta(days=1), next_result.shift.start_time)
            else:
                next_start_time = datetime.combine(
                    target_date + timedelta(days=1), time(23, 59, 59))
        except Result.DoesNotExist:
            next_start_time = datetime.combine(
                target_date + timedelta(days=1), time(23, 59, 59))


@swagger_auto_schema(
    methods=['get'],
    operation_summary='發布班表通知',
    manual_parameters=[month],
)
@api_view(['GET'])
@parser_classes([JSONParser])
def publish_results(request):
    month = request.query_params.get('month')
    department = request.user.department
    if month:
        notify.send(
            sender=request.user,
            recipient=CustomUser.objects.filter(
                department=department
            ),
            verb=f'{month}月班表已經發布！'

        )
    return Response({})
