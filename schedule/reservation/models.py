from django.db import models
from django.utils.translation import gettext_lazy as _
from shift.models import Shift
from account.models import CustomUser


TYPE_CHOICES = (
    (0, _('白班')),
    (1, _('小夜')),
    (2, _('大夜')),
    (3, _('oncall')),
    (4, _('有薪假')),
    (5, _('無薪假'))
)

# 預排假


class Reservation(models.Model):

    user = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        verbose_name=_('User'),
        null=None
    )
    date = models.DateField(verbose_name=_('Date'))

    def __str__(self):
        return self.user.username + self.date


# 保證假，班
class PromiseShift(models.Model):
    user = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        verbose_name=_('使用者'),
        null=True,
    )
    date = models.DateField(verbose_name=_('日期'))
    shift_type = models.IntegerField(
        verbose_name=_('類型'),
        null=True,
        choices=TYPE_CHOICES
    )

    def __str__(self):
        return self.user.username + self.date
