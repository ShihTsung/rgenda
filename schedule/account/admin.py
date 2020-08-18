from django.contrib import admin
from django.contrib.auth import get_user_model
from django.contrib.auth.admin import UserAdmin
from django.utils.translation import gettext, gettext_lazy as _
from .forms import CustomUserCreationForm, CustomUserChangeForm
from .models import CustomUser, Department


class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = ['username', 'id', 'email', 'level',
                    'department', 'eid', 'onboard_date']
    fieldsets = UserAdmin.fieldsets + (
        (_('Profile'), {'fields': (
            'role', 'type_of_user', 'can_be_scheduled', 'holiday_rest_num',
            'special_rest_num', 'hour_required', 'hour_realized',
            'level', 'job_title',
            'department',
            'gender',
            'eid',
            'onboard_date')}),
    )


class DepartmentAdmin(admin.ModelAdmin):
    model = Department
    list_display = ['id', 'name', 'detail']

# class LevelAdmin(admin.ModelAdmin):
#     model = Level
#     list_display = '__all__'


admin.site.register(CustomUser, CustomUserAdmin)
admin.site.register(Department, DepartmentAdmin)
