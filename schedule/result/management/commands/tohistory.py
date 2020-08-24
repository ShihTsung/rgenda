from django.core.management.base import BaseCommand, CommandError
from result.models import Result, AfterResult
import datetime


class Command(BaseCommand):
    help = 'dump data from result to afterresult'

    def handle(self, *args, **options):
        now = datetime.date.today()
        this_month = datetime.date(now.year, now.month, 1)

        results = Result.objects.filter(date__lte=this_month)
        for result in results:
            AfterResult.objects.create(
                user=result.user,
                shift=result.shift,
                station=result.station,
                date=result.date,
            )
            result.delete()
        self.stdout.write(self.style.SUCCESS(
            'Successfully dump to history'))
