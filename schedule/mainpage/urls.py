from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='home'),
    path('test', views.schedule_test),
    path('statistics-department', views.statistics_department),
    path('statistics-person', views.statistics_person),
]
