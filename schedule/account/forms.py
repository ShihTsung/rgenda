from django import forms
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from .models import CustomUser
from django.utils.translation import gettext_lazy as _

DEPARTMENT_CHOICES = (
    ('outpatient', _('Outpatient')),
    ('op', _('OperatingRoom')),
    ('ns', _('NursingStation'))
)
LEVEL_CHOICES = (
    (3, _('Leader')),
    (2, _('Senior')),
    (1, _('Junior'))
)
GENDER_CHOICES = (
    ('M', _('Male')),
    ('F', _('Female'))
)


class CustomUserCreationForm(UserCreationForm):

    class Meta:
        model = CustomUser
        help_texts = {}
        fields = ['username', 'email', 'password1', 'password2']

    def __init__(self, *args, **kwargs):
        super(UserCreationForm, self).__init__(*args, **kwargs)

        for fieldname in ['username', 'password1', 'password2']:
            self.fields[fieldname].help_text = None


class CustomUserChangeForm(UserChangeForm):
    department = forms.CharField(
        label=_("Department"), widget=forms.widgets.Select(
            choices=DEPARTMENT_CHOICES))
    level = forms.IntegerField(label=_('Level'), widget=forms.widgets.Select(
        choices=LEVEL_CHOICES))
    eng_name = forms.CharField(
        label=_('EnglishName'), max_length=100, empty_value="Null", required=False)
    gender = forms.CharField(label=_('Gender'),
                             max_length=20,
                             widget=forms.widgets.Select(
                                 choices=GENDER_CHOICES), required=False)
    eid = forms.CharField(label=_('EmployeeId'),
                          max_length=100, empty_value="Null")
    gid = forms.CharField(label=_('GovernmentId'),
                          max_length=100, empty_value="Null", required=False)
    onboard_date = forms.CharField(
        label=_('OnboardDate'),
        max_length=100,
        empty_value="Null", help_text="YYYY-MM-DD")

    class Meta:
        model = CustomUser
        fields = ('username', 'email', 'department',
                  'level', 'eng_name', 'gender', 'is_staff', 'is_superuser',
                  'is_active')

    def __init__(self, *args, **kwargs):
        super(UserChangeForm, self).__init__(*args, **kwargs)

        for fieldname in ['username', 'email', 'department', 'level',
                          'eng_name', 'gender', 'is_staff',
                          'is_superuser', 'is_active', 'password']:
            self.fields[fieldname].help_text = None
