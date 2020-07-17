from django import forms
from django.utils.translation import gettext_lazy as _
from station.models import Station
from shift.models import Shift


"""
人力需求管理
"""


class DemandCreationForm(forms.Form):
    shift = forms.ModelChoiceField(
        queryset=Shift.objects.all(),
        label=_('Shift'),
    )
    station = forms.ModelChoiceField(
        queryset=Station.objects.all(),
        label=_('Station'),
    )


class DemandEditForm(forms.Form):
    demand = forms.IntegerField(
        min_value=0,
        required=True,
    )
