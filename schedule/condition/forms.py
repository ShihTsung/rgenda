from django import forms
from django.utils.translation import gettext_lazy as _
from .models import Condition
from account.models import Department


class ConditionCreationForm(forms.ModelForm):
    department = forms.ModelChoiceField(
        queryset=Department.objects.all(),
        label=_('Department')
    )
    limit_pre_schedule = forms.IntegerField(
        verbose_name=_("LimitPreSchedule"),
        default=3,
        null=True
    )
    deadline_pre_schedule = forms.IntegerField(
        verbose_name=_("DeadlinePreSchedule"),
        default=20,
        null=True
    )
    holiday_rest = forms.IntegerField(
        verbose_name=_("HolidayRest"),
        default=40,
        null=True
    )
    recal_workhour_date = forms.DateField(
        label=_('OnboardDate'),
        widget=forms.DateInput(attrs={'type': 'date'})
    )
    law_rule = models.IntegerField(
        verbose_name=_("LawRules"),
        null=True
    )
    schedule_rule = models.IntegerField(
        verbose_name=_("RecalWorkHourDate"),
        null=True
    )


class ConditionEditForm(forms.ModelForm):
    department = forms.ModelChoiceField(
        queryset=Department.objects.all(),
        label=_('Department')
    )
    limit_pre_schedule = forms.IntegerField(
        verbose_name=_("LimitPreSchedule"),
        default=3,
        null=True
    )
    deadline_pre_schedule = forms.IntegerField(
        verbose_name=_("DeadlinePreSchedule"),
        default=20,
        null=True
    )
    holiday_rest = forms.IntegerField(
        verbose_name=_("HolidayRest"),
        default=40,
        null=True
    )
    recal_workhour_date = forms.DateField(
        label=_('OnboardDate'),
        widget=forms.DateInput(attrs={'type': 'date'})
    )
    law_rule = models.IntegerField(
        verbose_name=_("LawRules"),
        null=True
    )
    schedule_rule = models.IntegerField(
        verbose_name=_("RecalWorkHourDate"),
        null=True
    )
