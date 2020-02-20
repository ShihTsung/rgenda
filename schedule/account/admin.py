from django.contrib import admin
from django.contrib.auth import get_user_model
from django.contrib.auth.admin import UserAdmin
from django.utils.translation import gettext, gettext_lazy as _
from .forms import CustomUserCreationForm, CustomUserChangeForm
from .models import CustomUser


class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = ['username', 'id', 'email', 'level',
                    'department', 'gid', 'eid', 'onboard_date']
    fieldsets = UserAdmin.fieldsets + (
        (_('Profile'), {'fields': (
            'eng_name',
            'level',
            'department',
            'gender',
            'gid',
            'eid',
            'onboard_date')}),
    )


# class LevelAdmin(admin.ModelAdmin):
#     model = Level
#     list_display = '__all__'


admin.site.register(CustomUser, CustomUserAdmin)
