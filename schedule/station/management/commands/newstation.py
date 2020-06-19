from django.core.management.base import BaseCommand, CommandError
from station.models import Station
from account.models import Department


class Command(BaseCommand):
    help = 'Add new station'

    def handle(self, *args, **options):
        station = Station.objects.create(
            department=Department.objects.first(),
            name='XXX'
        )
        n = station.name

        self.stdout.write(self.style.SUCCESS(
            'Successfully create station "%s"' % n))

