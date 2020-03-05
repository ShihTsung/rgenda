from django.shortcuts import render, redirect
from django.forms import inlineformset_factory
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import UserCreationForm
from django.contrib import messages

# Create your views here.
from .models import CustomUser
from .forms import CustomUserCreationForm, CustomUserChangeForm

# 新增使用者
@login_required
def registerPage(request):
    form = CustomUserCreationForm()
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            user = form.cleaned_data.get('username')
            messages.success(request, "Accunt was created for " + user)
    context = {'form': form}
    return render(request, 'registration/register.html', context)

# 使用者清單
@login_required
def userList(request):
    users = CustomUser.objects.all()
    context = {
        'users': users
    }
    return render(request, 'registration/userList.html', context)

# 刪除使用者資料
@login_required
def destroy(request, id=None):
    user = CustomUser.objects.get(id=id)
    if request.user.is_superuser and request.user.id != user.id:
        user.delete()
        return redirect("/accounts/list")
    elif request.user.is_staff:
        if not user.is_staff:
            user.delete()
        return redirect("/accounts/list")
    else:
        return redirect("/accounts/list")

# 使用者資料編輯
@login_required
def update(request, id=None):
    id = int(id)
    choosed_user = CustomUser.objects.get(id=id)
    if choosed_user.is_superuser:
        if not request.user.is_superuser:
            # raise PermissionError("you don't have permission")
            messages.error(request, "you don't have permission ")
            return redirect('/accounts/list')
    form = CustomUserChangeForm(request.POST or None, instance=choosed_user)
    if form.is_valid():
        form.save()
        return redirect('/accounts/list')

    context = {'form': form, 'target': choosed_user}
    return render(request, 'registration/userEdit.html', context)

# def loginPage(request):
#     # if request.method == 'POST':
#     #     username = request.POST.get('username')
#     #     password = request.POST.get('password')

#     #     user = authenticate(request, username=username, password=password)

#     #     if user is not None:
#     #         login(request, user)
#     #         return redirect('home')
#     context = {}
#     return render(request, 'registration/login.html', context)
