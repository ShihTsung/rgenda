from django import forms
from django.utils.translation import gettext_lazy as _
from station.models import Station
from .models import DemandOfStation
from shift.models import Shift


LEVEL_CHOICES = (
    (4, _('N4')),
    (3, _('N3')),
    (2, _('N2')),
    (1, _('N1,N'))
)

"""
人力需求管理
"""


class DemandCreationForm(forms.ModelForm):
    shift = forms.ModelChoiceField(
        queryset=Shift.objects.all(),
        label=_('Shift'))
    level = forms.IntegerField(
        label=_('Level'),
        widget=forms.widgets.Select(choices=LEVEL_CHOICES))
    station = forms.ModelChoiceField(
        queryset=Station.objects.all(),
        label=_('Station'))
    weekday = forms.IntegerField(label=_('WeekdayDemand'))
    holiday = forms.IntegerField(label=_('HolidayDemand'))

    class Meta:
        model = DemandOfStation
        fields = ['shift', 'level', 'station',
                  'weekday', 'holiday']


class DemandEditForm(forms.Form):
    demand = forms.IntegerField(
        min_value=0,
        required=True,
    )
