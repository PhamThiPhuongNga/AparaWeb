from nturl2path import url2pathname
from django.urls import path, include
from . import views
from django.contrib.auth import views as auth_views
from django.conf.urls import handler404, handler500

urlpatterns = [
    path('', views.index_admin, name='home_admin'),
    path('location/index', views.location_list, name='location_list'),
    path('location/add', views.add_location, name='add_location'),
    # path('login/', auth_views.LoginView.as_view(template_name ='pages/login.html'), name='login' ),
    # path('logoutt/', auth_views.LogoutView.as_view(), {'next_page':' '}, name='logout' )
]