from django.db import models
from django.utils.translation import gettext_lazy as _
from station.models import Station

"""
班別管理
"""

TYPE_CHOICES = (
    ('白班', '白班'),
    ('小夜', '小夜'),
    ('大夜', '大夜'),
    ('休假', '休假'),
    ('公假', '公假'),
    ('oncall', 'oncall')
)


class Shift(models.Model):
    name = models.CharField(max_length=100, verbose_name=_('Name'), null=True)
    shift_type = models.CharField(
        max_length=100,
        verbose_name=_('ShiftType'),
        null=True,
        choices=TYPE_CHOICES,)
    start_hour = models.IntegerField(verbose_name=_('StartHour'), null=True)
    start_min = models.IntegerField(verbose_name=_('StartHour'), null=True)
    end_hour = models.IntegerField(verbose_name=_('StartHour'), null=True)
    end_min = models.IntegerField(verbose_name=_('StartHour'), null=True)
    department = models.ForeignKey(Department, verbose_name=_('Department'),
                                   on_delete=models.CASCADE, null=True)
    work_hours = models.FloatField(verbose_name=_('WorkHours'), null=True)

    def __str__(self):
        return self.name + '-' + self.department.name
