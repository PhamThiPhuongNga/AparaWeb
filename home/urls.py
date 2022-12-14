from nturl2path import url2pathname
from django.urls import path, include
from . import views
from django.contrib.auth import views as auth_views
from django.conf.urls import handler404, handler500
# from ip_address.views import show_ip_address

urlpatterns = [
    path('', views.index, name='home'),
    path('contact/', views.contact, name='contact'),
    path('register/', views.register, name='register'),
    path('login/', auth_views.LoginView.as_view(template_name ='pages/login.html'), name='login' ),
    path("logout/",views.user_logout,name="logout"),
    path("category/<int:id>",views.get_location_category,name='get_location_category'),
    path("profile/",views.profile,name="profile"),
    path('search',views.searchkeyup ,name="searchkeyup"),
    path('change-password/', auth_views.PasswordChangeView.as_view(template_name='pages/changePassword.html'), name="change-password"),
]
