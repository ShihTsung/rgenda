from django.urls import path, include
from . import views

urlpatterns = [
    path('reserve', views.reserve),
    path('promises', views.promises),
    path('time-adjustment', views.time_adjustment)
]
