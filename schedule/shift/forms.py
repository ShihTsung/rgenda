from django import forms
from django.utils.translation import gettext_lazy as _
from .models import Shift
from account.models import Department


LEVEL_CHOICES = (
    (3, _('Leader')),
    (2, _('Senior')),
    (1, _('Junior'))
)

TYPE_CHOICES = (
    (0, '白班'),
    (1, '小夜'),
    (2, '大夜'),
    (3, '公假'),
    (4, 'oncall'),
    (5, '有薪假'),
    (6, '無薪假'),
)

"""
班別管理
"""


class ShiftCreationForm(forms.ModelForm):
    name = forms.CharField(max_length=100, label=_('Name'))
    shift_type = forms.IntegerField(
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
