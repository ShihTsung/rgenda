from .views import *
from django.urls import path

urlpatterns = [
    path('create', condition_create),
    path('list', condition_list),
    path('update/<int:id>', condition_edit),
    path('delete/<int:id>', condition_delete)
    ]
