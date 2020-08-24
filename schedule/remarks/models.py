from django.db import models
from django.utils.translation import gettext_lazy as _
from account.models import CustomUser
from result.models import Result, PreResult


class UserRemark(models.Model):
    class Meta:
        unique_together = (('user', 'month'),)

    user = models.ForeignKey(
        CustomUser,
        verbose_name=_('使用者'),
        on_delete=models.CASCADE,
        null=True
    )
    month = models.IntegerField(
        verbose_name=_('月份'),
        null=True
    )
    content = models.TextField(
        max_length=100,
        verbose_name=_('備註'),
        blank=True
    )


class RemarkSquare(models.Model):
    content = models.CharField(
        max_length=100,
        verbose_name=_('內容'),
        null=True,
        blank=True
    )

    def __str__(self):
        return self.content


class ResultRemark(models.Model):
    result = models.OneToOneField(
        Result,
        verbose_name=_('班表'),
        on_delete=models.CASCADE,
        null=True
    )
    content = models.ForeignKey(
        RemarkSquare,
        on_delete=models.CASCADE,
        verbose_name=_('備註'),
        null=True
    )


class PreResultRemark(models.Model):
    result = models.OneToOneField(
        PreResult,
        verbose_name=_('班表'),
        on_delete=models.CASCADE,
        null=True
    )
    content = models.ForeignKey(
        RemarkSquare,
        on_delete=models.CASCADE,
        verbose_name=_('備註'),
        null=True
    )
