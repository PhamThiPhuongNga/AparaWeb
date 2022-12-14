from django.urls import path
from . import views


#from django.views.generic import LocationListView


urlpatterns = [
    
    path('location/', views.locationList, name='location'),
    path('location/<int:pk>/', views.detaillocation.as_view(), name='detaillocation'),
    path('location/<int:pk>/edit/<int:review_id>',views.edit_review,name="edit_review"),
    path('location/<int:pk>/delete/<int:review_id>',views.delete_review,name="delete_review"),
    path('location/searchlocation',views.search,name="searchlocation"),
    path('location/search',views.searchkeyup,name="searchkeyup"),
    
]