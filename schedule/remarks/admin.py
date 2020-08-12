from .models import UserRemark, RemarkSquare, ResultRemark
from django.contrib import admin


class UserRemarkAdmin(admin.ModelAdmin):
    model = UserRemark
    list_display = ['id', 'user', 'content']


class RemarkSquareAdmin(admin.ModelAdmin):
    model = RemarkSquare
    list_display = ['id', 'content']


class ResultRemarkAdmin(admin.ModelAdmin):
    model = UserRemark
    list_display = ['id', 'result', 'content']


admin.site.register(UserRemark, UserRemarkAdmin)
admin.site.register(RemarkSquare, RemarkSquareAdmin)
admin.site.register(ResultRemark, ResultRemarkAdmin)
