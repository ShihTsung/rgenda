"""
Django settings for schedule project.
"""

import os
from decouple import config, Csv
from django.utils.translation import gettext_lazy as _
from django.contrib.messages import constants as messages

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# ------------------------------------------------------------
# Security — all secrets come from environment variables
# ------------------------------------------------------------
SECRET_KEY = config('SECRET_KEY')
DEBUG = config('DEBUG', default=False, cast=bool)
ALLOWED_HOSTS = config('ALLOWED_HOSTS', default='localhost,127.0.0.1', cast=Csv())

# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'account.apps.AccountConfig',
    'corsheaders',
    'rest_framework',
    'rest_framework.authtoken',
    'crispy_forms',
    'crispy_bootstrap4',
    'mainpage',
    'api',
    'result',
    'station',
    'demand',
    'shift',
    'date',
    'remarks',
    'reservation',
    'notifications',
    'notice',
    'drf_spectacular',
]

CRISPY_TEMPLATE_PACK = 'bootstrap4'

# 避免 Django 4.x 將所有既有 AutoField 自動改為 BigAutoField
DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'

REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.TokenAuthentication',
        'rest_framework.authentication.SessionAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ],
    'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
}

SPECTACULAR_SETTINGS = {
    'TITLE': 'Rgenda API',
    'VERSION': 'v1',
    'DESCRIPTION': 'API 文件',
    'SERVE_PERMISSIONS': ['rest_framework.permissions.IsAuthenticated'],
}

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.middleware.locale.LocaleMiddleware',
]

ROOT_URLCONF = 'schedule.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates').replace('\\', '/'), ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.template.context_processors.i18n',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'schedule.wsgi.application'

# CORS — django-cors-headers 4.x 改名
CORS_ALLOW_CREDENTIALS = True
CORS_ALLOW_ALL_ORIGINS = DEBUG  # 只在 debug 模式開放所有來源
CORS_ALLOWED_ORIGINS = config(
    'CORS_ALLOWED_ORIGINS',
    default='http://localhost',
    cast=Csv(),
)

CSRF_TRUSTED_ORIGINS = config(
    'CSRF_TRUSTED_ORIGINS',
    default='http://localhost,http://localhost:5173,http://127.0.0.1',
    cast=Csv(),
)
CORS_ALLOW_METHODS = (
    'DELETE', 'GET', 'OPTIONS', 'PATCH', 'POST', 'PUT', 'VIEW',
)
CORS_ALLOW_HEADERS = (
    'XMLHttpRequest', 'X_FILENAME', 'accept-encoding', 'authorization',
    'content-type', 'dnt', 'origin', 'user-agent', 'x-csrftoken',
    'x-requested-with', 'Pragma',
)

# ------------------------------------------------------------
# Database
# ------------------------------------------------------------
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': config('DB_NAME', default='schedule_db'),
        'USER': config('DB_USER', default='schedule_user'),
        'PASSWORD': config('DB_PASSWORD', default=''),
        'HOST': config('DB_HOST', default='db'),
        'PORT': config('DB_PORT', default='5432'),
    }
}

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator'},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]

# Messages
MESSAGE_TAGS = {
    messages.DEBUG: 'alert-info',
    messages.INFO: 'alert-info',
    messages.SUCCESS: 'alert-success',
    messages.WARNING: 'alert-warning',
    messages.ERROR: 'alert-danger',
}

# ------------------------------------------------------------
# Email
# ------------------------------------------------------------
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = config('EMAIL_HOST', default='smtp.gmail.com')
EMAIL_HOST_USER = config('EMAIL_HOST_USER', default='')
EMAIL_HOST_PASSWORD = config('EMAIL_HOST_PASSWORD', default='')
EMAIL_USE_TLS = config('EMAIL_USE_TLS', default=True, cast=bool)
EMAIL_PORT = config('EMAIL_PORT', default=587, cast=int)

# Internationalization
LANGUAGE_CODE = 'zh-hant'
TIME_ZONE = 'Asia/Taipei'
USE_I18N = True
DATE_FORMAT = 'Y-m-d'
USE_L10N = False
USE_TZ = True
LOCALE_PATHS = [os.path.join(BASE_DIR, 'locale')]
LANGUAGES = [
    ('en', _('English')),
    ('zh-hant', _('Traditional Chinese')),
]

LOGIN_REDIRECT_URL = '/zh-hant/'

# Static / Media
STATIC_URL = '/static/'
MEDIA_URL = '/images/'
AUTH_USER_MODEL = 'account.CustomUser'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static'),
]
MEDIA_ROOT = '/code/schedule/prod_static/images'
STATIC_ROOT = '/code/schedule/prod_static/'
