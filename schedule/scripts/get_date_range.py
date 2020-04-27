import datetime
import calendar


def range():
    now = datetime.datetime.now()
    month = now.month + 1
    if month == 13:
        month = 1
    day_num = calendar.monthrange(now.year, month)[1]
    month_str = '0' + str(month) if len(str(month)) == 1 else str(month)
    start = str(now.year) + '-' + month_str + '-' + '01'
    end = str(now.year) + '-' + month_str + '-' + str(day_num)

    return [start, end]
