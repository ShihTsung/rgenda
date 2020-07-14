from django import forms
from django.utils.translation import gettext_lazy as _


class TimeAdjustmentCreateForm(forms.Form):
    result_date = forms.DateField(
        label=_('result_date'),
        widget=forms.DateInput(attrs={'type': 'date'}),
        required=True,
    )
    name = forms.CharField(
        label=_('name'),
        required=True,
        max_length=100,
    )
    adjustment_type = forms.IntegerField(
        label=_('adjustment_type'),
        required=True,
        widget=forms.widgets.Select(
            choices=(
                (0, _('增加時數')),
                (1, _('減少時數')),
            ),
        ),
    )
    adjustment_item = forms.IntegerField(
        label=_('adjustment_item'),
        required=True,
        widget=forms.widgets.Select(
            choices=(
                (0, _('工作日加班')),
                (1, _('休息日出勤')),
                (2, _('國定假日出勤')),
                (3, _('空班出勤')),
                (4, _('On Call出勤')),
                (5, _('機構減班')),
                # 第一階段無請假系統，所以有'員工自假'選項
                (6, _('員工自假')),
            ),
        ),
    )
    hours = forms.IntegerField(
        label=_('hours'),
        required=True,
        max_value=12,
        min_value=-12,
    )
    remark = forms.CharField(
        label=_('remark'),
        required=False,
        max_length=100,
    )


class TimeAdjustmentSearchForm(forms.Form):
    date_start = forms.DateField(
        label=_('date_start'),
        widget=forms.DateInput(attrs={'type': 'date'}),
        required=True,
    )
    date_end = forms.DateField(
        label=_('date_end'),
        widget=forms.DateInput(attrs={'type': 'date'}),
        required=True,
    )
    adjustment_type = forms.IntegerField(
        label=_('adjustment_type'),
        required=True,
        widget=forms.widgets.Select(
            choices=[
                (0, _('增加時數')),
                (1, _('減少時數')),
            ],
        ),
    )
    adjustment_item = forms.IntegerField(
        label=_('adjustment_item'),
        required=True,
        widget=forms.widgets.Select(
            choices=[
                (0, _('工作日加班')),
                (1, _('休息日出勤')),
                (2, _('國定假日出勤')),
                (3, _('空班出勤')),
                (4, _('On Call出勤')),
                (5, _('機構減班')),
                # 第一階段無請假系統，所以有'員工自假'選項
                (6, _('員工自假')),
            ],
        ),
    )
    name = forms.CharField(
        label=_('name'),
        required=False,
        max_length=100,
    )


class ExchangeApplicationCreateForm(forms.Form):
    exchange_date_start = forms.DateField(
        label=_('exchange_date'),
        widget=forms.DateInput(attrs={'type': 'date'}),
        required=True,
    )
    exchange_date_end = forms.DateField(
        label=_('exchange_date'),
        widget=forms.DateInput(attrs={'type': 'date'}),
        required=True,
    )
    exchange_shift_type = forms.CharField(
        label=_('exchange_shift_type'),
        required=True,
        widget=forms.widgets.Select(
            choices=[
                (None, _('Select')),
                ('D', _('白班')),
                ('E', _('小夜')),
                ('N', _('大夜')),
            ],
        ),
    )
    receive_user = forms.CharField(
        label=_('receive_user'),
        required=True,
        widget=forms.widgets.Select(
            choices=[(None, _('Select'))],
        ),
    )


class ExchangeApplicationRefuseForm(forms.Form):
    exchange_application_id = forms.CharField(
        required=True,
        max_length=100,
    )
    remark = forms.CharField(
        label=_('remark'),
        required=True,
        max_length=100,
    )