from django.db import models
from django.utils.translation import gettext_lazy as _
from station.models import Station
from shift.models import Shift

# Create your models here.
"""
人力需求管理
"""


class DemandOfStation(models.Model):
    shift = models.ForeignKey(Shift, verbose_name=_(
        'Shift'), on_delete=models.CASCADE, null=True)
    level = models.IntegerField(verbose_name=_('level'), default=1, null=True)
    weekday = models.IntegerField(verbose_name=_('weekdayDemand'), default=0)
    holiday = models.IntegerField(verbose_name=_('holidayDemand'), default=0)

    def __str__(self):
        return self.shift.name + '-' + self.shift.station.name
