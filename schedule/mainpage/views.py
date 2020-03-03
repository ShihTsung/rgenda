# django modules
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.utils import timezone
from django.utils.translation import gettext_lazy as _


# models

@login_required
def index(request):
    if request.user.is_staff:
        return render(request, 'mainpage/manager_index.html')
    else:
        return render(request, 'mainpage/employee_index.html')
