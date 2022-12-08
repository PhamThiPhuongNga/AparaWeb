from django.contrib import admin
from .models import Location, Category, Comment, Images
# Register your models here.

# admin.site.register(Account)
admin.site.register(Category)

class CommentInLine(admin.TabularInline):
    model = Comment 
class ImagesInLine(admin.TabularInline):
    model = Images

class LocationAdmin(admin.ModelAdmin):
    list_display = ['name', 'logo','image', 'address','city','district','wardcommune']
    list_filter = ['date','costmin', 'costmax']
    search_fields =['name']
    inlines = [CommentInLine, ImagesInLine]
admin.site.register(Location, LocationAdmin)

class CommentAdmin(admin.ModelAdmin):
    list_display = ['detaillocation', 'author', 'body', 'rating']
    list_filter = ['date','detaillocation', 'author','rating']
    search_fields =['detaillocation', 'author','rating']
admin.site.register(Comment, CommentAdmin)

class ImagesAdmin(admin.ModelAdmin):
    list_display = ['location_id', 'image']
    list_filter = ['date', 'location_id']
    search_fields =['location_id']
admin.site.register(Images, ImagesAdmin)
