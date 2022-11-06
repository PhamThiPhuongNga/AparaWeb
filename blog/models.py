from email.policy import default
from django.db import models
from django.conf import settings
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
    logo = models.ImageField(blank=True)
    phone = models.CharField(max_length=10)
    email = models.CharField(max_length=200)
    date = models.DateTimeField(null=True,auto_now_add=True)
    image = models.ImageField(blank=True)
    wardcommune = models.CharField(max_length=100)
    distric = models.CharField(max_length=100)
    city = models.CharField(max_length=100)
    address = models.CharField(max_length=200)
    representative = models.CharField(max_length=200)
    costmin = models.CharField(max_length=10)
    costmax = models.CharField(max_length=10)
    vote = models.IntegerField(default=0)
    describe = models.TextField(null=True,max_length=200)
    
    def __str__(self):
        return self.name
    
class Comment(models.Model):
    location = models.ForeignKey(Location, null=True, on_delete=models.CASCADE, related_name = 'comments')
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    body = models.TextField(null=True)
    date = models.DateTimeField(null=True,auto_now_add=True)
    