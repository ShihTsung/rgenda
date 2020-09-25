# python modules
import datetime
import random
from numpy.random import choice
from mainpage.functions import *
from mainpage.get_data import *
from django.core.management.base import BaseCommand, CommandError
from account.models import Department
from account.views import get_cycle, cycle_analysis
from calendar import monthrange


class Command(BaseCommand):
    help = 'calculate the schedule'

    def handle(self, *args, **options):
        department = Department.objects.first()
        now = datetime.datetime.fromisoformat('2020-07-01').date()
        print(cycle_analysis(department.id, now))
