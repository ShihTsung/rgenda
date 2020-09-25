from .views import *
from django.urls import path

urlpatterns = [
    path('create', station_create),
    path('list', station_list),
    path('update/<int:id>', station_edit),
    path('delete/<int:id>', station_delete)
    ]
