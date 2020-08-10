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
    ('白班', '白班'),
    ('小夜', '小夜'),
    ('大夜', '大夜'),
    ('公假', '公假'),
    ('oncall', 'oncall'),
    ('有薪假', '有薪假'),
    ('無薪假', '無薪假'),
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
