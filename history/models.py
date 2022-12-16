from django.db import models
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey
from django.conf import settings
from django.db.models import Avg, Count

from .signals import object_viewed_signal

User = settings.AUTH_USER_MODEL

# Create your models here.

class History(models.Model):
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    content_type = models.ForeignKey(ContentType, on_delete=models.SET_NULL, null=True)
    object_id = models.PositiveBigIntegerField()
    content_object = GenericForeignKey()
    viewed_on = models.DateTimeField(auto_now_add=True)
    
    
    # def __str__(self):
    #     return "%s viewed: %s" %(self.content_object, self.viewed_on, self.object_id, self.user)
    # def __str__(self):
    #     # return self.content_object, self.viewed_on, self.object_id, self.user
    #     template = '{0.content_object}/{0.viewed_on}/{0.object_id}/{0.user}'
    #     return template.format(self)
    
    class Meta:
        verbose_name_plural = "Histories"
        
    def countHistory(self):
        his = History.objects.filter(object_id=self, status=True).aggregate(count=Count('object_id'))
        count = 0
        if his['count'] is not None:
            count = int(his['count'])
        return count    

def object_viewed_receiver(sender, instance, request, *args, **kwargs):
    new_history = History.objects.create(
        user    = request.user,
        content_type    = ContentType.objects.get_for_model(sender),
        object_id      = instance.id,
        
    )

object_viewed_signal.connect(object_viewed_receiver)


# class Visitor(models.Model):
#     ip_address = models.CharField(max_length=200, null=True, blank=True )
#     city = models.CharField(max_length=200, null=True, blank=True )
#     location = models.CharField(max_length=200, null=True, blank=True )
#     country = models.CharField(max_length=200, null=True, blank=True )
#     state = models.CharField(max_length=200, null=True, blank=True )
#     email = models.CharField(max_length=200, null=True, blank=True )
#     name = models.CharField(max_length=200, null=True, blank=True )
#     created = models.DateTimeField(auto_now_add=True )
#     active = models.BooleanField(default=True)
    
#     class Meta:
#         ordering = ('created' ,)
        
#     def __str__(self):
#         return self.ip_address
    
# class VisitorInterest(models.Model):
#     visitor = models.ForeignKey(Visitor,on_delete=models.CASCADE, null=True, blank=True,related_name='get_interest')
#     tags = models.CharField(max_length=100, null=True, blank=True )
#     score = models.IntegerField(default=1)
    
#     class Meta:
#         ordering = ('tags' ,)
        
#     def __str__(self):
#         return self.visitor.ip_address