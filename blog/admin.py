from django.contrib import admin
from .models import Account, Role, Account_role, Location, Category
# Register your models here.

admin.site.register(Account)
admin.site.register(Role)
admin.site.register(Account_role)
admin.site.register(Category)

class LocationAdmin(admin.ModelAdmin):
    list_display = ['name', 'phone', 'city', 'representative', 'vote']
    list_filter = ['date','costmin', 'costmax', 'vote']
    search_fields =['name']
admin.site.register(Location, LocationAdmin)
