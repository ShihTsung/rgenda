from django.db import models
from django.utils.translation import gettext_lazy as _
from station.models import Station
from shift.models import Shift
from account.models import CustomUser

# Create your models here.
"""
人力需求管理
"""


class DemandOfStation(models.Model):
    class Meta:
        unique_together = (('station', 'shift', 'level'),)
    shift = models.ForeignKey(Shift, verbose_name=_(
        'Shift'), on_delete=models.CASCADE, null=True)
    station = models.ForeignKey(Station, verbose_name=_('Station'),
                                on_delete=models.CASCADE, null=True)
    level = models.IntegerField(
        verbose_name=_('分級'), default=1
    )
    config1 = models.IntegerField(
        verbose_name=_('配置1'), default=0)
    config2 = models.IntegerField(
        verbose_name=_('配置2'), default=0)

    def __str__(self):
        return self.station.name + '-' + self.shift.name + '-' + str(self.level)


class DemandUserTable(models.Model):
    demand = models.ForeignKey(
        DemandOfStation, verbose_name=_('DemandOfStation'),
        on_delete=models.CASCADE, null=True
    )
    user = models.ForeignKey(
        CustomUser, verbose_name=_('User'),
        on_delete=models.CASCADE, null=True
    )
