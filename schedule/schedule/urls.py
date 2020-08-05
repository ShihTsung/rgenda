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
from django.conf import settings
from django.urls import path, include, re_path
from django.utils.translation import gettext_lazy as _
from account.views import (departmentList,
                           departmentEdit,
                           departmentCreate,
                           departmentDelete,
                           departmentDetail)
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
# other modules
from . import mail
from . import initial
import notifications.urls
import notice.urls

handler404 = 'mainpage.views.handler404'
handler500 = 'mainpage.views.handler500'

schema_view = get_schema_view(
    openapi.Info(
        title="Rgenda API",
        default_version='v1',
        description="API 文件",
        terms_of_service="https://www.google.com/policies/terms/",
        contact=openapi.Contact(email="lyle.lai@redfalcon-hpc.com"),
        license=openapi.License(name="BSD License"),
    ),
    public=False,
    permission_classes=(permissions.IsAuthenticated,),
)

urlpatterns = [
    path('api/', include('api.urls')),
    re_path(r'^swagger(?P<format>\.json|\.yaml)$',
            schema_view.without_ui(cache_timeout=0), name='schema-json'),
    re_path(r'^swagger/$',
            schema_view.with_ui('swagger',
                                cache_timeout=0), name='schema-swagger-ui'),
    re_path(r'^redoc/$',
            schema_view.with_ui('redoc',
                                cache_timeout=0), name='schema-redoc')
]
urlpatterns += i18n_patterns(
    path('admin/', admin.site.urls),
    path('', include('mainpage.urls')),
    path('accounts/', include('account.urls')),
    path('departments/create', departmentCreate),
    path('departments/update/<int:id>', departmentEdit),
    path('departments/list', departmentList, name="departmentList"),
    path('departments/<int:id>', departmentDetail),
    path('departments/delete/<int:id>', departmentDelete),
    path('mailtest', mail.mail),
    path('stations/', include('station.urls')),
    path('demands/', include('demand.urls')),
    path('shifts/', include('shift.urls')),
    path('init/', initial.initial),
    path('dates/', include('date.urls')),
    path('reserves/', include('reservation.urls')),
    path('results/', include('result.urls')),
    path('i18n/', include('django.conf.urls.i18n')),
    re_path('^inbox/notifications/',
            include(notifications.urls, namespace='notifications')),
    path('notice/', include('notice.urls', namespace='notice')),
    # path('results', include('result.urls')),
    # prefix_default_language=True,
)
urlpatterns += static(settings.MEDIA_URL,
                      document_root=settings.MEDIA_ROOT)
admin.site.site_header = 'Redfalcon'
# default: "Site administration"
admin.site.index_title = _('AdminSite')
admin.site.site_title = _('Administrator')  # default: "Django site admin"
