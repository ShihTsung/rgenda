from django.core.mail import send_mail
from django.shortcuts import render, redirect


def mail(request):
    send_mail('郵件測試', 'Here is the message.\r郵件內容',
              'circlepen1252@gmail.com',
              ['larry52699@gmail.com'], fail_silently=False)

    return redirect('/')
