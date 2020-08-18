from django.contrib import admin
from .models import Station

# Register your models here.


class StationAdmin(admin.ModelAdmin):
    model = Station
    list_display = ['id', 'name', 'department']


admin.site.register(Station, StationAdmin)
