from django.db import models
from django_mysql.models import JSONField, Model
from django.utils.translation import gettext_lazy as _
# Create your models here.


class H_Calendar(Model):
    date = models.DateField(verbose_name=_('Date'))
    attribute = JSONField(verbose_name=_('Attribute'))
    locked = models.BooleanField(verbose_name=_('Locked'), default=False)
    red_day = models.BooleanField(
        verbose_name=_('RedDay'),
        default=False,
    )

    def __str__(self):
        return str(self.date)
