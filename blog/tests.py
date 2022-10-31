from turtle import title
from django.test import TestCase
from .models import Location, Post

# Create your tests here.
class LocationTests(TestCase):
    def setUp(seft):
        Location.objects.create(
            name='myname'
            
        )