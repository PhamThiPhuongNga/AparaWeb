from django.urls import path
from . import views
#from django.views.generic import LocationListView


urlpatterns = [
    path('location/', views.LocationListView.as_view(), name='location'),
    path('location/<int:pk>/', views.detaillocation, name='detaillocation'),
]