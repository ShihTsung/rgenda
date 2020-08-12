# django
from django.shortcuts import render

# restframework
from rest_framework import viewsets, generics, permissions, status
from rest_framework.decorators import action, api_view, parser_classes
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import BasePermission, SAFE_METHODS
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from rest_framework.parsers import JSONParser

# others
from datetime import datetime, timedelta
from .check import *
from .serializers import *
from notifications.models import Notification

# models
from account.models import CustomUser, Department, Liscense
from station.models import Station
from shift.models import Shift
from date.models import H_Calendar
from result.models import Result, PreResult, AfterResult, TimeAdjustment, ExchangeApplication
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


"""
CustomUserViewSet     |帳號 api
DepartmentViewSet     |部門 api
ShiftViewSet          |班別 api
StationViewSet        |工站 api
HCalendarViewSet      |日期 api
ResultViewSet         |已發布排班結果 api
PreResultViewSet      |未發布排班結果 api
AfterResultViewSet    |已執行排班結果 api
ReservationViewSet    |預排假 api
DemandViewSet         |人力需求 api
PromiseShiftViewSet   |管理者排班 api
"""

get_all = openapi.Parameter('all', openapi.IN_QUERY,
                            description="全部或是單一部門", type=openapi.TYPE_BOOLEAN)
start_date = openapi.Parameter('start', openapi.IN_QUERY,
                               description="開始日期", type=openapi.TYPE_STRING)
end_date = openapi.Parameter('end', openapi.IN_QUERY,
                             description="結束日期", type=openapi.TYPE_STRING)
mode = openapi.Parameter('mode', openapi.IN_QUERY,
                         description="模式", type=openapi.TYPE_STRING)


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
        queryset = self.queryset
        mode = self.request.query_params.get('mode', None)
        dep = self.request.query_params.get('department', None)

        if mode == 'onlyUser':
            return CustomUser.objects.filter(is_staff=False)
        if mode == 'resource':
            user = self.request.user
            if user.role == 'manager':
                return CustomUser.objects.filter(
                    department=user.department,
                    can_be_scheduled=True)
            if user.role == 'admin' or user.is_superuser:
                return CustomUser.objects.filter(can_be_scheduled=True)
        if dep is not None:
            target = Department.objects.get(id=dep)
            return CustomUser.objects.filter(department=target)
        return CustomUser.objects.all()

    @swagger_auto_schema(
        operation_summary='獲得使用者清單',
        operation_description='GET 的說明',
        manual_parameters=[mode, ]
    )
    def list(self, request, *args, **kwargs):
        return super().list(request, *args, **kwargs)

    @swagger_auto_schema(
        operation_summary='新增使用者',
        operation_description='POST 的說明',
    )
    def create(self, request, *args, **kwargs):
        return super().create(request, *args, **kwargs)

    @swagger_auto_schema(
        operation_summary='獲得個別使用者',
        operation_description='GET 單一個體的說明',
    )
    def retrieve(self, request, pk=None, *args, **kwargs):
        return super().retrieve(request, *args, **kwargs)

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
        return super().destroy(request, pk, *args, **kwargs)


class TimeAdjustmentViewSet(viewsets.ModelViewSet):
    queryset = TimeAdjustment.objects.all()
    serializer_class = TimeAdjustmentSerializer

    @swagger_auto_schema(
        operation_summary='調班清單',
        operation_description='列出所有調班清單',
    )
    def list(self, request, *args, **kwargs):
        return super().list(request, *args, **kwargs)


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
        if self.request.query_params:
            if self.request.query_params.get('all') == "True":
                return queryset
            else:
                return queryset.filter(department=user.department)
        else:
            return queryset.filter(department=user.department)

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
        return super().list(request, *args, **kwargs)


class StationViewSet(viewsets.ModelViewSet):
    queryset = Station.objects.all()
    serializer_class = StationSerializer
    permission_classes = (IsManagerOrReadOnly,)

    def get_serializer_class(self):
        if self.request.method == 'GET':
            return GetStationSerializer
        return StationSerializer


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
        return super().list(request)


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


# 保證班 api
class PromiseShiftViewSet(viewsets.ModelViewSet):
    queryset = PromiseShift.objects.all()
    serializer_class = PromiseShiftSerializer
    permission_classes = (IsManagerOrReadOnly,)

# 重寫 create 根據 combo 產生複數的班
    def create(self, request, *args, **kwargs):
        r_data = request.data
        combo = int(r_data['combo'])
        date_obj = datetime.strptime(r_data['date'], '%Y-%m-%d')
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


# 換班 api
class ExchangeApplicationViewSet(viewsets.ModelViewSet):
    queryset = ExchangeApplication.objects.all()

# class CheckResultView(APIView):
#     """
#     檢查排班結果
#     * Requires token authentication.
#     * Only admin users are able to access this view.
#     """
#     authentication_classes = [authentication.TokenAuthentication]
#     permission_classes = [permissions.IsAdminUser]

#     def get(self, request, format=None):
#         """
#         Return a list of all users.
#         """
#         usernames = [user.username for user in User.objects.all()]
#         return Response(usernames)


# 排班檢查 api
@swagger_auto_schema(
    methods=['get', 'post'],
    operation_summary='檢查排班結果，回傳有問題的班',
)
@api_view(['GET', 'POST'])
@parser_classes([JSONParser])
def check_result_api(request):
    res_data = {}
    if request.query_params:
        department = request.query_params.get('department')
        month = request.query_params.get('month')

        test = check_result(department, int(month))

        res_data = dict(test[0])
        res_data['message'] = "Hello, world!"
    return Response(res_data)


# 通知的api
class NotificationViewSet(viewsets.ModelViewSet):
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer
    permission_classes = (permissions.IsAuthenticated,)


# 取得每天的白班，小夜，大夜總人數（總班表管理）

@swagger_auto_schema(
    methods=['get'],
    operation_summary='取得指定期間，每天三班的總人數',
    manual_parameters=[start_date, end_date])
@api_view(['GET'])
@parser_classes([JSONParser])
def total_per_day_api(request):
    results = {}
    if request.query_params:
        start = request.query_params.get('start')
        end = request.query_params.get('end')

        dates = H_Calendar.objects.filter(date__range=[start, end])
        d = request.user.department
        demands = DemandOfStation.objects.all()
        for date in dates:
            date_str = date.date.strftime('%Y-%m-%d')
            results[date_str] = {'白班': 0, '小夜': 0, '大夜': 0}
            config = 1
            for demand in demands:
                if demand.shift.department == d:
                    s_type = demand.shift.shift_type
                    if s_type in ['白班', '小夜', '大夜']:
                        if config == 1:
                            results[date_str][s_type] += demand.config1
                        elif config == 2:
                            results[date_str][s_type] += demand.config2
                        else:
                            results[date_str][s_type] = 0
    return Response(results)


@swagger_auto_schema(
    methods=['get'],
    operation_summary='把所有通知標為已讀',
    manual_parameters=[start_date, end_date])
@api_view(['GET'])
@parser_classes([JSONParser])
def mark_all_notices_read(request):
    notices = Notification.objects.all()
    if request.user.role == 'admin' or request.user.is_superuser:
        notices.mark_all_as_read()
        return Response({'status': 'success'})
    else:
        return Response({'status': 'permission denied'})
