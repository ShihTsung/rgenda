import datetime
import calendar

# 格式化


def zeroPadding(num, digit):
    zero = ""
    for i in range(digit):
        zero += '0'
    return (zero + str(num))[-digit:]


def get_date(num):
    now = datetime.datetime.now()
    year = now.year
    month = now.month + num
    if month > 12:
        year += 1
        month -= 12
    date = zeroPadding(year, 4) + '-' + zeroPadding(month, 2) + '-01'

    return date

# 抓範圍，可自訂長度


def date_range(m, n):

    start = get_date(m)
    end = get_date(n)

    return [start, end]
