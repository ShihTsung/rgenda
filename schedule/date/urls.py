from django.urls import path, include
from . import views

urlpatterns = [
    path('date_management', views.date_manage, name="dateManage"),
]
