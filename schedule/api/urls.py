from django.urls import path, include
from . import views
from rest_framework import routers


router = routers.DefaultRouter()
router.register(r'users', views.CustomUserViewSet, basename='users')
router.register(r'stations', views.StationViewSet, basename='stations')
router.register(r'shifts', views.ShiftViewSet, basename='shifts')
router.register(r'departments', views.DepartmentViewSet)
router.register(r'dates', views.HCalendarViewSet)
router.register(r'results', views.ResultViewSet, basename='results')
router.register(r'preresults', views.PreResultViewSet, basename='preresults')
router.register(r'afterresults', views.AfterResultViewSet,
                basename='afterresults')
router.register(r'reservations', views.ReservationViewSet,
                basename='reservations')
router.register(r'demands', views.DemandViewSet,
                basename='demands')
router.register(r'promises', views.PromiseShiftViewSet,
                basename='promises')
router.register(r'liscenses', views.LiscenseViewSet,
                basename='liscenses')
router.register(r'notifications', views.NotificationViewSet,
                basename='notifications')
router.register(r'time-adjustment', views.TimeAdjustmentViewSet,
                basename='time-adjustment')
router.register(r'user-remarks', views.UserRemarkViewSet,
                basename='user-remarks')
router.register(r'remark-squares', views.RemarkSquareViewSet,
                basename='remark-squares')
router.register(r'result-remarks', views.ResultRemarkViewSet,
                basename='result-remarks')
router.register(r'demand-user', views.DemandUserTableViewset,
                basename='demand-user')
router.register(r'exchange-shift', views.ExchangeApplicationViewSet,
                basename='exchange-shift')
router.register(r'department-manager', views.DepartmentManagerViewSet,
                basename='department-manager')
router.register(r'preresult-remarks', views.PreResultRemarkViewSet,
                basename='preresult-remarks')


urlpatterns = [
    path('auth/login/', views.auth_login),
    path('auth/logout/', views.auth_logout),
    path('auth/me/', views.auth_me),
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
    path('user-resource', views.ordered_users)
]
