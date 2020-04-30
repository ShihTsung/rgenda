from django import forms
from django.utils.translation import gettext_lazy as _


class ConditionEditForm(forms.ModelForm):
    limit_pre_schedule = forms.IntegerField(
        label=_("LimitPreSchedule"),
    )
    deadline_pre_schedule = forms.IntegerField(
        label=_("DeadlinePreSchedule"),
    )
    holiday_rest = forms.IntegerField(
        label=_("HolidayRest"),
    )
    recal_workhour_date = forms.DateField(
        label=_('OnboardDate'),
        widget=forms.DateInput(attrs={'type': 'date'})
    )
    law_rule = forms.IntegerField(
        label=_("LawRules"),
    )
    schedule_rule = forms.IntegerField(
        label=_("RecalWorkHourDate"),
    )
