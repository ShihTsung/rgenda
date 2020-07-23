from django import forms
from django.utils.translation import gettext_lazy as _
from .models import Shift
from station.models import Station


LEVEL_CHOICES = (
    (3, _('Leader')),
    (2, _('Senior')),
    (1, _('Junior')),
)

TYPE_CHOICES = (
    ('白班', '白班'),
    ('小夜', '小夜'),
    ('大夜', '大夜'),
    ('休假', '休假'),
    ('公假', '公假'),
)
"""
班別管理
"""


class ShiftCreationForm(forms.ModelForm):
    name = forms.CharField(
        max_length=100,
        label=_('Name'),
    )
    shift_type = forms.CharField(
        max_length=100,
        label=_('ShiftType'),
        widget=forms.widgets.Select(choices=TYPE_CHOICES)
    )
    start_time = forms.TimeField(
        label=_('StartTime'),
        widget=forms.widgets.TimeInput,
    )
    end_time = forms.TimeField(
        label=_('EndHour'),
        widget=forms.widgets.TimeInput,
    )
    station = forms.ModelChoiceField(
        queryset=Station.objects.all(),
        label=_('Station'),
    )
    work_hours = forms.FloatField(
        label=_('WorkHours'),
    )

    class Meta:
        model = Shift
        fields = ['name', 'shift_type', 'start_time',
                  'end_time', 'station', 'work_hours']


class ShiftEditForm(forms.ModelForm):
    name = forms.CharField(
        max_length=100,
        label=_('Name'),
    )
    start_time = forms.TimeField(
        label=_('StartTime'),
        widget=forms.widgets.TimeInput,
    )
    end_time = forms.TimeField(
        label=_('EndHour'),
        widget=forms.widgets.TimeInput,
    )
    station = forms.ModelChoiceField(
        queryset=Station.objects.all(),
        label=_('Station'),
    )
    work_hours = forms.FloatField(
        label=_('WorkHours'),
    )

    class Meta:
        model = Shift
        fields = ['name', 'shift_type', 'start_time',
                  'end_time', 'station', 'work_hours']
