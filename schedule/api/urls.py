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
router.register(r'time-ajustment', views.TimeAdjustmentViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls',
                              namespace='rest_framework')),
    path('checkresult/', views.check_result_api),
    path('total-per-day/', views.total_per_day_api),
    path('notification/mark-all-as-read', views.mark_all_notices_read)
]
