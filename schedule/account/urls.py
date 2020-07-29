from django.contrib.auth import views
from .views import *
from django.urls import path

urlpatterns = [
    path('login/', views.LoginView.as_view(), name='login'),
    path('logout/', views.LogoutView.as_view(), name='logout'),
    path('register/', registerPage, name='register'),
    path('change_password/',
         views.PasswordChangeView.as_view(
             template_name='registration/change_password.html',
             success_url='done'
         ),
         name='change_password'),
    path('change_password/done/',
         views.PasswordChangeDoneView.as_view(
             template_name='registration/change_password_complete.html'),
         name='change_password_complete'),
    path('password_reset/', views.PasswordResetView.as_view(
        template_name='registration/reset_password.html'
    ),
        name='password_reset'),
    path('password_reset/done/', views.PasswordResetDoneView.as_view(
         template_name='registration/reset_password_complete.html'
         ),
         name='password_reset_done'),
    path('reset/<uidb64>/<token>/', views.PasswordResetConfirmView.as_view(),
         name='password_reset_confirm'),
    path('reset/done/', views.PasswordResetCompleteView.as_view(),
         name='password_reset_complete'),
    path('list/', userList, name='userlist'),
    path('delete/<int:id>', destroy, name="delete"),
    path('update/<int:id>', update, name="update"),
    path('<int:id>', userDetail, name="detail"),
    path('download/empty-excel', download_empty_excel, name='download_empty_excel'),
    path('license/', license_audit, name="license"),
]
