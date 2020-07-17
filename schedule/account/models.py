from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import gettext_lazy as _
from datetime import date


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
    ('Intern', _('Intern')),
    ('PartTime', _('PartTime')),
)


# Department 模型
class Department(models.Model):
    name = models.CharField(
        max_length=100,
        verbose_name=_('Department'),
    )
    detail = models.CharField(
        max_length=100,
        verbose_name=_('Detail'),
    )
    limit_pre_schedule = models.IntegerField(
        verbose_name=_("LimitPreSchedule"),
        default=3,
    )
    deadline_pre_schedule = models.IntegerField(
        verbose_name=_("DeadlinePreSchedule"),
        default=19,
    )
    reset = models.IntegerField(
        verbose_name=_("Reset"),
        default=0,
    )
    law_rule = models.IntegerField(
        verbose_name=_("LawRule"),
        default=0,
        choices=(
            (0, _('一般工時，7休2')),
            (1, _('雙週變形工時，14休4')),
            (2, _('四週變形工時，28休8')),
            (3, _('八週變形工時，56休16')),
        ),
    )
    schedule_rule = models.IntegerField(
        verbose_name=_("ScheduleRule"),
        default=0,
        choices=(
            (0, _('單週同班種')),
            (1, _('單月同班種')),
            (2, _('三月同班種')),
        ),
    )
    admin_in_schedule = models.BooleanField(
        verbose_name=_("AdminInSchedule"),
        default=False,
    )
    part_time_in_holiday = models.BooleanField(
        verbose_name=_("PartTimeInHoliday"),
        default=False,
    )
    intern_in_holiday = models.BooleanField(
        verbose_name=_("InternInHoliday"),
        default=False,
    )
    intern_d_only = models.BooleanField(
        verbose_name=_("InternDOnly"),
        default=True,
    )
    same_day_notice = models.IntegerField(
        verbose_name=_("SameDayNotice"),
        default=5,
    )
    date_start = models.DateField(
        verbose_name=_('DateStart'),
        null=False,
        default=date(2020, 6, 9),
    )
    month_cycle = models.IntegerField(
        verbose_name=_('MonthCycle'),
        null=True,
        default=1,
    )
    start_date = models.DateField(
        verbose_name=_("StartDate"),
        null=True
    )

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
        default="Male")

    type_of_user = models.CharField(
        max_length=20, choices=TYPE_CHOICES,
        verbose_name=_('Type'),
        default="Normal")

    pregnant = models.BooleanField(
        verbose_name=_('Pregnant'),
        default=False,
    )

    can_be_scheduled = models.BooleanField(
        verbose_name=_('CanBeScheduled'),
        null=True,
        default=True)

    holiday_rest_num = models.IntegerField(
        verbose_name=_('HolidayRestNum'),
        null=True,
        default=10)

    holiday_rest_num_used = models.IntegerField(
        verbose_name=_('HolidayRestNumUsed'),
        null=True,
        default=0)

    special_rest_num = models.IntegerField(
        verbose_name=_('SpecialRestNum'),
        null=True,
        default=10)

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
        if self.role == 'admin' or self.role == 'manager':
            self.is_staff = True
        super(CustomUser, self).save(*args, **kwargs)


# class DepartmentManager(models.Model):
#     department = models.ForeignKey(
#         Department,
#         on_delete=models.CASCADE,
#         verbose_name=_('Department'),
#     )
#     user = models.ForeignKey(
#         CustomUser,
#         on_delete=models.CASCADE,
#         verbose_name=_('User'),
#         null=True
#     )
