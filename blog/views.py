from django.shortcuts import render
from .models import Location 
# Create your views here.
def list(request):
    Data = {'Locations': Location.objects.all().order_by("-date")}
    return render(request, 'location/location.html', Data)
def detaillocation(request , id):
    detaillocation = Location.objects.get(id=id)
    return render(request, 'location/detaillocation.html', {'detaillocation': detaillocation})