from nturl2path import url2pathname
from django.urls import path, include
from . import views
from django.contrib.auth import views as auth_views
from django.conf.urls import handler404, handler500
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('', views.index_admin, name='home_admin'),
    path('location', views.viewLocation, name='location_list'),
    path('addlocation', views.add_location, name='add_location'),
    path('location/add', views.get_location_form, name='get_location_form'),
    path('addImages', views.get_images_form, name='get_images_form'),
    path('ImagesList', views.add_images, name='add_images'),
    path('formimages', views.viewImages, name = 'i'),
    path('comment', views.viewComment, name='comment_list'),
    path('addCommentForm', views.get_comment_form, name='get_comment_form'),
    # path('login/', auth_views.LoginView.as_view(template_name ='pages/login.html'), name='login' ),
    # path('logoutt/', auth_views.LogoutView.as_view(), {'next_page':' '}, name='logout' )
] 
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)