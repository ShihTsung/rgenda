"""schedule URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
# django settings
from django.conf.urls.i18n import i18n_patterns
from django.contrib import admin
from django.conf.urls.static import static
from django.urls import path, include, re_path
from django.utils.translation import gettext_lazy as _
from account.views import (departmentList,
                           departmentEdit,
                           departmentCreate,
                           departmentDelete)
from . import mail
from . import initial
# other modules


urlpatterns = i18n_patterns(
    path('admin/', admin.site.urls),
    path('', include('mainpage.urls')),
    path('accounts/', include('account.urls')),
    path('api/', include('api.urls')),
    path('departments/create', departmentCreate),
    path('departments/update/<int:id>', departmentEdit),
    path('departments/list', departmentList, name="departmentList"),
    path('departments/delete/<int:id>', departmentDelete),
    path('mailtest', mail.mail),
    path('stations/', include('station.urls')),
    path('demands/', include('demand.urls')),
    path('shifts/', include('shift.urls')),
    path('init/', initial.initial),
    path('dates/', include('date.urls')),
    # path('pre_results', include('pre_result.urls')),
    prefix_default_language=False
)

admin.site.site_header = 'Redfalcon'
# default: "Site administration"
admin.site.index_title = _('AdminSite')
admin.site.site_title = _('Administrator')  # default: "Django site admin"
