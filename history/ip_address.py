# # from bs4 import BeautifulSoup
# import re
# from .models import *
# import requests

# class IpAddressMiddleware(object):
#     def __init__(self, get_response=None):
#         self.get_response = get_response
        
#     def get_location(self, ip_address):
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
    
#     def get_visitor_ip(self):
#         url = 'http://checkip.dyndns.com/'
#         data = requests.get(url)
#         ip_address = re.compile(r'Address:(\d+\.\d+\.\d+\.\d+').search(data.text).group(1)
#         return ip_address
    
#     def __call_(self, request):
#         try: 
#             x_forwarded_for =requests.META.get('HTTP_X_FORWARDED_FOR')
#             try:
#                 ip =  x_forwarded_for.split(',')[0]
#             except:
#                 ip = None
#             if not ip or ip is None:
#                 ip = self.get_visitor_ip()
#             if ip:
#                 visitor = Visitor.objects.filter(ip_address = ip)
#                 if visitor.count() < 0:
#                     country, city, ip_address, lat, log = self.get_location(ip)
#                     visitor = Visitor(ip_address=ip_address or ip, city=city, country = country, location=str(lat)+"," +str(log))
#                     visitor.save
#         except:
#             pass
        
#         response = self.get_location(request)
#         return response