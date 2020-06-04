#!/usr/local/bin/ python
from account.models import Department
from station.models import Station
from datetime import datetime
import os
import sys
import django
from django.utils import timezone
from django.shortcuts import render, redirect

back = os.path.dirname
# get the path of upper folder
BASE_DIR = back(back(os.path.abspath(__file__)))
print(BASE_DIR)
sys.path.append(BASE_DIR)
print(sys.path)
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "schedule.settings")

django.setup()
print('Script has been started at {}'.format(datetime.now()))
station = Station.objects.create(
    department=Department.objects.first(),
    name='XXX'
)
print('Done')
