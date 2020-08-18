from django.contrib import admin
from .models import Shift
# Register your models here.


class ShiftAdmin(admin.ModelAdmin):
    model = Shift
    list_display = [
        'id', 'start_time', 'end_time',
        'shift_type', 'work_hours'
    ]


admin.site.register(Shift, ShiftAdmin)
