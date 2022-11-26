from email.policy import default
from django.db import models
from django.conf import settings
from django.db.models import Avg, Count
# Create your models here.
class Account(models.Model):
    name = models.CharField(max_length=200)
    phone = models.CharField(max_length=10)
    email = models.CharField(max_length=200)
    password = models.CharField(max_length=100)
    gender = models.CharField(max_length=50)
    address = models.CharField(max_length=200)
    
    def __str__(self):
        return self.name
    
class Role(models.Model):
    name = models.CharField(max_length=100)

class Account_role(models.Model):
    account = models.ForeignKey(Account, on_delete=models.CASCADE)
    role = models.ForeignKey(Role, on_delete=models.CASCADE)

class Category(models.Model):
    name = models.CharField(max_length=200)
    def __str__(self):
        return self.name
    
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
    costmin = models.CharField(max_length=10)
    costmax = models.CharField(max_length=10)
    # vote = models.IntegerField(default=0)
    describe = models.TextField(null=True,max_length=200)
    
    def __str__(self):
        return self.name
    
    def averageReview(self):
        reviews = Comment.objects.filter(detaillocation=self, status=True).aggregate(average=Avg('rating'))
        avg = 0
        if reviews['average'] is not None:
            avg = float(reviews['average'])
        return avg

    def countReview(self):
        reviews = Comment.objects.filter(detaillocation=self, status=True).aggregate(count=Count('id'))
        count = 0
        if reviews['count'] is not None:
            count = int(reviews['count'])
        return count
    
RATING =(
    (1, '1'),
    (2, '2'),
    (3, '3'),
    (4, '4'),
    (5, '5'),
)
class Comment(models.Model):
    detaillocation = models.ForeignKey(Location, null=True, on_delete=models.CASCADE, related_name = 'comments')
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    body = models.TextField(null=True)
    rating = models.FloatField(null=True)
    # ,choices=RATING
    date = models.DateTimeField(null=True,auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    status = models.BooleanField(null=True,default=True)
    
class Images(models.Model): 
    location_id = models.ForeignKey(Location, null=True, on_delete=models.CASCADE)
    image = models.FileField(upload_to='images',blank=True)
    