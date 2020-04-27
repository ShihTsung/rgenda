from django.db import models
from django.utils.translation import gettext_lazy as _
from shift.models import Shift
from account.models import CustomUser


class Reservation(models.Model):

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
        null=None)


def __str__(self):
    return self.user.username + self.date
