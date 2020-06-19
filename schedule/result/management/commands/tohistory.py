from django.core.management.base import BaseCommand, CommandError
from result.models import Result, AfterResult
import datetime


class Command(BaseCommand):
    help = 'dump data from result to afterresult'

    def handle(self, *args, **options):
        now = datetime.date.today()

        results = Result.objects.filter(date__lte=now)
        for result in results:
            AfterResult.objects.create(
                user=result.user,
                shift=result.shift,
                date=result.date,
                overtime=result.overtime
            )
            result.delete()
        self.stdout.write(self.style.SUCCESS(
            'Successfully dump to history'))
