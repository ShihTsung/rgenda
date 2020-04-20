from django.db import models

# Create your models here.


class Oneday(models.Model):
    date = models.DateField(verbose_name='date')
    attribute = models.CharField(max_length=100, verbose_name='attr')
