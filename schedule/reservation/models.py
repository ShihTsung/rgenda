from django.db import models
from django.utils.translation import gettext_lazy as _
from shift.models import Shift
from account.models import CustomUser


# 預排假
class Reservation(models.Model):

    user = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        verbose_name=_('User'),
        null=None
    )
    year = models.IntegerField(verbose_name=_('Year'))
    date = models.DateField(verbose_name=_('Date'))

    def __str__(self):
        return self.user.username + self.date


# 保證假，班
class PromiseShift(models.Model):
    user = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        verbose_name=_('User'),
        null=None
    )
    year = models.IntegerField(verbose_name=_('Year'))
    date = models.DateField(verbose_name=_('Date'))
    shift = models.ForeignKey(
        Shift,
        on_delete=models.CASCADE,
        verbose_name=_('Shift'),
        null=None
    )

    def __str__(self):
        return self.user.username + self.date
