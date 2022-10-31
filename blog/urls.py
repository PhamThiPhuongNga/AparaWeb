from django.urls import path
from . import views

urlpatterns = [
    path('location/', views.list, name='location'),
    path('location/<int:id>/', views.detaillocation, name='detaillocation'),
]