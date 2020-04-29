from django.urls import path, include
from . import views
from rest_framework import routers


router = routers.DefaultRouter()
router.register(r'users', views.CustomUserViewSet)
router.register(r'stations', views.StationViewSet)
router.register(r'shifts', views.ShiftViewSet)
router.register(r'departments', views.DepartmentViewSet)
router.register(r'dates', views.OnedayViewSet)
router.register(r'results', views.ResultViewSet)
router.register(r'preresults', views.PreResultViewSet)
router.register(r'afterresults', views.AfterResultViewSet)
router.register(r'reservations', views.ReservationViewSet)
router.register(r'demands', views.DemandViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls',
                              namespace='rest_framework')),
]
