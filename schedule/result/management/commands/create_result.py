from django.core.management.base import BaseCommand
from account.views import

class Command(BaseCommand):

    help = 'create result testing'

    def handle(self, *args, **options):
        """
        單月同班種 / 雙週變形
        班別 無 指定人
        :param args:
        :param options:
        :return:
        """
        