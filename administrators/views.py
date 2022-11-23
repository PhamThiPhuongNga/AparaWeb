from urllib import response
from django.shortcuts import render
from django.http import HttpResponse
# from .forms import ResistrationForm
from django.http import HttpResponseRedirect
# Create your views here.
def index_admin(request):
    return render(request, 'home_admin.html')
def location_list(request):
    return render(request, 'location/index.html')
def add_location(request):
    return render(request, 'location/add.html')