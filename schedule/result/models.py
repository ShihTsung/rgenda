from django.db import models
from django.utils.translation import gettext_lazy as _
from shift.models import Shift
from account.models import CustomUser

# PreResult 演算法排完的班表
# result 已經發布的班表
# AfterResult 執行完，不能更動的班表


class PreResult(models.Model):

    user = models.ForeignKey(
        Customuser,
        verbose_name=_('User'),
        on_delete=models.CASCADE,
        null=True
    )
    year = models.IntegerField(
        verbose_name=_('Year'),
        null=True
    )
    shift = models.ForeignKey(
        Shift,
        verbose_name=_('User'),
        on_delete=models.CASCADE,
        null=True
    )
    date = models.DateField(
        verbose_name=_('Date'),
        null=True
    )
    overtime = models.IntegerField(
        verbose_name=_('Overtime'),
        null=True
    )


class Result(models.Model):

    user = models.ForeignKey(
        Customuser,
        verbose_name=_('User'),
        on_delete=models.CASCADE,
        null=True
    )
    year = models.IntegerField(
        verbose_name=_('Year'),
        null=True
    )
    shift = models.ForeignKey(
        Shift,
        verbose_name=_('User'),
        on_delete=models.CASCADE,
        null=True
    )
    date = models.DateField(
        verbose_name=_('Date'),
        null=True
    )
    overtime = models.IntegerField(
        verbose_name=_('Overtime'),
        null=True
    )


class AfterResult(models.Model):

    user = models.ForeignKey(
        Customuser,
        verbose_name=_('User'),
        on_delete=models.CASCADE,
        null=True
    )
    year = models.IntegerField(
        verbose_name=_('Year'),
        null=True
    )
    shift = models.ForeignKey(
        Shift,
        verbose_name=_('User'),
        on_delete=models.CASCADE,
        null=True
    )
    date = models.DateField(
        verbose_name=_('Date'),
        null=True
    )
    overtime = models.IntegerField(
        verbose_name=_('Overtime'),
        null=True
    )
