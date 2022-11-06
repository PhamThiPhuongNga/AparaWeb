from django.urls import path
from . import views

urlpatterns = [
    path('location/', views.LocationListView.as_view(), name='location'),
    path('location/<int:pk>/', views.LocationDetailView.as_view(), name='detaillocation'),
]