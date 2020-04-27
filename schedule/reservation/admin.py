from django.contrib import admin
from .models import Reservation
# Register your models here.


class ReservationAdmin(admin.ModelAdmin):
    model = Reservation
    list_display = ['id', 'user', 'year', 'shift']

# class LevelAdmin(admin.ModelAdmin):
#     model = Level
#     list_display = '__all__'


admin.site.register(Reservation, ReservationAdmin)
