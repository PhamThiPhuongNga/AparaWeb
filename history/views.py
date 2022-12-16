from django.shortcuts import render, redirect
from django.views.generic import ListView, View
from django.views.generic.detail import SingleObjectMixin
import re
from .models import *
import requests

from .models import History

class HistoryList(ListView):
    def get_queryset(self):
        user_history = History.objects.filter(user=self.request.user)
        return user_history

class HistoryDelete(SingleObjectMixin, View):
    model = History
    def get(self, request, *args, **kwargs):
        obj = self.get_object()
        if obj is not None:
            obj.delete()
        return redirect('history')
    
# def get_location(request, ip_address):
#         url = 'http://checkip.dyndns.com/'
#         loc_url = 'https://ip-api.io/json/{}'
#         data = requests.get(url)
#         if not ip_address:
#             ip_address = re.compile(r'Address:(\d+\.\d+\.\d+\.\d+').search(data.text).group(1)
#         location = requests.get(loc_url.format(ip_address))
#         city = location.json()['city']
#         country = location.json()['country_name']
#         lat = location.json()['latitude']
#         log = location.json()['longitude']
#         print(location)
#         print(country)
#         print(ip_address)
#         return country, city, ip_address, lat, log 
    
# def home(request):
#     """ your vies to handle http request """
#     ip_address = get_location(request)
#     return (request,'history/history_list.html',ip_address)
# Create your views here.
