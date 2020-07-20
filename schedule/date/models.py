from django.db import models
from django.utils.translation import gettext_lazy as _
# Create your models here.


class Oneday(models.Model):
    date = models.DateField(verbose_name=_('Date'))
    attribute = models.CharField(
        max_length=100,
        verbose_name=_('Attr'),
        choices=(
            ('weekday', 'weekday'),
            ('weekend', 'weekend'),
            ('holiday', 'holiday'),
        ),
    )
    locked = models.BooleanField(verbose_name=_('Locked'), default=False)

    def __str__(self):
        return str(self.date)
