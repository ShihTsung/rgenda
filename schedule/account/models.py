from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import gettext_lazy as _
from datetime import date


# 選項的部分之後可以用獨立 model取代
LEVEL_CHOICES = (
    (4, _('N4')),
    (3, _('N3')),
    (2, _('N2')),
    (1, _('N1')),
    (5, _('Nn'))
)
GENDER_CHOICES = (
    ('male', _('Male')),
    ('female', _('Female'))
)
ROLE_CHOICES = (
    ('admin', _('Admin')),
    ('manager', _('Manager')),
    ('user', _('User'))
)

TYPE_CHOICES = (
    (0, _('正職')),
    (1, _('資深正職')),
    (2, _('行政職')),
    (3, _('新進人員')),
    (4, _('兼職人員')),
    (5, _('實習生')),
)


# Department 模型
class Department(models.Model):
    name = models.CharField(
        max_length=100,
        verbose_name=_('簡稱'),
    )
    detail = models.CharField(
        max_length=100,
        verbose_name=_('科別名稱'),
        unique=True
    )
    limit_pre_schedule = models.IntegerField(
        verbose_name=_("預約休假數量"),
        default=3,
    )
    deadline_pre_schedule = models.IntegerField(
        verbose_name=_("預約休假期限"),
        default=19,
    )
    reset = models.IntegerField(
        verbose_name=_("時數重置規則"),
        default=0,
    )
    law_rule = models.IntegerField(
        verbose_name=_("勞基法工時規則"),
        default=0,
        choices=(
            (0, _('一般工時，7休2')),
            (1, _('雙週變形工時，14休4')),
            (2, _('四週變形工時，28休8')),
            (3, _('八週變形工時，56休16')),
        ),
    )
    schedule_rule = models.IntegerField(
        verbose_name=_("班種設定"),
        default=0,
        choices=(
            (0, _('單週同班種')),
            (1, _('單月同班種')),
            (2, _('三月同班種')),
        ),
    )
    admin_in_schedule = models.BooleanField(
        verbose_name=_("管理者是否排班"),
        default=False,
    )
    same_day_notice = models.IntegerField(
        verbose_name=_("預約休假日人數過多提示"),
        default=5,
    )
    date_start = models.DateField(
        verbose_name=_('起算日期'),
        null=False,
        default=date(2020, 6, 9),
    )
    start_of_week = models.IntegerField(
        verbose_name=_('週起始日'),
        null=False,
        default=0,
        choices=(
            (0, _('星期日')),
            (1, _('星期一'))
        )
    )
    can_rest_redday = models.IntegerField(
        verbose_name=_('週末及國定假日可休數量'),
        default=10,
        null=True,
    )
    overtime_rule = models.IntegerField(
        verbose_name=_('加班規則'),
        default=0,
        null=True,
        choices=(
            (0, _('單月46小時')),
            (1, _('三個月138小時'))
        )
    )
    month_cycle = models.IntegerField(
        verbose_name=_('月週期'),
        null=True,
        default=1,
    )

    def __str__(self):
        return self.name


# User 模型
class CustomUser(AbstractUser):

    department = models.ForeignKey(
        Department,
        on_delete=models.CASCADE,
        verbose_name=_('科別'),
        null=True)

    full_name = models.CharField(
        max_length=100,
        verbose_name=_('姓名'),
        null=True)
    job_title = models.CharField(
        max_length=100,
        verbose_name=_('職稱'),
        null=True
    )
    level = models.IntegerField(
        verbose_name=_('職級'),
        choices=LEVEL_CHOICES,
        null=True)

    role = models.CharField(
        max_length=100,
        verbose_name=_('權限'),
        null=True, choices=ROLE_CHOICES)

    gender = models.CharField(
        max_length=20,
        choices=GENDER_CHOICES,
        verbose_name=_('性別'),
        default="Male",
        null=True)

    type_of_user = models.IntegerField(
        choices=TYPE_CHOICES,
        verbose_name=_('排班身份'),
        default=0,
        null=True)

    pregnant = models.BooleanField(
        verbose_name=_('其他'),
        default=False,
        null=True
    )

    can_be_scheduled = models.BooleanField(
        verbose_name=_('排班狀況'),
        null=True,
        default=True)

    holiday_rest_num = models.IntegerField(
        verbose_name=_('假日休假數'),
        null=True,
        default=10)

    holiday_rest_num_used = models.IntegerField(
        verbose_name=_('已休假日休假數'),
        null=True,
        default=0)

    special_rest_num = models.IntegerField(
        verbose_name=_('特休'),
        null=True,
        default=10)

    special_rest_num_used = models.IntegerField(
        verbose_name=_('累計已休特休'),
        null=True,
        default=0)

    eid = models.CharField(
        max_length=100,
        verbose_name=_('工號'),
        null=True)

    hour_required = models.FloatField(
        verbose_name=_('應排班時數'),
        null=True,
        default=0.0)
    hour_realized = models.FloatField(
        verbose_name=_('已排班時數'),
        null=True,
        default=0.0)

    onboard_date = models.DateField(
        verbose_name=_('到職日'),
        null=True)

    compensatory_rest = models.IntegerField(
        verbose_name=_('剩餘補休'),
        default=0,
        null=True
    )

    def __str__(self):
        return self.username

    def save(self, *args, **kwargs):
        if self.role == 'admin' or self.role == 'manager':
            self.is_staff = True
        super(CustomUser, self).save(*args, **kwargs)


# # 證照模型
class Liscense(models.Model):
    user = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        verbose_name=_('Owner'),
        null=True)
    name = models.CharField(
        max_length=25,
        verbose_name=_('Name'),
        default="")
    date = models.DateField(
        verbose_name=_('LiscenseDate')
    )
    due = models.DateField(
        verbose_name=_('DueDate')
    )
    source = models.CharField(
        max_length=25,
        verbose_name=_('Source'),
    )
    liscense_pic = models.ImageField(
        verbose_name=_('LiscensePic'),
        upload_to='liscense',
        null=True,
        blank=True
    )
    liscense_pic_2 = models.ImageField(
        verbose_name=_('LiscensePic2'),
        upload_to='liscense',
        null=True,
        blank=True
    )


class DepartmentManager(models.Model):
    manager_one = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        verbose_name=_('管理者1'),
        related_name='mgr1',
        null=True)
    manager_two = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        verbose_name=_('管理者2'),
        related_name='mgr2',
        null=True)
    department = models.OneToOneField(
        Department,
        on_delete=models.CASCADE,
        verbose_name=_('科別'),
        null=True,
        unique=True)
