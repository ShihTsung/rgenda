from django import forms
from django.utils.translation import gettext_lazy as _
from .models import Shift
from station.models import Station


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
    ('公假', '公假')
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
    start_hour = forms.IntegerField(
        label=_('StartHour'),
        widget=forms.widgets.Select(choices=START_HOUR_CHOICES))
    start_min = forms.IntegerField(
        label=_('StartMin'),
        widget=forms.widgets.Select(choices=START_MIN_CHOICES))
    end_hour = forms.IntegerField(
        label=_('EndHour'),
        widget=forms.widgets.Select(choices=END_HOUR_CHOICES))
    end_min = forms.IntegerField(
        label=_('EndMin'),
        widget=forms.widgets.Select(choices=END_MIN_CHOICES))
    station = forms.ModelChoiceField(
        queryset=Station.objects.all(),
        label=_('Station'))
    work_hours = forms.FloatField(label=_('WorkHours'))

    class Meta:
        model = Shift
        fields = ['name', 'shift_type', 'start_hour', 'start_min',
                  'end_hour', 'end_min', 'station', 'work_hours']


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
    ('公假', '公假')
)


class ShiftEditForm(forms.ModelForm):
    name = forms.CharField(max_length=100, label=_('Name'))
    shift_type = forms.CharField(
        max_length=100,
        label=_('ShiftType'),
        widget=forms.widgets.Select(choices=TYPE_CHOICES))
    start_hour = forms.IntegerField(
        label=_('StartHour'),
        widget=forms.widgets.Select(choices=START_HOUR_CHOICES))
    start_min = forms.IntegerField(
        label=_('StartMin'),
        widget=forms.widgets.Select(choices=START_MIN_CHOICES))
    end_hour = forms.IntegerField(
        label=_('EndHour'),
        widget=forms.widgets.Select(choices=END_HOUR_CHOICES))
    end_min = forms.IntegerField(
        label=_('EndMin'),
        widget=forms.widgets.Select(choices=END_MIN_CHOICES))
    station = forms.ModelChoiceField(
        queryset=Station.objects.all(),
        label=_('Station'))
    work_hours = forms.FloatField(label=_('WorkHours'))

    class Meta:
        model = Shift
        fields = ['name', 'shift_type', 'start_hour', 'start_min',
                  'end_hour', 'end_min', 'station', 'work_hours']
