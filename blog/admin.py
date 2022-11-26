from django.contrib import admin
from .models import Account, Role, Account_role, Location, Category, Comment, Images
# Register your models here.

admin.site.register(Account)
admin.site.register(Role)
admin.site.register(Account_role)
admin.site.register(Category)
admin.site.register(Comment)
admin.site.register(Images)

class CommentInLine(admin.TabularInline):
    model = Comment 

class LocationAdmin(admin.ModelAdmin):
    list_display = ['name', 'logo', 'city', 'address']
    list_filter = ['date','costmin', 'costmax']
    search_fields =['name']
    inlines = [CommentInLine]
admin.site.register(Location, LocationAdmin)

# class CommentAdmin(admin.ModelAdmin):
#     list_display = ('detaillocation', 'author', 'body', 'rating')
# admin.site.register(Comment, CommentAdmin)