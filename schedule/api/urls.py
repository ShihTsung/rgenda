from django.urls import path, include
from . import views
from rest_framework import routers


router = routers.DefaultRouter()
router.register(r'users', views.CustomUserViewSet)
router.register(r'stations', views.StationViewSet)
router.register(r'shifts', views.ShiftViewSet)
router.register(r'departments', views.DepartmentViewSet)
router.register(r'dates', views.OnedayViewSet)
router.register(r'result', views.ResultViewSet)
router.register(r'preresult', views.PreResultViewSet)
router.register(r'afterresult', views.AfterResultViewSet)
router.register(r'reservation', views.ReservationViewSet)
router.register(r'demands', views.DemandViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls',
                              namespace='rest_framework')),
]
