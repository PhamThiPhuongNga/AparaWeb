from socket import fromshare
from django import forms
import re 
from django.contrib.auth.models import User, Group
from django.core.exceptions import ObjectDoesNotExist
from django.contrib.auth.forms import UserCreationForm,AuthenticationForm

class AddManagerForm(forms.Form):
    username = forms.CharField(label = 'Họ tên', max_length=30)
    email = forms.EmailField(label = 'Email')
    password1 = forms.CharField(label = 'Mật khẩu', widget=forms.PasswordInput())
    password2 = forms.CharField(label = 'Nhập lại mật khẩu', widget=forms.PasswordInput())


    def clean_password2(self):
        if 'password1' in self.cleaned_data:
            password1 = self.cleaned_data['password1']
            password2 = self.cleaned_data['password2']
            if password1==password2 and password1:
                return password2
        raise forms.ValidationError('Mật khẩu không hợp lệ!')
    def clean_username(self):
        username = self.cleaned_data['username']
            
        if not re.search(r'^\w+$', username):
            raise forms.ValidationError('Tài khoản chứa ký tự đặc biệt!')
        try:
            User.objects.get(username=username)
        except ObjectDoesNotExist:
            return username
        raise forms.ValidationError('Tài khoản đã tồn tại')
    def save(self):
        user = User.objects.create_user(username=self.cleaned_data['username'], email=self.cleaned_data['email'], password=self.cleaned_data['password1'] )
        user.is_staff = True
        user.save()
        group = Group.objects.get(name='Manager')
        user.groups.add(group)

        
