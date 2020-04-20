from django import forms
from django.utils.translation import gettext_lazy as _
from account.models import Department
from .models import Station


LEVEL_CHOICES = (
    (3, _('Leader')),
    (2, _('Senior')),
    (1, _('Junior'))
)

HOUR_CHOICES = (
    (i, i) for i in range(1, 25)
)

MIN_CHOICES = (
    (i, i) for i in range(0, 61, 5)
)

"""
工作站管理
"""


class StationCreationForm(forms.ModelForm):
    name = forms.CharField(max_length=100, label=_('Name'))
    department = forms.ModelChoiceField(
        queryset=Department.objects.all(),
        label=_('Department'), required=False)

    class Meta:
        model = Station
        fields = ['name', 'department']


class StationEditForm(forms.ModelForm):
    name = forms.CharField(max_length=100, label=_('Name'))
    department = forms.ModelChoiceField(
        queryset=Department.objects.all(),
        label=_('Department'), required=False)

    class Meta:
        model = Station
        fields = ['name', 'department']
