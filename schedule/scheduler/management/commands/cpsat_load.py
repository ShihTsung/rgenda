"""
從 DB 載入排班問題、印出摘要。

用途：在實作 CP-SAT model 之前，先確認 loader 抓到的資料合理。

用法：
    python manage.py cpsat_load --department 4 --year 2020 --month 9
    python manage.py cpsat_load --department 4 --year 2020 --month 9 --format json
"""
import json
from dataclasses import asdict

from django.core.management.base import BaseCommand, CommandError

from scheduler.loaders import load_problem


class Command(BaseCommand):
    help = '載入指定部門/月份的排班問題快照、印出摘要（不求解）'

    def add_arguments(self, parser):
        parser.add_argument('--department', type=int, required=True, help='部門 id')
        parser.add_argument('--year', type=int, required=True)
        parser.add_argument('--month', type=int, required=True)
        parser.add_argument(
            '--format',
            choices=['summary', 'json'],
            default='summary',
            help='summary=人類可讀摘要; json=完整 dump',
        )

    def handle(self, *args, **options):
        try:
            problem = load_problem(
                options['department'], options['year'], options['month']
            )
        except Exception as e:
            raise CommandError(f'load_problem 失敗: {e}')

        if options['format'] == 'summary':
            self.stdout.write(problem.summary())
            self.stdout.write('')
            self.stdout.write('=== 樣本（前幾筆）===')
            if problem.days:
                self.stdout.write(f'  days[0]:       {problem.days[0]}')
                holiday = next((d for d in problem.days if d.is_holiday), None)
                if holiday:
                    self.stdout.write(f'  first holiday: {holiday}')
            if problem.staffs:
                self.stdout.write(f'  staffs[0]:     {problem.staffs[0]}')
            if problem.demands:
                self.stdout.write(f'  demands[0]:    {problem.demands[0]}')
            if problem.commitments:
                self.stdout.write(f'  commits[0]:    {problem.commitments[0]}')
            else:
                self.stdout.write('  commits:       (none)')
        else:
            payload = {
                'department_id': problem.department_id,
                'department_name': problem.department_name,
                'year': problem.year,
                'month': problem.month,
                'law_rule': problem.law_rule,
                'schedule_rule': problem.schedule_rule,
                'counts': {
                    'days': len(problem.days),
                    'staffs': len(problem.staffs),
                    'demands': len(problem.demands),
                    'commitments': len(problem.commitments),
                },
                'sample': {
                    'day': asdict(problem.days[0]) if problem.days else None,
                    'staff': asdict(problem.staffs[0]) if problem.staffs else None,
                    'demand': asdict(problem.demands[0]) if problem.demands else None,
                    'commitment': (
                        asdict(problem.commitments[0])
                        if problem.commitments else None
                    ),
                },
            }
            self.stdout.write(json.dumps(payload, default=str, ensure_ascii=False, indent=2))
