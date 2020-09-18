from django.urls import path, include
from . import views
from rest_framework import routers


router = routers.DefaultRouter()
router.register(r'users', views.CustomUserViewSet)
router.register(r'stations', views.StationViewSet)
router.register(r'shifts', views.ShiftViewSet)
router.register(r'departments', views.DepartmentViewSet)
router.register(r'dates', views.HCalendarViewSet)
router.register(r'results', views.ResultViewSet)
router.register(r'preresults', views.PreResultViewSet)
router.register(r'afterresults', views.AfterResultViewSet)
router.register(r'reservations', views.ReservationViewSet)
router.register(r'demands', views.DemandViewSet)
router.register(r'promises', views.PromiseShiftViewSet)
router.register(r'liscenses', views.LiscenseViewSet)
router.register(r'notifications', views.NotificationViewSet)
router.register(r'time-adjustment', views.TimeAdjustmentViewSet)
router.register(r'user-remarks', views.UserRemarkViewSet)
router.register(r'remark-squares', views.RemarkSquareViewSet)
router.register(r'result-remarks', views.ResultRemarkViewSet)
router.register(r'demand-user', views.DemandUserTableViewset)
router.register(r'exchange-shift', views.ExchangeApplicationViewSet)
router.register(r'department-manager', views.DepartmentManagerViewSet)
router.register(r'preresult-remarks', views.PreResultRemarkViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls',
                              namespace='rest_framework')),
    path('checkresult/', views.check_result_api),
    path('total-per-day/', views.total_per_day_api),
    path('notification/mark-all-as-read', views.mark_all_notices_read),
    path('last-month-continue', views.last_month_continue),
    path('exchangeable-users/', views.exchangeable_user),
    path('follow-shift', views.preResult_follow_shift_api),
    path('users-can-support/', views.users_can_support),
    path('suggest-user-num/<date_str>/', views.suggest_user_num),
    path('recreate-result-periodic', views.recreate_result_periodic),
    path('recreate-result-monthly', views.recreate_result_monthly),
    path('recreate-result-monthly-b', views.recreate_result_monthly_b),
    path('published-or-not', views.published_or_not),
    path('publish-results', views.publish_result),
]
