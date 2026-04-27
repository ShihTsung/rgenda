from django.db import models
from django.utils.translation import gettext_lazy as _


class H_Calendar(models.Model):
    date = models.DateField(verbose_name=_('Date'))
    attribute = models.JSONField(verbose_name=_('Attribute'), default=dict)
    locked = models.BooleanField(verbose_name=_('Locked'), default=False)
    red_day = models.BooleanField(
        verbose_name=_('RedDay'),
        default=False,
    )

    def __str__(self):
        return str(self.date)
