from numpy.random import choice
import random
from datetime import date


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
            weight = dict([(s.name, weight_workday[s.name] * weight_continuous[s.name] * weight_scheduled_rest[s.name] * weight_scheduled_work[s.name] * weight_ensure_rest[s.name] * 1000 + 1) for s in staffs])
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
