from .views import *
from django.urls import path

urlpatterns = [
   path('', show_results),
   path('read_only/', user_results),
]
