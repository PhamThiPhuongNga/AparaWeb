from django.shortcuts import render 
from .models import Location 
from django.db.models import Q
from django.views.generic import ListView, DetailView

# Create your views here.
class LocationListView(ListView):
    queryset = Location.objects.all().order_by("-date")
    template_name = 'location/location.html'
    context_object_name = 'Locations'
    paginate_by = 4
    
    # def get_queryset(self):
    #     if 'q' in self.request.GET:
    #         q = self.request.GET.get['q']
    #         multiple_q = Q(Q(city__icontains=q) | Q(district__icontains=q))
    #         Locations = Location.objects.filter(multiple_q)
    #     else:
    #         Locations = {'Locations': Location.objects.all().order_by("-date")}
    #         return Locations
class LocationDetailView(DetailView):
    model = Location
    template_name = 'location/detaillocation.html'
# def detaillocation(request , id):
#     detaillocation = Location.objects.get(id=id)
#     return render(request, 'location/detaillocation.html', {'detaillocation': detaillocation})
