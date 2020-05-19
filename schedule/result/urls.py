from .views import *
from django.urls import path

urlpatterns = [
   path('', show_results),
   path('read_only/', user_results),
   path('pre_results', show_pre_result),
   path('after_results', show_after_result),
   path('publish', publish_result),
   path('to_history', result_to_history)
]
