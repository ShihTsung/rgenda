from django import forms
from django.utils.translation import gettext_lazy as _
from .models import Shift
from account.models import Department


LEVEL_CHOICES = (
    (3, _('Leader')),
    (2, _('Senior')),
    (1, _('Junior'))
)

START_HOUR_CHOICES = (
    (i, i) for i in range(1, 25)
)

END_HOUR_CHOICES = (
    (i, i) for i in range(1, 25)
)

START_MIN_CHOICES = (
    (i, i) for i in range(0, 61, 5)
)

END_MIN_CHOICES = (
    (i, i) for i in range(0, 61, 5)
)

TYPE_CHOICES = (
    ('白班', '白班'),
    ('小夜', '小夜'),
    ('大夜', '大夜'),
    ('休假', '休假'),
    ('公假', '公假'),
    ('oncall', 'oncall')
)

"""
班別管理
"""


class ShiftCreationForm(forms.ModelForm):
    name = forms.CharField(max_length=100, label=_('Name'))
    shift_type = forms.CharField(
        max_length=100,
        label=_('ShiftType'),
        widget=forms.widgets.Select(choices=TYPE_CHOICES))
    start_time = forms.TimeField(label=_('StartTime'))
    end_time = forms.TimeField(label=_('EndTime'))
    department = forms.ModelChoiceField(
        queryset=Department.objects.all(),
        label=_('Department'))
    work_hours = forms.FloatField(label=_('WorkHours'))

    class Meta:
        model = Shift
        fields = ['name', 'shift_type', 'start_time',
                  'end_time', 'department', 'work_hours']


START_HOUR_CHOICES = (
    (i, i) for i in range(1, 25)
)

END_HOUR_CHOICES = (
    (i, i) for i in range(1, 25)
)

START_MIN_CHOICES = (
    (i, i) for i in range(0, 61, 5)
)

END_MIN_CHOICES = (
    (i, i) for i in range(0, 61, 5)
)
TYPE_CHOICES = (
    ('白班', '白班'),
    ('小夜', '小夜'),
    ('大夜', '大夜'),
    ('休假', '休假'),
    ('公假', '公假'),
    ('oncall', 'oncall')
)


class ShiftEditForm(forms.ModelForm):
    name = forms.CharField(max_length=100, label=_('Name'))
    shift_type = forms.CharField(
        max_length=100,
        label=_('ShiftType'),
        widget=forms.widgets.Select(choices=TYPE_CHOICES))
    start_time = forms.TimeField(label=_('StartTime'),
                                 widget=forms.TimeInput(
                                    attrs={'type': 'time'}))
    end_time = forms.TimeField(label=_('EndTime'),
                               widget=forms.TimeInput(
                                    attrs={'type': 'time'}))
    department = forms.ModelChoiceField(
        queryset=Department.objects.all(),
        label=_('Department'))
    work_hours = forms.FloatField(label=_('WorkHours'))

    class Meta:
        model = Shift
        fields = ['name', 'shift_type', 'start_time',
                  'end_time', 'department', 'work_hours']
