from nturl2path import url2pathname
from django.urls import path, include
from . import views
from django.contrib.auth import views as auth_views
from django.conf.urls import handler404, handler500
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('', views.index_admin, name='home_admin'),
    path('home', views.index, name='home'),
    path('location', views.viewLocation, name='location_list'),
    
    path('addlocation', views.add_location.as_view(), name='add_location'),
    path('location/add', views.get_location_form, name='get_location_form'),
    path('location/edit/<int:id>/', views.edit_location.as_view(), name="edit_location"),
    path('location/delete/<int:id>', views.delete_location.as_view(), name='delete_location'),
    
    path('addImages', views.get_images_form, name='get_images_form'),
    path('ImagesList', views.add_images.as_view(), name='add_images'),
    path('location/deleteImages/<int:images_id>', views.delete_images, name='delete_images'),
    path('formimages', views.viewImages, name = 'i'),
    
    path('category', views.viewCategory, name='category_list'),
    path('addCategoryForm', views.add_category, name='add_category'),
    path('category/edit/<int:id>/', views.edit_category, name="edit_category"),
    path('category/delete/<int:id>', views.delete_category, name='delete_category'),
    
    path('accounts', views.viewAccount, name = 'account_list'),
    path('accounts/<int:id>/', views.viewUser, name = 'account_user_list'),
    # path('accounts/add/', views.get_group_list, name = 'get_group_list'),
    path('addAccount', views.add_account, name = 'add_account'),
    
    # path('login/', auth_views.LoginView.as_view(template_name ='pages/login.html'), name='login' ),
    # path('logoutt/', auth_views.LogoutView.as_view(), {'next_page':' '}, name='logout' )
] 
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)