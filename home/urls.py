from nturl2path import url2pathname
from django.urls import path, include
from . import views
from django.contrib.auth import views as auth_views
from django.conf.urls import handler404, handler500

urlpatterns = [
    path('', views.index, name='home'),
    path('contact/', views.contact, name='contact'),
    path('register/', views.register, name='register'),
    path('login/', auth_views.LoginView.as_view(template_name ='pages/login.html'), name='login' ),
    path("logout/",views.user_logout,name="logout"),
]

# handler404 = 'home.views.error'
# handler500 = 'home.views.error'