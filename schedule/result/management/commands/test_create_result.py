from django.core.management.base import BaseCommand
from account.models import Department
from account.views import cycle_analysis, get_cycle
from copy import deepcopy
from datetime import date, timedelta
from date.views import attr_list, red_dict
from demand.views import get_demands
from numpy.random import choice
from result.views import get_continue_days, str_to_date, get_workday_num, get_used_rest
from reservation.views import get_reserve_leave, get_promise_leave, get_official_leave
from shift.views import get_shifts
from station.views import get_stations


class Command(BaseCommand):
    help = 'test creating results'

    def handle(self, *args, **options):
        # testing data
        department = Department.objects.get(id=1)
        date_start = date(2020, 8, 1)
        date_end = date(2020, 8, 31)

        # 日期資料
        date_list = [date_start + timedelta(days=i) for i in range((date_end - date_start).days + 1)]
        attrs = attr_list(department.id, date_start, date_end)
        reds = red_dict(date_start, date_end)

        # 連續工作天、預排假、保證假、公假
        continue_dict = get_continue_days(department, date_start)
        reserve_leave_dict = get_reserve_leave(department, date_start, date_end)
        promise_leave_dict = get_promise_leave(department, date_start, date_end)
        official_leave_dict = get_official_leave(department, date_start, date_end)

        # create cycle list
        ca = cycle_analysis(department, date_start)
        cycle_no = ca['cycle_no']
        cycle0 = get_cycle(department, cycle_no)
        cycle = cycle0
        cycle_list = [cycle]
        while cycle[-1] < date_end:
            cycle_no += 1
            cycle = get_cycle(department, cycle_no)
            cycle_list.append(cycle)

        # cycle0已排好的(前月的)班表
        used_rest = get_used_rest(department, cycle0[0], date_start)

        # get all stations, shifts in department
        stations = get_stations(department)
        shifts = get_shifts(department)

        output = dict()

        for station in stations:
            for shift in shifts:

                # 排1工作站1班別
                user_pool = dict()
                workday_dict = dict()
                demands = get_demands(station, shift)
                for demand in demands:
                    # 當前level的user
                    user_current_level = list()

                    # 建立參與排班的user池 & output
                    for user in demand['users']:
                        user_current_level.append(user.id)
                        user_pool.update({
                            user.id: {
                                'holiday_rest': user.holiday_rest_num - user.holiday_rest_num_used,
                                'reserve_leave': reserve_leave_dict[user.id],
                                'promise_leave': promise_leave_dict[user.id],
                                'official_leave': official_leave_dict[user.id],
                            },
                        })

                        output[user.id] = dict()
                        output[user.id]['date_pre'] = continue_dict[user.id]
                        for d in date_list:
                            if d in official_leave_dict[user.id]:
                                output[user.id][str(d)] = 1
                            else:
                                output[user.id][str(d)] = 0
                        workday_dict[user.id] = dict()

                    # 建立需求單
                    demand_dict = dict()
                    for ind, d in enumerate(date_list):
                        if attrs[ind] == '0':
                            demand_dict[str(d)] = 0
                        elif attrs[ind] == '1':
                            demand_dict[str(d)] = demand['demand'].config1
                        elif attrs[ind] == '2':
                            demand_dict[str(d)] = demand['demand'].config2

                    # for cycle 計算班表
                    for ind, cycle in enumerate(cycle_list):

                        # set workday_dict
                        if ind == 0:
                            for user in demand['users']:
                                workday_dict[user.id][ind] = get_workday_num(user.id, cycle[0], cycle[-1], date_start)
                        else:
                            for user in demand['users']:
                                workday_dict[user.id][ind] = get_workday_num(user.id, cycle[0], cycle[-1])

                        # 檢查可工作天數是否滿足需求
                        total_demands = sum([demand_dict[str(d)] for d in cycle if date_start <= d <= date_end])
                        total_workdays = sum([workday_dict[user_id][ind] for user_id in user_pool])

                        if total_demands <= total_workdays:
                            # 人力滿足需求 嘗試排班100次
                            for _ in range(100):
                                # 每次回圈重設 temp_output、weight_workday、weight_holiday_rest
                                # create temp_output
                                temp_output = deepcopy(output)

                                # set weight, start calculating
                                weight_workday = dict([(user_id, workday_dict[user_id][ind]) for user_id in user_pool])
                                weight_holiday_rest = dict(
                                    [(user_id, user_pool[user_id]['holiday_rest']) for user_id in user_pool])

                                for d in cycle:
                                    if date_start <= d <= date_end:

                                        # user可排人選
                                        options = list()
                                        for user_id, user_data in user_pool.items():
                                            if d in (user_data['promise_leave'] + user_data['official_leave']) or \
                                                    weight_workday[user_id] == 0 or temp_output[user_id][str(d)] != 0:
                                                continue
                                            s = 0
                                            d_n = d - timedelta(days=1)
                                            d_p = d + timedelta(days=1)
                                            while str(d_n) in temp_output[user_id]:
                                                if temp_output[user_id][str(d_n)] != 0:
                                                    s += temp_output[user_id][str(d_n)]
                                                    d_n = d_n - timedelta(days=1)
                                                else:
                                                    break
                                            while str(d_p) in temp_output[user_id]:
                                                if temp_output[user_id][str(d_p)] != 0:
                                                    s += temp_output[user_id][str(d_p)]
                                                    d_p = d_p + timedelta(days=1)
                                                else:
                                                    break
                                            if s < 6:
                                                options.append(user_id)
                                        if len(options) < demand_dict[str(d)]:
                                            # 可排人數不足 跳出
                                            break

                                        # 預排假權重(10倍)
                                        weight_reserve_leave = dict()
                                        for user_id in options:
                                            if d in user_pool[user_id]['reserve_leave']:
                                                weight_reserve_leave[user_id] = 1
                                            else:
                                                weight_reserve_leave[user_id] = 10

                                        weight = list()
                                        if reds[str(d)]:
                                            # 若為休假日 則剩餘 可休假假日數 越少的人被排到的機率越高
                                            for user_id in options:
                                                weight.append(weight_workday[user_id] * weight_reserve_leave[user_id] *
                                                              (100 - weight_holiday_rest[user_id]) * 1000 + 1)
                                        else:
                                            for user_id in options:
                                                weight.append(
                                                    weight_workday[user_id] * weight_reserve_leave[user_id] * 1000 + 1)
                                        weight_sum = sum(weight)
                                        weight = [w / weight_sum for w in weight]
                                        on_duty = choice(options, demand_dict[str(d)], p=weight, replace=False)
                                        for user_id in user_pool:
                                            if user_id in on_duty:
                                                temp_output[user_id][str(d)] = 1
                                                weight_workday[user_id] -= 1
                                                if reds[str(d)] and user_id not in user_current_level:
                                                    weight_holiday_rest[user_id] += 1
                                            elif reds[str(d)] and user_id in user_current_level:
                                                weight_holiday_rest[user_id] -= 1
                                else:
                                    # 成功排完 1 cycle
                                    # 儲存結果
                                    output = temp_output

                                    # 儲存剩餘工作天 & 可休假假日數
                                    for user_id in user_pool:
                                        workday_dict[user_id][ind] = weight_workday[user_id]
                                        user_pool[user_id]['holiday_rest'] = weight_holiday_rest[user_id]

                                    # 結束迴圈
                                    break
                            else:
                                # 嘗試100次皆失敗，強制產生班表，不必滿足所有需求
                                # 嘗試排班10次，取最滿足需求的結果
                                best_temp_output = None
                                demand_loss = total_demands

                                best_weight_workday = dict()
                                best_weight_holiday_rest = dict()

                                for _ in range(10):
                                    # 每次回圈重設 weight_workday、weight_holiday_rest
                                    temp_demand_loss = 0
                                    temp_output = deepcopy(output)

                                    # set weight, start calculating
                                    weight_workday = dict(
                                        [(user_id, workday_dict[user_id][ind]) for user_id in user_pool])
                                    weight_holiday_rest = dict(
                                        [(user_id, user_pool[user_id]['holiday_rest']) for user_id in user_pool])

                                    for d in cycle:
                                        if date_start <= d <= date_end:

                                            # user可排人選
                                            options = list()
                                            for user_id, user_data in user_pool.items():
                                                if d in (user_data['promise_leave'] + user_data['official_leave']) or \
                                                        weight_workday[user_id] == 0 or temp_output[user_id][str(d)] != 0:
                                                    continue
                                                s = 0
                                                d_n = d - timedelta(days=1)
                                                d_p = d + timedelta(days=1)
                                                while str(d_n) in temp_output[user_id]:
                                                    if temp_output[user_id][str(d_n)] != 0:
                                                        s += temp_output[user_id][str(d_n)]
                                                        d_n = d_n - timedelta(days=1)
                                                    else:
                                                        break
                                                while str(d_p) in temp_output[user_id]:
                                                    if temp_output[user_id][str(d_p)] != 0:
                                                        s += temp_output[user_id][str(d_p)]
                                                        d_p = d_p + timedelta(days=1)
                                                    else:
                                                        break
                                                if s < 6:
                                                    options.append(user_id)
                                            if len(options) < demand_dict[str(d)]:
                                                # 可排人數不足 所有可排人員皆排班 記錄差額
                                                temp_demand_loss += demand_dict[str(d)] - len(options)
                                                for user_id in user_pool:
                                                    if user_id in options:
                                                        temp_output[user_id][str(d)] = 1
                                                        weight_workday[user_id] -= 1
                                                        if reds[str(d)] and user_id not in user_current_level:
                                                            weight_holiday_rest[user_id] += 1
                                                    elif reds[str(d)] and user_id in user_current_level:
                                                        weight_holiday_rest[user_id] -= 1
                                            else:
                                                # 預排假權重
                                                weight_reserve_leave = dict()
                                                for user_id in options:
                                                    if d in user_pool[user_id]['reserve_leave']:
                                                        weight_reserve_leave[user_id] = 1
                                                    else:
                                                        weight_reserve_leave[user_id] = 10

                                                weight = list()
                                                if reds[str(d)]:
                                                    for user_id in options:
                                                        weight.append(
                                                            weight_workday[user_id] * weight_reserve_leave[user_id] * (
                                                                    100 - weight_holiday_rest[user_id]) * 1000 + 1)
                                                else:
                                                    for user_id in options:
                                                        weight.append(weight_workday[user_id] * weight_reserve_leave[
                                                            user_id] * 1000 + 1)
                                                weight_sum = sum(weight)
                                                weight = [w / weight_sum for w in weight]
                                                on_duty = choice(options, demand_dict[str(d)], p=weight, replace=False)
                                                for user_id in user_pool:
                                                    if user_id in on_duty:
                                                        temp_output[user_id][str(d)] = 1
                                                        weight_workday[user_id] -= 1
                                                        if reds[str(d)] and user_id not in user_current_level:
                                                            weight_holiday_rest[user_id] += 1
                                                    elif reds[str(d)] and user_id in user_current_level:
                                                        weight_holiday_rest[user_id] -= 1
                                    if temp_demand_loss < demand_loss:
                                        demand_loss = temp_demand_loss
                                        best_temp_output = temp_output
                                        best_weight_workday.update(weight_workday)
                                        best_weight_holiday_rest.update(weight_holiday_rest)
                                output = best_temp_output

                                # 儲存剩餘工作天 & 可休假假日數
                                for user_id in user_pool:
                                    workday_dict[user_id][ind] = best_weight_workday[user_id]
                                    user_pool[user_id]['holiday_rest'] = best_weight_holiday_rest[user_id]
                        else:
                            # 嘗試排班100次，取最滿足需求的結果
                            best_temp_output = None
                            demand_loss = total_demands

                            best_weight_workday = dict()
                            best_weight_holiday_rest = dict()

                            for _ in range(100):
                                # 每次回圈重設 temp_output、weight_workday、weight_holiday_rest
                                # create temp_output
                                temp_output = deepcopy(output)
                                temp_demand_loss = 0

                                # set weight, start calculating
                                weight_workday = dict([(user_id, workday_dict[user_id][ind]) for user_id in user_pool])
                                weight_holiday_rest = dict(
                                    [(user_id, user_pool[user_id]['holiday_rest']) for user_id in user_pool])

                                for d in cycle:
                                    if date_start <= d <= date_end:
                                        # user可排人選
                                        options = list()
                                        for user_id, user_data in user_pool.items():
                                            if d in (user_data['promise_leave'] + user_data['official_leave']) or \
                                                    weight_workday[user_id] == 0 or temp_output[user_id][str(d)] != 0:
                                                continue
                                            s = 0
                                            d_n = d - timedelta(days=1)
                                            d_p = d + timedelta(days=1)
                                            while str(d_n) in temp_output[user_id]:
                                                if temp_output[user_id][str(d_n)] != 0:
                                                    s += temp_output[user_id][str(d_n)]
                                                    d_n = d_n - timedelta(days=1)
                                                else:
                                                    break
                                            while str(d_p) in temp_output[user_id]:
                                                if temp_output[user_id][str(d_p)] != 0:
                                                    s += temp_output[user_id][str(d_p)]
                                                    d_p = d_p + timedelta(days=1)
                                                else:
                                                    break
                                            if s < 6:
                                                options.append(user_id)
                                        if len(options) < demand_dict[str(d)]:
                                            # 可排人數不足 所有可排人員皆排班 記錄差額
                                            temp_demand_loss += demand_dict[str(d)] - len(options)
                                            for user_id in user_pool:
                                                if user_id in options:
                                                    temp_output[user_id][str(d)] = 1
                                                    weight_workday[user_id] -= 1
                                                    if reds[str(d)] and user_id not in user_current_level:
                                                        weight_holiday_rest[user_id] += 1
                                                elif reds[str(d)] and user_id in user_current_level:
                                                    weight_holiday_rest[user_id] -= 1
                                        else:
                                            # 預排假權重
                                            weight_reserve_leave = dict()
                                            for user_id in options:
                                                if d in user_pool[user_id]['reserve_leave']:
                                                    weight_reserve_leave[user_id] = 1
                                                else:
                                                    weight_reserve_leave[user_id] = 10

                                            weight = list()
                                            if reds[str(d)]:
                                                for user_id in options:
                                                    weight.append(
                                                        weight_workday[user_id] * weight_reserve_leave[user_id] * (
                                                                100 - weight_holiday_rest[user_id]) * 1000 + 1)
                                            else:
                                                for user_id in options:
                                                    weight.append(weight_workday[user_id] * weight_reserve_leave[
                                                        user_id] * 1000 + 1)
                                            weight_sum = sum(weight)
                                            weight = [w / weight_sum for w in weight]
                                            on_duty = choice(options, demand_dict[str(d)], p=weight, replace=False)
                                            for user_id in user_pool:
                                                if user_id in on_duty:
                                                    temp_output[user_id][str(d)] = 1
                                                    weight_workday[user_id] -= 1
                                                    if reds[str(d)] and user_id not in user_current_level:
                                                        weight_holiday_rest[user_id] += 1
                                                elif reds[str(d)] and user_id in user_current_level:
                                                    weight_holiday_rest[user_id] -= 1
                                if temp_demand_loss < demand_loss:
                                    demand_loss = temp_demand_loss
                                    best_temp_output = temp_output
                                    best_weight_workday.update(weight_workday)
                                    best_weight_holiday_rest.update(weight_holiday_rest)
                            output = best_temp_output

                            # 儲存剩餘工作天 & 可休假假日數
                            for user_id in user_pool:
                                workday_dict[user_id][ind] = best_weight_workday[user_id]
                                user_pool[user_id]['holiday_rest'] = best_weight_holiday_rest[user_id]

                # 移除date_pre
                for user_id in user_pool:
                    output[user_id].pop('date_pre')
                    q = used_rest[user_id]
                    for ind, cycle in enumerate(cycle_list):
                        options = ['例', '休'] * 2 ** department.schedule_rule
                        # 第一個迴圈需將之前的例假/休假扣除
                        if ind == 0:
                            for st in q:
                                if st in ['例', '休']:
                                    options.remove(st)
                        q = q[-6:]
                        for d in cycle:
                            if date_start <= d <= date_end:
                                if output[user_id][str(d)] == 1:
                                    if shift.shift_type == '白班':
                                        output[user_id][str(d)] = 'Ｄ'
                                    elif shift.shift_type == '小夜':
                                        output[user_id][str(d)] = 'Ｅ'
                                    elif shift.shift_type == '大夜':
                                        output[user_id][str(d)] = 'Ｎ'
                                else:
                                    if '例' in q and '休' in options:
                                        output[user_id][str(d)] = '休'
                                    elif '例' not in q and '例' in options:
                                        output[user_id][str(d)] = '例'
                                    else:
                                        output[user_id][str(d)] = options.pop(0)
                                q.append(output[user_id][str(d)])
                                if len(q) > 6:
                                    q.pop(0)
        # 將0指派為 例假/休假

        for user_id, result in output.items():
            print(user_id)
            print(list(result.values()))
