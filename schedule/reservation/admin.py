from django.contrib import admin
from .models import Reservation, PromiseShift
# Register your models here.


class ReservationAdmin(admin.ModelAdmin):
    model = Reservation
    list_display = ['id', 'user', ]


class PromiseShiftAdmin(admin.ModelAdmin):
    model = PromiseShift
    list_display = ['id', 'user', 'date', 'shift_type']

# class LevelAdmin(admin.ModelAdmin):
#     model = Level
#     list_display = '__all__'


admin.site.register(Reservation, ReservationAdmin)
