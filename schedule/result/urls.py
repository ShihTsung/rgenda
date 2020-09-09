from .views import *
from django.urls import path

urlpatterns = [
   path('', show_results),
   path('read_only/', user_results),
   path('pre_results', show_pre_result),
   path('after_results', show_after_result),
   path('publish', publish_result),
   path('to_history', result_to_history),
   path('time_adjustment', time_adjustment_list),
   path('exchange_application_list', exchange_application_list),
   path('exchange_application_audit', exchange_application_audit),
   path('create_result/<int:department_id>/<start>/<end>', create_result),
   path('delete/<int:year>/<int:month>', temp_remove),
   path('preresult-test', test_preresult)
]
