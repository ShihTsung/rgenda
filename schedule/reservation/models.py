from django.db import models
from django.utils.translation import gettext_lazy as _
from account.models import CustomUser


TYPE_CHOICES = (
    (0, '事假'),
    (1, '家庭照顧假'),
    (2, '無薪病假'),
    (3, '公假'),
    (4, '產假'),
    (5, '例/休'),
    (6, '生理假'),
    (7, '特休'),
    (8, '補休'),
    (9, '婚假'),
    (10, '計薪病假'),
    (11, '喪假'),
    (12, '安胎休養假'),
    (13, '產檢假'),
    (14, '陪產假'),
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
