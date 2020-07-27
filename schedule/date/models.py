from django.db import models
from django.utils.translation import gettext_lazy as _
# Create your models here.


class Oneday(models.Model):
    date = models.DateField(verbose_name=_('Date'))
    attribute = models.CharField(
        max_length=100,
        verbose_name=_('Attr'),
        choices=(
            ('workday', 'workday'),
            ('holiday', 'holiday'),
            ('closed_day', 'closed_day'),
        ),
    )
    locked = models.BooleanField(verbose_name=_('Locked'), default=False)
    red_day = models.BooleanField(
        verbose_name=_('RedDay'),
        default=False,
    )

    def __str__(self):
        return str(self.date)
