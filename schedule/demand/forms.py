from django import forms
from django.utils.translation import gettext_lazy as _
from station.models import Station
from .models import DemandOfStation
from shift.models import Shift


LEVEL_CHOICES = (
    (3, _('Leader')),
    (2, _('Senior')),
    (1, _('Junior'))
)

"""
人力需求管理
"""


class DemandCreationForm(forms.ModelForm):
    shift = forms.ModelChoiceField(
        queryset=Shift.objects.all(),
        label=_('Shift'))
    level = forms.IntegerField(
        label=_('level'),
        widget=forms.widgets.Select(choices=LEVEL_CHOICES))
    weekday = forms.IntegerField(label=_('weekdayDemand'))
    holiday = forms.IntegerField(label=_('holidayDemand'))

    class Meta:
        model = DemandOfStation
        fields = ['shift', 'level',
                  'weekday', 'holiday']


class DemandEditForm(forms.Form):
    demand = forms.IntegerField(
        min_value=0,
        required=True,
    )
