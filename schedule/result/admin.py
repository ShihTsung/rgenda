from django.contrib import admin
from .models import Result, PreResult, AfterResult
# Register your models here.


class ResultAdmin(admin.ModelAdmin):
    model = Result
    list_display = ['id', 'shift', 'date', 'station', 'user']


class PreResultAdmin(admin.ModelAdmin):
    model = PreResult
    list_display = ['id', 'shift', 'date', 'station', 'user']


class AfterResultAdmin(admin.ModelAdmin):
    model = AfterResult
    list_display = ['id', 'shift', 'date', 'station', 'user']


admin.site.register(PreResult, PreResultAdmin)
admin.site.register(Result, ResultAdmin)
admin.site.register(AfterResult, AfterResultAdmin)
