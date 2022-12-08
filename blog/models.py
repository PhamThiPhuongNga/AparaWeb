from email.policy import default
from django.db import models
from django.conf import settings
from django.db.models import Avg, Count
# Create your models here.
# class Account(models.Model):
#     name = models.CharField(max_length=200)
#     phone = models.CharField(max_length=10)
#     email = models.CharField(max_length=200)
#     password = models.CharField(max_length=100)
#     gender = models.CharField(max_length=50)
#     address = models.CharField(max_length=200)
    
#     def __str__(self):
#         return self.name

class Category(models.Model):
    name = models.CharField(max_length=200)
    def __str__(self):
        return self.name

COSTMIN =(
    (25000, '25000'),
    (50000, '50000'),
    (100000, '100000'),
    (120000, '120000'),
    (150000, '150000'),
    (200000, '200000'),
    (250000, '250000'),
)   
COSTMAX =(
    (50000, '50000'),
    (100000, '100000'),
    (120000, '120000'),
    (150000, '150000'),
    (200000, '200000'),
    (250000, '250000'),
    (300000, '300000'),
) 
class Location(models.Model):
    category = models.ForeignKey(Category, null=True, on_delete=models.CASCADE)
    name = models.CharField(max_length=200)
    logo = models.ImageField(upload_to='images', null=False, default=None)
    phone = models.CharField(max_length=10)
    # email = models.CharField(max_length=200)
    date = models.DateTimeField(null=True,auto_now_add=True)
    image = models.FileField(upload_to='images',blank=True)
    wardcommune = models.CharField(max_length=100)
    district = models.CharField(max_length=100)
    city = models.CharField(max_length=100)
    address = models.CharField(max_length=200)
    # representative = models.CharField(max_length=200)
    costmin = models.CharField(max_length=10, choices=COSTMIN)
    costmax = models.CharField(max_length=10, choices=COSTMAX)
    # vote = models.IntegerField(default=0)
    describe = models.TextField(null=True,max_length=255)
    timestart = models.TimeField(null=True)
    timeend = models.TimeField(null=True)
    
    def __str__(self):
        return self.name
    
    def averageReview(self):
        reviews = Comment.objects.filter(detaillocation=self, status=True).aggregate(average=Avg('rating'))
        avg = 0
        if reviews['average'] is not None:
            avg = round(reviews['average'],1)
        return avg

    def countReview(self):
        reviews = Comment.objects.filter(detaillocation=self, status=True).aggregate(count=Count('id'))
        count = 0
        if reviews['count'] is not None:
            count = int(reviews['count'])
        return count
    
RATING =(
    (1, '1'),
    (1.5, '1.5'),
    (2, '2'),
    (2.5, '2.5'),
    (3, '3'),
    (3.5, '3.5'),
    (4, '4'),
    (4.5, '4.5'),
    (5, '5'),
)
class Comment(models.Model):
    detaillocation = models.ForeignKey(Location, null=True, on_delete=models.CASCADE, related_name = 'comments')
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    body = models.TextField(null=True)
    rating = models.FloatField(null=True, choices=RATING)
    # ,choices=RATING
    date = models.DateTimeField(null=True,auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    status = models.BooleanField(null=True,default=True)
    def __str__(self):
        return str(self.detaillocation)
    
class Images(models.Model): 
    location_id = models.ForeignKey(Location, null=True, on_delete=models.CASCADE, related_name = 'images')
    image = models.FileField(upload_to='images',blank=True)
    date = models.DateTimeField(null=True,auto_now_add=True)
    def __str__(self):
        return str(self.location_id)