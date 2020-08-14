from random import choices
from django import forms
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from .models import CustomUser, Department
from django.utils.translation import gettext_lazy as _
from django.core.validators import ValidationError
from datetime import datetime
from crispy_forms.helper import FormHelper
import os

ROLE_CHOICES = (
    ('admin', _('admin')),
    ('manager', _('manager')),
    ('user', _('user'))
)
LEVEL_CHOICES = (
    (4, _('N4')),
    (3, _('N3')),
    (2, _('N2')),
    (1, _('N1')),
    (5, _('Nn'))
)
GENDER_CHOICES = (
    ('M', _('Male')),
    ('F', _('Female'))
)
TYPE_CHOICES = (
    (0, _('正職')),
    (1, _('資深正職')),
    (2, _('行政職')),
    (3, _('新進人員')),
    (4, _('兼職人員')),
    (5, _('實習生')),
)


class DateInput(forms.DateInput):
    input_type = 'date'


# 建立帳號
class CustomUserCreationForm(UserCreationForm):
    department = forms.ModelChoiceField(
        queryset=Department.objects.all(),
        label=_('Department'), required=False)

    onboard_date = forms.DateField(
        label=_('OnboardDate'),
        widget=DateInput(attrs={'type': 'date'}))

    can_be_scheduled = forms.BooleanField(
        label='是否可排班',
        required=False,
    )

    class Meta:
        model = CustomUser
        help_texts = {}
        fields = ['username', 'email', 'password1', 'password2', 'full_name',
                  'department', 'level', 'gender', 'role',
                  'type_of_user', 'can_be_scheduled', 'eid',
                  'onboard_date']

    def __init__(self, *args, **kwargs):
        super(UserCreationForm, self).__init__(*args, **kwargs)

        for fieldname in ['username', 'password1', 'password2']:
            self.fields[fieldname].help_text = None


# 編輯帳號
class CustomUserChangeForm(UserChangeForm):

    department = forms.ModelChoiceField(
        queryset=Department.objects.all(),
        label=_('科別'), required=False)

    level = forms.IntegerField(label=_('職級'), widget=forms.widgets.Select(
        choices=LEVEL_CHOICES))

    job_title = forms.CharField(
        max_length=100,
        label=_('職稱'),
        required=False
    )

    full_name = forms.CharField(
        max_length=100,
        label=_('姓名'),
        required=False)

    role = forms.CharField(
        max_length=100,
        label=_('權限'),
        widget=forms.widgets.Select(choices=ROLE_CHOICES)
    )

    gender = forms.CharField(
        label=_('性別'),
        max_length=20,
        widget=forms.widgets.Select(
            choices=GENDER_CHOICES),
        required=False
    )
    type_of_user = forms.IntegerField(
        label=_('排班身份'),
        widget=forms.widgets.Select(
            choices=TYPE_CHOICES)
    )
    pregnant = forms.BooleanField(
        label=_('其他'),
        required=False,
    )
    can_be_scheduled = forms.BooleanField(
        label=_('排班狀況'),
        required=False,
        initial=False
    )

    holiday_rest_num = forms.IntegerField(
        label=_('假日可休假日數'),
        disabled=True,
        required=False
    )
    special_rest_num = forms.IntegerField(
        label=_('特休'),
        disabled=True,
        required=False
    )
    hour_required = forms.IntegerField(
        label=_('應排班時數'),
        disabled=True,
        required=False
    )

    eid = forms.CharField(label=_('工號'),
                          max_length=100, empty_value="Null")
    onboard_date = forms.DateField(
        label=_('到職日'),
        widget=DateInput)

    class Meta:
        model = CustomUser
        widgets = {
            'onboard_date': DateInput(format=('%Y-%m-%d'),
                                      attrs={'class': 'form-control',
                                             'type': 'date'
                                             })
        }
        fields = ('username', 'full_name', 'email', 'department', 'job_title',
                  'level', 'gender', 'role', 'type_of_user',
                  'can_be_scheduled', 'holiday_rest_num',
                  'special_rest_num', 'hour_required',
                  'eid', 'onboard_date')

# 消除 help_text

    # def __init__(self, *args, **kwargs):
    #     super().__init__(*args, **kwargs)
    #     field_list = ['username', 'first_name', 'last_name', 'email',
    #                   'department', 'level', 'gender',
    #                   'is_staff', 'is_superuser', 'is_active', 'password']
    #     for fieldname in field_list:
    #         self.fields[fieldname].help_text = None


class DepartmentCreationForm(forms.ModelForm):
    name = forms.CharField(
        label=_('簡稱'),
        max_length=100, empty_value="Null",
        required=True)
    detail = forms.CharField(
        label=_('科別名稱'),
        max_length=100, empty_value="Null",
        required=False)

    class Meta:
        model = Department
        help_texts = {}
        fields = ['name', 'detail']


class DepartmentChangeForm(forms.ModelForm):
    name = forms.CharField(
        label=_('簡稱'),
        max_length=100,
        empty_value="Null",
        required=True)
    detail = forms.CharField(
        label=_('科別名稱'),
        max_length=100,
        empty_value="Null",
        required=False)
    limit_pre_schedule = forms.IntegerField(
        label=_("預約休假數量"),
        min_value=0,
        max_value=31,
    )
    deadline_pre_schedule = forms.ChoiceField(
        label=_("預約休假期限"),
        required=True,
        widget=forms.Select,
        choices=[(i, i) for i in range(1, 29)],
    )
    reset = forms.ChoiceField(
        label=_('時數重置規則'),
        required=True,
        widget=forms.Select,
        choices=[(0, _('PerYear(at 1/1)')), (1, _('PerMonth(at 1)'))],
    )
    law_rule = forms.ChoiceField(
        label=_("勞基法工時規則"),
        required=True,
        widget=forms.Select,
        choices=[
            (0, '一般工時（7休2）'),
            (1, '雙週變形工時（14休4）'),
            (2, '四周變形工時（28休8）'),
            (3, '八週變形工時（56休16）'),
        ],
    )
    schedule_rule = forms.ChoiceField(
        label=_("班種設定"),
        required=True,
        widget=forms.Select,
        choices=[
            (0, '花班'),
            (1, '單月同班種'),
            (2, '三月同班種'),
        ],
    )
    admin_in_schedule = forms.BooleanField(
        label=_("管理者是否排班"),
        required=False,
    )
    same_day_notice = forms.IntegerField(
        label=_("預約休假日人數過多提示"),
        required=True,
        min_value=0,
    )
    date_start = forms.DateField(
        label=_('起算日期'),
        required=True,
        widget=DateInput,
        localize=False)

    class Meta:
        model = Department
        help_texts = {}
        widgets = {
            'start_date': DateInput(format=('%Y-%m-%d'),
                                    attrs={'class': 'form-control',
                                           'type': 'date'
                                           })
        }
        fields = ['name', 'detail', 'limit_pre_schedule',
                  'deadline_pre_schedule', 'reset', 'law_rule',
                  'schedule_rule', 'admin_in_schedule',
                  'date_start']


class ImportForm(forms.Form):
    file = forms.FileField(
        required=True,
        widget=forms.FileInput(
            attrs={
                'accept': '.xlsx',
            }
        )
    )
