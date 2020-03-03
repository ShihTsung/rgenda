from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import gettext_lazy as _


DEPARTMENT_CHOICES = (
    ('outpatient', _('Outpatient')),
    ('op', _('OperatingRoom')),
    ('ns', _('NursingStation'))
)
LEVEL_CHOICES = (
    (3, _('Leader')),
    (2, _('Senior')),
    (1, _('Junior'))
)
GENDER_CHOICES = (
    ('M', _('Male')),
    ('F', _('Female'))
)

"""
class Department(models.Model):
    name = models.CharField(max_length=100, verbose_name=_('Department'))
    detail = models.CharField(max_length=100, verbose_name=_('Detail'))
"""


class CustomUser(AbstractUser):
    department = models.CharField(max_length=100,
                                  choices=DEPARTMENT_CHOICES,
                                  verbose_name=_('Department'),
                                  null=True)
    level = models.IntegerField(verbose_name=_('Level'),
                                choices=LEVEL_CHOICES, null=True)
    eng_name = models.CharField(max_length=100, verbose_name=_('EnglishName'),
                                null=True)
    gender = models.CharField(max_length=20, choices=GENDER_CHOICES,
                              verbose_name=_('Gender'),
                              default="M")
    eid = models.CharField(max_length=100, verbose_name=_('EmployeeId'),
                           null=True)
    gid = models.CharField(max_length=100, verbose_name=_('GovernmentId'),
                           null=True)
    onboard_date = models.CharField(
        max_length=100, verbose_name=_('OnboardDate'),
        null=True)
    # add additional fields in here

    def __str__(self):
        return self.username
