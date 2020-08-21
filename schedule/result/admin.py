from django.contrib import admin
from .models import Result
# Register your models here.


class ResultAdmin(admin.ModelAdmin):
    model = Result
    list_display = ['id', 'shift', 'date', 'station', 'user']


admin.site.register(Result, ResultAdmin)
