from .views import *
from django.urls import path

urlpatterns = [
    path('create', shift_create),
    path('list', shift_list),
    path('update', shift_edit),
    path('delete/<int:id>', shift_delete)
]
