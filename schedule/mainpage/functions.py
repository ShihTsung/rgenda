from numpy.random import choice
import random
from datetime import date
from .get_data import *


def calculate(staffs, demands):

    demand_total = sum([d.staff_num for d in demands])
    workday_total = sum([s.workday for s in staffs])
    if demand_total > workday_total:
        print('More staffs needed')
        return None

    result = dict([(s.name, list()) for s in staffs])

    weight_workday = dict([(s.name, s.workday) for s in staffs])

    weight_holiday_rest = dict([(s.name, s.holiday_rest) for s in staffs])

    continuous_dict = dict([(s.name, s.continuous) for s in staffs])

    # Start calculate
    for i in range(len(demands)):
        # Weight continuous
        weight_continuous = dict()
        for sn, continuous in continuous_dict.items():
            weight_continuous[sn] = 0 if continuous == 6 else 1
        # Weight scheduled rest
        weight_scheduled_rest = dict()
        for s in staffs:
            if demands[i].day in s.scheduled_rest:
                weight_scheduled_rest[s.name] = 1
            else:
                weight_scheduled_rest[s.name] = 10
        # Weight scheduled work
        weight_scheduled_work = dict()
        for s in staffs:
            if demands[i].day in s.scheduled_work:
                if continuous_dict[s.name] == 6:
                    print('X, continue workday over 6 cause by scheduled work')
                    return None
                if weight_workday[s.name] == 0:
                    print('X, workday is 0 with scheduled work not set')
                    return None
                weight_scheduled_work[s.name] = 1000
            else:
                weight_scheduled_work[s.name] = 1
        # Weight ensure rest
        weight_ensure_rest = dict()
        for s in staffs:
            if demands[i].day in s.ensure_rest:
                weight_ensure_rest[s.name] = 0
            else:
                weight_ensure_rest[s.name] = 1
        # Calculate weight
        if demands[i].is_weekday:
            weight = dict([(s.name, weight_workday[s.name] * weight_continuous[s.name] * weight_scheduled_rest[s.name]
                            * weight_scheduled_work[s.name] * weight_ensure_rest[s.name] * 1000 + 1) for s in staffs])
        else:
            weight = dict([(s.name, weight_workday[s.name] * weight_continuous[s.name] * weight_scheduled_rest[s.name] * weight_scheduled_work[s.name] * weight_ensure_rest[s.name] * weight_holiday_rest[s.name] *
                            1000 + 1) for s in staffs])
        weight_sum = sum(weight.values())
        for sn in weight:
            weight[sn] = weight[sn] / weight_sum
        # if sum(weight.values()) != 1:
        #     weight[random.choice(weight.keys())] += 1 - sum(weight.values())
        # Sampling
        on_duty = choice([name for name in weight], demands[i].staff_num, p=[weight[name] for name in weight],
                         replace=False)
        for s in staffs:
            if s.name in on_duty:
                result[s.name].append(1)
                weight_workday[s.name] -= 1
                continuous_dict[s.name] += 1
            else:
                result[s.name].append(0)
                continuous_dict[s.name] = 0
                if not demands[i].is_weekday:
                    weight_holiday_rest[s.name] -= 1
        for s in staffs:
            if weight_workday[s.name] == -1 or weight_holiday_rest[s.name] == -1 or continuous_dict[s.name] == 7:
                print('X', result[s.name], '| workday remain: ', weight_workday[s.name],
                      '| continuous:', continuous_dict[s.name], '| holiday rest:', weight_holiday_rest[s.name])
                return None
    return result


def assignment(attendance_matrix, department):
    """
    attendance_matrix => Dict{'name':List[int]} 每個人的班表
    department => Department object 部門
    return Dict{'name': List[int or id of shift]}
    """
    if len(attendance_matrix) == 0:
        return None
    user_nums = len(attendance_matrix)
    users = attendance_matrix.keys()
    demand_pool = {'白班': [], '小夜': [], '大夜': []}
    demand_list = get_demands(department)

    for d in demand_list:
        demand_pool[d.shift.shift_type] += [d.id] * d.weekday
    w, n, g = len(demand_pool['白班']), len(
        demand_pool['小夜']), len(demand_pool['大夜'])
    total_weight = w + n + g
    weight_w, weight_n, weight_g = w/total_weight, n/total_weight, g/total_weight

    type_result = choice(['白班', '小夜', '大夜'], user_nums,
                         p=[weight_w, weight_n, weight_g])
    result = []
    for i in type_result:
        if demand_pool[i] == []:
            result.append('')
            continue
        select = random.choice(demand_pool[i])
        result.append(select)
        demand_pool[i].remove(select)
    for i, (k, v) in enumerate(attendance_matrix.items()):
        for idx in range(len(v)):
            if v[idx] == 1:
                v[idx] = result[i]
    return attendance_matrix


def rest_assignment(req):
    """
    req => Dict{'name': List[0 or id of shift] }
    return req
    """
    for key, val in req.items():
        x, y = 0.5, 0.5
        for i in range(len(val)):
            if val[i] == 0:
                v = choice(2, 1, p=[x, y])
                if v == 1:
                    val[i] = 'H'
                    x *= 10
                else:
                    val[i] = 'R'
                    y *= 10
                x, y = x/(x+y), y/(x+y)

    """把第一個假日設為例假"""
    # for loop rows
    for key, val in req.items():
        # for loop items of row
        for i in range(len(val)):
            if val[i] == 'H':
                break
            if val[i] == 'R':
                for j in range(i+1, len(val)):
                    if val[j] == 'H':
                        val[i], val[j] = val[j], val[i]
                        break
                break
    return req
