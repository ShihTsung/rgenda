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
        label=_('班別'),
    )
    station = forms.ModelChoiceField(
        queryset=Station.objects.all(),
        label=_('工作站'),
    )
    level = forms.IntegerField(
        label=_('分級'),
        widget=forms.widgets.Select(choices=((1, '正職人員'), (2, '資深正職人員')))
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
