from .views import *
from django.urls import path

urlpatterns = [
    path('create', demand_create),
    path('list', demand_list),
    path('update', demand_edit),
    path('delete/<int:id>', demand_delete)
    ]
