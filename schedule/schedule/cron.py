import sys
import os
import django
from django.core.mail import send_mail
from django.shortcuts import render, redirect
import random
import datetime
from django.utils import timezone
# append root folder of django project
# could be solved with a relative path like os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..') which corresponds to the parent folder of the actual file.
back = os.path.dirname
BASE_DIR = back(back(os.path.abspath(__file__)))
sys.path.append(BASE_DIR)

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "schedule.settings")
django.setup()


def mail(request):
    send_mail('郵件測試', 'Here is the message.\r郵件內容',
              'circlepen1252@gmail.com',
              ['larry52699@gmail.com'], fail_silently=False)

    return redirect('/')


def cron_job():
    print('crontab job executing')
    with open('notfound.txt', 'a') as f:
        f.write('Hello, world!')
    return True
