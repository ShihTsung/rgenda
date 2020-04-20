import os
import pathlib
import random
import sys
from datetime import timedelta
import django
from django.utils import timezone
back = os.path.dirname
BASE_DIR = back(back(os.path.abspath(__file__)))
sys.path.append(BASE_DIR)


if __name__ == '__main__':
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "schedule.settings")
    django.setup()
    from account.models import CustomUser as User
    if User.objects.all():
        print('clean database')
        User.objects.all().delete()
# superuser
        print('create a super user')
        user = User.objects.create_superuser(
        'circlepen', 'lyle.lai@redfalcon-hpc.com', 'redfalcon')
    print('finish')
