from django.contrib import admin
from .models import History
# Register your models here.

# admin.site.register(Account)
# admin.site.register(History)
# admin.site.register(Visitor)
# admin.site.register(VisitorInterest)
# Register your models here.

class HistoryAdmin(admin.ModelAdmin):
    list_display = ['user', 'object_id', 'content_object','content_type','viewed_on']
admin.site.register(History, HistoryAdmin)
