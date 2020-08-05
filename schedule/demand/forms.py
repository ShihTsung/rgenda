from account.models import CustomUser
from demand.models import DemandOfStation
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
    is_senior = forms.BooleanField(
        label=_('IsSenior'),
    )


class DemandEditForm(forms.Form):
    demand = forms.IntegerField(
        min_value=0,
        required=True,
    )


class DemandUserCreationForm(forms.Form):
    demand = forms.ModelChoiceField(
        queryset=DemandOfStation.objects.all(),
        label=_('DemandOfStation')
    )
    user = forms.ModelChoiceField(
        queryset=CustomUser.objects.all(),
        label=_('User')
    )
