from django.db import models
from account.models import Department
from django.utils.translation import gettext_lazy as _


"""
department 部門
limit_pre_schedule 員工自排次數限制
deadline_pre_schedule 自排班假期限
holiday_rest  可休假日數限制
recal_workhour_date 累積時數歸零的日期
law_rule 勞基法規則
schedule_rule 醫院規則

"""
# 排班條件


class Condition(models.Model):

    department = models.ForeignKey(
        Department,
        verbose_name=_("Department")
        on_delete=models.CASCADE,
        null=True
    )
    limit_pre_schedule = models.IntegerField(
        verbose_name=_("LimitPreSchedule"),
        default=3,
        null=True
    )
    deadline_pre_schedule = models.IntegerField(
        verbose_name=_("DeadlinePreSchedule"),
        default=3,
        null=True
    )
    holiday_rest = models.IntegerField(
        verbose_name=_("HolidayRest"),
        default=40,
        null=True
    )
    recal_workhour_date = models.DateField(
        verbose_name=_("RecalWorkHourDate"),
        null=True
    )
    law_rule = models.IntegerField(
        verbose_name=_("LawRules"),
        null=True
    )
    schedule_rule = models.IntegerField(
        verbose_name=_("RecalWorkHourDate"),
        null=True
    )

    def __str__(self):
        return self.department.name + ' rule'
