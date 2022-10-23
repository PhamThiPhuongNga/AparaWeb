from email.policy import default
from django.db import models

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
    logo = models.ImageField(upload_to='users/%Y/%m/%d/', blank=True)
    phone = models.CharField(max_length=10)
    email = models.CharField(max_length=200)
    date = models.DateTimeField(null=True,auto_now_add=True)
    image = models.ImageField(upload_to='users/%Y/%m/%d/', blank=True)
    ward_commune = models.CharField(max_length=100)
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
   