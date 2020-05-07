from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import gettext_lazy as _

# 選項的部分之後可以用獨立 model取代
LEVEL_CHOICES = (
    (4, _('N4')),
    (3, _('N3')),
    (2, _('N2')),
    (1, _('N, N1'))
)
GENDER_CHOICES = (
    ('M', _('Male')),
    ('F', _('Female'))
)
ROLE_CHOICES = (
    ('admin', _('admin')),
    ('manager', _('manager')),
    ('user', _('user'))
)

TYPE_CHOICES = (
    ('Normal', _('Normal')),
    ('Pragnant', _('Pragnant')),
    ('Intern', _('Intern')),
    ('PartTime', _('PartTime'))
)


# Department 模型
class Department(models.Model):
    name = models.CharField(max_length=100, verbose_name=_('Department'))
    detail = models.CharField(max_length=100, verbose_name=_('Detail'))

    def __str__(self):
        return self.name


# User 模型
class CustomUser(AbstractUser):
    department = models.ForeignKey(
        Department,
        on_delete=models.CASCADE,
        verbose_name=_('Department'),
        null=True)

    full_name = models.CharField(
        max_length=100,
        verbose_name=_('FullName'),
        null=True)

    level = models.IntegerField(
        verbose_name=_('Level'),
        choices=LEVEL_CHOICES,
        null=True)

    role = models.CharField(
        max_length=100,
        verbose_name=_('Role'),
        null=True, choices=ROLE_CHOICES)

    gender = models.CharField(
        max_length=20,
        choices=GENDER_CHOICES,
        verbose_name=_('Gender'),
        default="None")

    type_of_user = models.CharField(
        max_length=20, choices=TYPE_CHOICES,
        verbose_name=_('Type'),
        default="Normal")
    can_be_scheduled = models.BooleanField(
        verbose_name=_('CanBeScheduled'),
        null=True,
        default=True)

    holiday_rest_num = models.IntegerField(
        verbose_name=_('HolidayRestNum'),
        null=True)

    holiday_rest_num_used = models.IntegerField(
        verbose_name=_('HolidayRestNumUsed'),
        null=True,
        default=0)

    special_rest_num = models.IntegerField(
        verbose_name=_('SpecialRestNum'),
        null=True)

    special_rest_num_used = models.IntegerField(
        verbose_name=_('SpecialRestNumUsed'),
        null=True,
        default=0)

    eid = models.CharField(
        max_length=100,
        verbose_name=_('EmployeeId'),
        null=True)

    hour_required = models.FloatField(
        verbose_name=_('HourRequired'),
        null=True,
        default=0.0)
    hour_realized = models.FloatField(
        verbose_name=_('HourRealized'),
        null=True,
        default=0.0)

    onboard_date = models.DateField(
        verbose_name=_('OnboardDate'),
        null=True)

    def __str__(self):
        return self.username

    def save(self, *args, **kwargs):
        if self.role == 'andmin' or self.role == 'manager':
            self.is_staff = True
        super(CustomUser, self).save(*args, **kwargs)
