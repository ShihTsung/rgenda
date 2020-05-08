from django import forms
from django.utils.translation import gettext_lazy as _
from .models import Condition


class ConditionEditForm(forms.ModelForm):
    limit_pre_schedule = forms.IntegerField(
        label=_("LimitPreSchedule"),
        min_value=0,
    )
    deadline_pre_schedule = forms.ChoiceField(
        label=_("DeadlinePreSchedule"),
        required=True,
        widget=forms.Select,
        choices=[(i, i) for i in range(1, 29)],
    )
    holiday_rest = forms.IntegerField(
        label=_("HolidayRest"),
        min_value=0,
    )
    reset = forms.ChoiceField(
        label=_('Reset'),
        required=True,
        widget=forms.Select,
        choices=[(0, _('PerYear(at 1/1)')), (1, _('PerMonth(at 1)'))],
    )
    law_rule = forms.ChoiceField(
        label=_("LawRules"),
        required=True,
        widget=forms.Select,
        choices=[
            (1, '一般'),
            (2, '變形工時'),
            (3, '雙週變形工時'),
            (4, '四周變形工時'),
        ],
    )
    schedule_rule = forms.ChoiceField(
        label=_("RecalWorkHourDate"),
        required=True,
        widget=forms.Select,
        choices=[
            (1, '花班'),
            (2, '單月同班種'),
            (3, '三月同班種'),
        ],
    )
    admin_in_schedule = forms.BooleanField(
        label=_("AdminInSchedule"),
        required=False,
    )
    part_time_in_holiday = forms.BooleanField(
        label=_("PartTimeInHoliday"),
        required=False,
    )
    intern_in_holiday = forms.BooleanField(
        label=_("InternInHoliday"),
        required=False,
    )
    intern_d_only = forms.BooleanField(
        label=_("InternDOnly"),
        required=False,
    )
    same_day_notice = forms.IntegerField(
        label=_("SameDayNotice"),
        required=True,
        min_value=0,
    )

    class Meta:
        model = Condition
        help_texts = {}
        fields = ['limit_pre_schedule', 'deadline_pre_schedule', 'holiday_rest', 'reset', 'law_rule',
                  'schedule_rule', 'admin_in_schedule', 'part_time_in_holiday', 'intern_in_holiday', 'intern_d_only',
                  'same_day_notice']