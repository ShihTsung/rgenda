from rest_framework import serializers
from rest_framework.decorators import action
from account.models import CustomUser


class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ('id', 'url', 'last_name', 'first_name', 'username',
                  'department', 'level', 'eng_name', 'gender', 'eid',
                  'gid', 'onboard_date')
        read_only_fields = ("id",)
