from date.models import H_Calendar
from account.models import CustomUser as User
from account.models import Department
from scripts.get_date_range import *
from datetime import time, datetime, timedelta, date
from collections import defaultdict
from date.models import H_Calendar
from result.models import Result, PreResult
from account.views import cycle_analysis, get_cycle, assign_user


def check_result(d_id, month_to_check=None):
    """
    """
    invalid = defaultdict(list)
    # demand_unsatisfied = defaultdict()
    if month_to_check:
        results = Result.objects.filter(
            date__month=month_to_check).order_by('date')
    else:
        results = PreResult.objects.order_by('date')
        month_to_check = results[0].date.month
    to_check = defaultdict(list)
    for result in results:
        # print('check_result', type(result))
        to_check[result.user.id].append(result)
    department = Department.objects.get(id=d_id)
    for user_id, schedule in to_check.items():
        check_cycle(department, schedule, invalid)
        check_rest_day(department, schedule, invalid)
        check_rest_hour(schedule, invalid)
        if User.objects.get(id=user_id).pregnant:
            check_hour_pregnant(schedule, invalid)
    return invalid


def check_cycle(department, results, invalid):
    """
    檢查 單週/單月/三月 內班種是否相同，增加 unique shift type in a week
    :param department:
    :param results:
    :param invalid:
    :return:
    """
    date0 = results[0].date
    user = results[0].user
    results = [x for x in results]

    # 單週同班種
    if department.schedule_rule == 0:
        # temp_results = results.copy()
        temp_results = [result for result in results]
        ca = cycle_analysis(department, date0)
        current_shift_type = None
        i = ca['day_no']
        for d in get_cycle(department, ca['cycle_no'])[-1::-1]:
            if d < date0:
                try:
                    temp_results.insert(
                        0, Result.objects.get(date=d, user=user))
                    i -= 1
                except:
                    break
            else:
                break
        for result in temp_results:
            if i % 7 == 0:
                current_shift_type = None
            if current_shift_type is None and result.shift.shift_type in [0, 1, 2]:
                current_shift_type = result.shift.shift_type
            elif result.shift.shift_type in [0, 1, 2] and result.shift.shift_type != current_shift_type and result in results:
                invalid[result.id].append('unique shift type in a week')
            i += 1
        return None
    # 單月/三月同班種
    current_shift_type = None
    if department.schedule_rule == 2 and date0.month % 3 != department.month_cycle:
        results_last_month = Result.objects.filter(date__month=results[0].date.month - 1,
                                                   user=user,
                                                   shift__shift_type__in=[0, 1, 2])
        shift_types = [
            result.shift.shift_type for result in results_last_month]
        counter = 0
        for st in [0, 1, 2]:
            if shift_types.count(st) > counter:
                counter = shift_types.count(st)
                current_shift_type = st
    for result in results:
        if current_shift_type is None and result.shift.shift_type in [0, 1, 2]:
            current_shift_type = result.shift.shift_type
        elif result.shift.shift_type in [0, 1, 2] and result.shift.shift_type != current_shift_type:
            invalid[result.id].append('unique shift type in a week')
    return None


def check_rest_day(department, results, invalid):
    """
    檢查
    1. 連續工作超過6天，增加 continue working over 6 days
    2. 單一週期內休假數目不足，增加 workday too much in the cycle
    3. 週末/國定假日休假額度用完，增加 holiday rest out of limit
    :param department:
    :param results:
    :param invalid:
    :return:
    """
    user = results[0].user
    holiday_rest_remain = user.holiday_rest_num - user.holiday_rest_num_used
    date0 = results[0].date
    ca = cycle_analysis(department, date0)
    temp_results = [x for x in results]
    # add previous results to make a complete cycle
    for d in get_cycle(department, ca['cycle_no'])[-1::-1]:
        if d < date0:
            try:
                temp_results.insert(0, Result.objects.get(date=d, user=user))
            except:
                break
        else:
            break
    # get continue workday number
    last_week_results = Result.objects.filter(
        date__in=[date0 - timedelta(days=i) for i in range(1, 8)],
        user=user).order_by('date')
    continue_workday = 0
    for result in last_week_results:
        if result.shift.shift_type in [0, 1, 2, 3]:
            continue_workday += 1
        else:
            continue_workday = 0
    # start checking
    work_days_limit = 5 * 2 ** department.law_rule
    work_days = 0
    for ind, result in enumerate(temp_results):
        if ind % (5 * 2 ** department.law_rule) == 0:
            work_days_limit = 5 * 2 ** department.law_rule
            work_days = 0
        if H_Calendar.objects.filter(date=result.date).first().attribute == 'holiday':
            work_days_limit -= 1
        if result.shift.shift_type in [0, 1, 2, 3]:
            continue_workday += 1
            work_days += 1
        else:
            continue_workday = 0
            if H_Calendar.objects.filter(date=result.date).first().attribute in ['weekend', 'holiday']:
                holiday_rest_remain -= 1
        if continue_workday > 6 and result in results:
            invalid[result.id].append('continue working over 6 days')
        if work_days > work_days_limit and result in results:
            invalid[result.id].append('workday too much in the cycle')
        if holiday_rest_remain < 0:
            invalid[result.id].append('holiday rest out of limit')
    return None


def check_rest_hour(results, invalid):
    """
    檢查兩班之間休息是否過11小時，不足的話增加 rest time less than 11 hours
    :param results:
    :param invalid:
    :return:
    """
    try:
        last_result = Result.objects.get(
            user=results[0].user, date=results[0].date - timedelta(days=1))
        last_off_time = datetime.combine(
            last_result.date, time(hour=0, minute=0, second=0))
        if last_result.shift.shift_type in [0, 1, 2]:
            if last_result.shift.start_time > last_result.shift.end_time:
                last_off_time = datetime.combine(
                    last_result.date, last_result.shift.end_time) + timedelta(days=1)
            else:
                last_off_time = datetime.combine(
                    last_result.date, last_result.shift.end_time)
    except:
        last_off_time = datetime.combine(results[0].date, time(
            hour=0, minute=0, second=0)) - timedelta(days=1)
    for result in results:
        if result.shift.shift_type in [0, 1, 2]:
            start_time = datetime.combine(result.date, result.shift.start_time)
            if start_time - last_off_time < timedelta(hours=11):
                invalid[result.id].append('rest time less than 11 hours')
            if result.shift.start_time > result.shift.end_time:
                last_off_time = datetime.combine(
                    result.date, result.shift.end_time) + timedelta(days=1)
            else:
                last_off_time = datetime.combine(
                    result.date, result.shift.end_time)
    return None


def check_hour_pregnant(results, invalid):
    """
    檢查孕婦上班時間是否早於6點或下班時間晚於22點，是的話增加 pregnant woman work between 22 PM to 6 AM
    :param results:
    :param invalid:
    :return:
    """
    for result in results:
        if result.shift.shift_type in [0, 1, 2] and not (
                result.shift.start_time >= time(hour=6, minute=0) and result.shift.end_time <= time(hour=22, minute=0)):
            invalid[result.id].append(
                'pregnant woman work between 22 PM to 6 AM')
    return None
