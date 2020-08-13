from django.db import models
from django.utils.translation import gettext_lazy as _
from account.models import Department

"""
班別管理
"""

TYPE_CHOICES = (
    (0, '白班'),
    (1, '小夜'),
    (2, '大夜'),
    (3, '公假'),
    (4, 'oncall'),
    (5, '有薪假'),
    (6, '無薪假'),
)


class Shift(models.Model):
    name = models.CharField(max_length=100, verbose_name=_('Name'), null=True)
    shift_type = models.IntegerField(
        verbose_name=_('ShiftType'),
        null=True,
        choices=TYPE_CHOICES,)
    start_time = models.TimeField(verbose_name=_('StartTime'), null=True)
    end_time = models.TimeField(verbose_name=_('EndTime'), null=True)
    department = models.ForeignKey(Department, verbose_name=_('Department'),
                                   on_delete=models.CASCADE, null=True)
    work_hours = models.FloatField(verbose_name=_('WorkHours'), null=True)

    def __str__(self):
        return self.name
