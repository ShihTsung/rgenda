from django.contrib import admin
from .models import DemandOfStation, DemandUserTable

# Register your models here.


class DemandOfStationAdmin(admin.ModelAdmin):
    model = DemandOfStation

    list_display = ['id', 'level', 'shift', 'config1', 'config2', 'station']


class DemandUserTableAdmin(admin.ModelAdmin):
    model = DemandUserTable

    list_display = ['id', 'demand', 'user']


admin.site.register(DemandOfStation, DemandOfStationAdmin)
admin.site.register(DemandUserTable, DemandUserTableAdmin)