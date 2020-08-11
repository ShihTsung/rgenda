from django.contrib import admin
from .models import DemandOfStation

# Register your models here.


class DemandOfStationAdmin(admin.ModelAdmin):
    model = DemandOfStation
    list_display = ['id', 'level', 'shift', 'config1', 'config2']


admin.site.register(DemandOfStation, DemandOfStationAdmin)
