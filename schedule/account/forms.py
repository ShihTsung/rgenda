from django import forms
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from .models import CustomUser, Department
from django.utils.translation import gettext_lazy as _

ROLE_CHOICES = (
    ('admin', _('admin')),
    ('manager', _('manager')),
    ('user', _('user'))
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
TYPE_CHOICES = (
    ('Normal', _('Normal')),
    ('Pragnant', _('Pragnant')),
    ('Intern', _('Intern')),
)


# 建立帳號
class CustomUserCreationForm(UserCreationForm):
    department = forms.ModelChoiceField(
        queryset=Department.objects.all(),
        label=_('Department'), required=False)

    onboard_date = forms.DateField(
        label=_('OnboardDate'),
        widget=forms.DateInput(attrs={'type': 'date'}))

    class Meta:
        model = CustomUser
        help_texts = {}
        fields = ['username', 'email', 'password1', 'password2', 'full_name',
                  'department', 'level', 'gender', 'role', 'type_of_user',
                  'can_be_scheduled', 'eid', 'onboard_date']

    def __init__(self, *args, **kwargs):
        super(UserCreationForm, self).__init__(*args, **kwargs)

        for fieldname in ['username', 'password1', 'password2']:
            self.fields[fieldname].help_text = None


# 編輯帳號
class CustomUserChangeForm(UserChangeForm):

    department = forms.ModelChoiceField(
        queryset=Department.objects.all(),
        label=_('Department'), required=False)

    level = forms.IntegerField(label=_('Level'), widget=forms.widgets.Select(
        choices=LEVEL_CHOICES))

    full_name = forms.CharField(
        max_length=100,
        label=_('FullName'),
        required=False)

    role = forms.CharField(
        max_length=100,
        label=_('Role'),
        widget=forms.widgets.Select(choices=ROLE_CHOICES)
    )

    gender = forms.CharField(
        label=_('Gender'),
        max_length=20,
        widget=forms.widgets.Select(
            choices=GENDER_CHOICES),
        required=False
    )
    type_of_user = forms.CharField(
        label=_('Type'),
        max_length=20,
        widget=forms.widgets.Select(
            choices=TYPE_CHOICES)
    )
    can_be_scheduled = forms.BooleanField(
        label=_('CanBeScheduled'),
        required=False,
        initial=False
    )

    holiday_rest_num = forms.IntegerField(label=_('HolidayRestNum'))
    special_rest_num = forms.IntegerField(label=_('SpecialRestNum'))
    hour_required = forms.IntegerField(label=_('HourRequired'))
    hour_realized = forms.IntegerField(label=_('HourRealized'))

    eid = forms.CharField(label=_('EmployeeId'),
                          max_length=100, empty_value="Null")
    onboard_date = forms.DateField(
        label=_('OnboardDate'),
        widget=forms.DateInput(attrs={'type': 'date'}))

    class Meta:
        model = CustomUser
        fields = ('username', 'full_name', 'email', 'department',
                  'level', 'gender', 'role', 'type_of_user',
                  'can_be_scheduled', 'holiday_rest_num',
                  'special_rest_num', 'hour_required',
                  'hour_realized', 'eid', 'onboard_date')
# 消除 help_text

    # def __init__(self, *args, **kwargs):
    #     super().__init__(*args, **kwargs)
    #     field_list = ['username', 'first_name', 'last_name', 'email',
    #                   'department', 'level', 'gender',
    #                   'is_staff', 'is_superuser', 'is_active', 'password']
    #     for fieldname in field_list:
    #         self.fields[fieldname].help_text = None


class DepartmentCreationForm(forms.ModelForm):
    name = forms.CharField(
        label=_('Name'),
        max_length=100, empty_value="Null",
        required=True)
    detail = forms.CharField(
        label=_('Detail'),
        max_length=100, empty_value="Null",
        required=False)

    class Meta:
        model = Department
        help_texts = {}
        fields = ['name', 'detail']


class DepartmentChangeForm(forms.ModelForm):
    name = forms.CharField(
        label=_('Name'),
        max_length=100,
        empty_value="Null",
        required=True)
    detail = forms.CharField(
        label=_('Detail'),
        max_length=100,
        empty_value="Null",
        required=False)

    class Meta:
        model = Department
        help_texts = {}
        fields = ['name', 'detail']
