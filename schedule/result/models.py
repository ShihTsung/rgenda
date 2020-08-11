from django.db import models
from django.utils.translation import gettext_lazy as _
from shift.models import Shift
from account.models import CustomUser
from station.models import Station

# TimeAdjustment 上班時間調整，包含加班、On Call、空班值班、國定假日值班...
# PreResult 演算法排完的班表
# result 已經發布的班表
# AfterResult 執行完，不能更動的班表

# 加減班


class TimeAdjustment(models.Model):
    user = models.ForeignKey(
        CustomUser,
        verbose_name=_('User'),
        on_delete=models.CASCADE,
        null=True
    )
    date = models.DateField(
        verbose_name=_('Date'),
        null=True
    )
    hours = models.IntegerField(
        verbose_name=_('Hours'),
        default=0,
        null=False,
    )
    adjustment_type = models.IntegerField(
        verbose_name=_('adjustment_type'),
        null=False,
        choices=(
                (0, _('增加時數')),
                (1, _('減少時數')),
        ),
    )
    adjustment_item = models.IntegerField(
        verbose_name=_('AdjustmentType'),
        default=0,
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
        null=False,
    )
    remark = models.TextField(
        verbose_name=_('Remark'),
        default=None,
        max_length=100,
        null=True,
    )


class PreResult(models.Model):

    user = models.ForeignKey(
        CustomUser,
        verbose_name=_('User'),
        on_delete=models.CASCADE,
        null=True
    )
    shift = models.ForeignKey(
        Shift,
        verbose_name=_('Shift'),
        on_delete=models.CASCADE,
        null=True
    )
    date = models.DateField(
        verbose_name=_('Date'),
        null=True
    )
    station = models.ForeignKey(
        Station,
        verbose_name=_('Station'),
        on_delete=models.CASCADE,
        null=True
    )


class Result(models.Model):

    user = models.ForeignKey(
        CustomUser,
        verbose_name=_('User'),
        on_delete=models.CASCADE,
        null=True
    )
    shift = models.ForeignKey(
        Shift,
        verbose_name=_('Shift'),
        on_delete=models.CASCADE,
        null=True
    )
    date = models.DateField(
        verbose_name=_('Date'),
        null=True
    )
    station = models.ForeignKey(
        Station,
        verbose_name=_('Station'),
        on_delete=models.CASCADE,
        null=True
    )


class AfterResult(models.Model):

    user = models.ForeignKey(
        CustomUser,
        verbose_name=_('User'),
        on_delete=models.CASCADE,
        null=True
    )
    shift = models.ForeignKey(
        Shift,
        verbose_name=_('Shift'),
        on_delete=models.CASCADE,
        null=True
    )
    date = models.DateField(
        verbose_name=_('Date'),
        null=True
    )
    station = models.ForeignKey(
        Station,
        verbose_name=_('Station'),
        on_delete=models.CASCADE,
        null=True
    )

# 調班


class ExchangeApplication(models.Model):
    user_apply = models.ForeignKey(
        CustomUser,
        verbose_name=_('UserApply'),
        related_name='user_apply',
        on_delete=models.CASCADE,
        null=False,
    )
    user_receive = models.ForeignKey(
        CustomUser,
        verbose_name=_('UserReceive'),
        related_name='user_receive',
        on_delete=models.CASCADE,
        null=False,
    )
    date_start = models.DateField(
        verbose_name=_('DateStart'),
        null=False,
    )
    date_end = models.DateField(
        verbose_name=_('DateEnd'),
        null=False,
    )
    application_status = models.IntegerField(
        verbose_name=_('ApplicationStatus'),
        default=0,
        null=False,
        choices=(
            (0, '待確認'),
            (1, '審核中'),
            (2, '拒絕-待歸檔'),
            (3, '核准-待歸檔'),
            (4, '拒絕-已歸檔'),
            (5, '核准-已歸檔'),
        ),
    )
    remark = models.CharField(
        verbose_name=_('Remark'),
        null=True,
        max_length=100,
    )
