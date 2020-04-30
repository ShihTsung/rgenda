from django.db import models
from account.models import Department
from django.utils.translation import gettext_lazy as _


"""
department 部門
level 員工職級
limit_pre_schedule 員工自排次數限制
deadline_pre_schedule 自排班假期限
holiday_rest  可休假日數限制
recal_workhour_date 累積時數歸零的日期
law_rule 勞基法規則, 1: 7休2, 2: 14休4, 3: 28休8, 4: 56休16
schedule_rule 醫院規則 1: 花花, 2: 單月同班種, 3: 三月同班種
admin_in_schedule 管理者排班
part_time_in_holiday 兼職排假日班
intern_in_holiday 實習排假日班
intern_d_only 實習只排白班
"""
# 排班條件


class Condition(models.Model):

    department = models.ForeignKey(
        Department,
        verbose_name=_("Department"),
        on_delete=models.CASCADE,
        null=True,
    )
    limit_pre_schedule = models.IntegerField(
        verbose_name=_("LimitPreSchedule"),
        default=3,
        null=True,
    )
    deadline_pre_schedule = models.IntegerField(
        verbose_name=_("DeadlinePreSchedule"),
        default=19,
        null=True,
    )
    holiday_rest = models.IntegerField(
        verbose_name=_("HolidayRest"),
        default=40,
        null=True,
    )
    recal_workhour_date = models.CharField(
        verbose_name=_("RecalWorkHourDate"),
        default='1/1',
        max_length=5,
    )
    law_rule = models.IntegerField(
        verbose_name=_("LawRule"),
        default=1,
        null=True,
    )
    schedule_rule = models.IntegerField(
        verbose_name=_("ScheduleRule"),
        default=1,
        null=True,
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

    def __str__(self):
        return self.department.name + ' rule'
