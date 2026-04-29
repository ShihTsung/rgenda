"""
從 DB 載入排班問題、用 CP-SAT 求解、印出指派摘要。

step 2 為止只在 console 顯示結果，不寫回 PreResult。

用法：
    python manage.py cpsat_solve --department 4 --year 2020 --month 10
    python manage.py cpsat_solve --department 4 --year 2020 --month 10 --time-limit 60
    python manage.py cpsat_solve --department 4 --year 2020 --month 10 --user 42
"""
from collections import Counter, defaultdict

from django.core.management.base import BaseCommand, CommandError

from scheduler.loaders import load_problem
from scheduler.solver import solve


SHIFT_TYPE_LABELS = {
    0: '白班', 1: '小夜', 2: '大夜', 3: '公假', 4: 'oncall',
    5: '有薪假', 6: '無薪假', 7: '行政',
}


class Command(BaseCommand):
    help = '載入指定部門/月份的排班問題、用 CP-SAT 求解、印出統計'

    def add_arguments(self, parser):
        parser.add_argument('--department', type=int, required=True, help='部門 id')
        parser.add_argument('--year', type=int, required=True)
        parser.add_argument('--month', type=int, required=True)
        parser.add_argument(
            '--time-limit', type=float, default=30.0,
            help='求解時間上限（秒），預設 30',
        )
        parser.add_argument(
            '--user', type=int, default=None,
            help='印出某 user_id 全月班表（debug 用）',
        )
        parser.add_argument(
            '--log-search', action='store_true',
            help='開啟 ortools 求解過程 log',
        )

    def handle(self, *args, **options):
        try:
            problem = load_problem(
                options['department'], options['year'], options['month']
            )
        except Exception as e:
            raise CommandError(f'load_problem 失敗: {e}')

        self.stdout.write(problem.summary())
        self.stdout.write('')
        self.stdout.write(self.style.NOTICE(
            f'求解中（時限 {options["time_limit"]}s）...'
        ))

        solution = solve(
            problem,
            time_limit_seconds=options['time_limit'],
            log_search=options['log_search'],
        )

        self.stdout.write('')
        self._print_solution_stats(solution)

        if not solution.is_feasible:
            self.stdout.write(self.style.ERROR(
                '\n求解失敗 — 可能 commitment 跟 demand 衝突，或職級結構湊不出 demand。'
            ))
            self._print_demand_diagnosis(problem)
            return

        self._print_per_shift_type_summary(problem, solution)
        self._print_per_user_workload(problem, solution)

        if options['user']:
            self._print_one_user_schedule(problem, solution, options['user'])

    # ------------------------------------------------------------ helpers

    def _print_solution_stats(self, solution) -> None:
        self.stdout.write('=== 求解結果 ===')
        self.stdout.write(f'  狀態:       {solution.status}')
        self.stdout.write(f'  耗時:       {solution.walltime_ms} ms')
        self.stdout.write(f'  指派筆數:    {len(solution.assignments)}')

    def _print_per_shift_type_summary(self, problem, solution) -> None:
        shift_by_id = {s.id: s for s in problem.shifts}
        type_counter: Counter = Counter()
        for a in solution.assignments:
            t = shift_by_id[a.shift_id].shift_type
            type_counter[t] += 1

        self.stdout.write('')
        self.stdout.write('=== 指派 by shift_type ===')
        for t in sorted(type_counter):
            label = SHIFT_TYPE_LABELS.get(t, f'?{t}')
            self.stdout.write(f'  {t} {label:6s} : {type_counter[t]:5d}')

    def _print_per_user_workload(self, problem, solution) -> None:
        shift_by_id = {s.id: s for s in problem.shifts}
        per_user_work = Counter()
        per_user_total = Counter()
        for a in solution.assignments:
            shift = shift_by_id[a.shift_id]
            per_user_total[a.user_id] += 1
            if shift.is_working:
                per_user_work[a.user_id] += 1

        self.stdout.write('')
        self.stdout.write('=== 工作天分布 ===')
        worked = [per_user_work[u.id] for u in problem.staffs]
        if worked:
            self.stdout.write(
                f'  min/max/mean 工作天: {min(worked)} / {max(worked)} / '
                f'{sum(worked) / len(worked):.1f}'
            )

    def _print_one_user_schedule(self, problem, solution, user_id) -> None:
        user = next((u for u in problem.staffs if u.id == user_id), None)
        if not user:
            self.stdout.write(self.style.WARNING(
                f'\n找不到 user_id={user_id}'
            ))
            return
        shift_by_id = {s.id: s for s in problem.shifts}
        user_assigns = sorted(
            (a for a in solution.assignments if a.user_id == user_id),
            key=lambda a: a.the_date,
        )
        self.stdout.write('')
        self.stdout.write(
            f'=== {user.full_name} ({user.username}, level {user.level}) 全月班表 ==='
        )
        for a in user_assigns:
            shift = shift_by_id[a.shift_id]
            label = SHIFT_TYPE_LABELS.get(shift.shift_type, '?')
            self.stdout.write(
                f'  {a.the_date}  [{label}] {shift.name}'
            )

    def _print_demand_diagnosis(self, problem) -> None:
        """無解時印出 demand vs 員工層級分布，幫助診斷。"""
        levels: Counter = Counter(u.level for u in problem.staffs)
        demand_per_level: defaultdict[int, int] = defaultdict(int)
        for d in problem.demands:
            demand_per_level[d.level] += d.count

        self.stdout.write('')
        self.stdout.write('=== 診斷：人力 vs 需求 ===')
        self.stdout.write(f'  員工層級分布: {dict(levels)}')
        self.stdout.write(
            f'  demand 加總（{len(problem.days)} 天）by level: {dict(demand_per_level)}'
        )
        for lvl, total in demand_per_level.items():
            staff_at_level = levels.get(lvl, 0)
            avg_per_day = total / len(problem.days)
            self.stdout.write(
                f'    level {lvl}: 平均每天需 {avg_per_day:.1f} 人；'
                f'部門有 {staff_at_level} 位該 level 員工'
            )
