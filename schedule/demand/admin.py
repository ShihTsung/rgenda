from django.contrib import admin
from .models import DemandOfStation

# Register your models here.


class DemandOfStationAdmin(admin.ModelAdmin):
    model = DemandOfStation
    list_display = ['id', 'level', 'shift', 'workday', 'holiday']


admin.site.register(DemandOfStation, DemandOfStationAdmin)
