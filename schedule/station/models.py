from django.db import models
from django.utils.translation import gettext_lazy as _
from account.models import Department


"""
工作站管理
"""


class Station(models.Model):
    name = models.CharField(max_length=100, verbose_name=_('Name'))
    department = models.ForeignKey(Department,
                                   on_delete=models.CASCADE,
                                   verbose_name=_('Department'),
                                   null=True)

    def __str__(self):
        return self.name
