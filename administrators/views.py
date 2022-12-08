from django.core.paginator import Paginator
from django.shortcuts import render, redirect
from django.http import HttpResponse
from blog.models import Location, Comment, Category, Images
from django.contrib.auth.models import Group, User
from django.contrib import messages
# from .forms import ResistrationForm
import os
# from .forms import uploadMultiForm

# Create your views here.

def viewLocation(request):
    comment = Location.objects.filter().order_by("-date")
    paginator = Paginator(comment, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'location/index.html',{'page_obj': page_obj})

def index_admin(request):
    return render(request, 'home_admin.html')

def get_location_form(request):
    category_list = Category.objects.filter()
    return render(request, 'location/add.html',{"category_list": category_list})

def add_location (request):
    if request.method =="POST":
        category = request.POST['category']
        name = request.POST['name']
        logo = request.FILES['logo']
        phone = request.POST['phone']
        wardcommune = request.POST['ward']
        district = request.POST['district']
        city = request.POST['city']
        address = request.POST['address']
        costmin = request.POST['costmin']
        costmax = request.POST['costmax']
        describe = request.POST['describe']
        image = request.FILES['image']
        timestart = request.POST['timestart']
        timeend = request.POST['timeend']
        categoryyy = Category.objects.get(id=category)
        location = Location.objects.create(category=categoryyy,
                                    name = name,
                                    logo = logo,
                                    phone = phone,
                                    wardcommune = wardcommune,
                                    district = district,
                                    city = city,
                                    address = address,
                                    costmin = costmin,
                                    costmax = costmax,
                                    describe = describe,
                                    image = image,
                                    timestart = timestart,
                                    timeend = timeend)
        location.save()
        return redirect('/administrators/location')
    else:
        return render(request, 'common/error.html')

def edit_location (request, id):
    loca = Location.objects.get(id=id)
    cate =  Category.objects.filter()
    if request.method =="POST":
        if len(request.FILES) !=0:
            if len(loca.logo) > 0 and len(loca.image) > 0:
                os.remove(loca.logo.path, loca.image.path)
            loca.logo = request.FILES['logo']
            loca.image = request.FILES['image']
        loca.city = request.POST['city']
        loca.district = request.POST['district']
        loca.wardcommune = request.POST['ward']  
        category = request.POST['category']
        
        categoryyy = Category.objects.get(id=category)
        loca.category = categoryyy
        
        loca.name = request.POST['name']
        loca.phone = request.POST['phone']
        loca.address = request.POST['address']
        loca.costmin = request.POST['costmin']
        loca.costmax = request.POST['costmax']
        loca.describe = request.POST['describe']
        print(loca)
        loca.save()
        messages.success(request, "Cập nhật thành công!")
        return redirect('/administrators/location')
    return render(request, 'location/edit.html',{"loca": loca, "cate": cate})

def delete_location(request, id):
    loca = Location.objects.get(id=id)
    if len(loca.logo) > 0 and len(loca.image) > 0:
        os.remove(loca.logo.path, loca.image.path)
    loca.delete()
    messages.success(request, "Xoá thành công!")
    return redirect('/administrators/location')  
    
def get_images_form(request):
    location_list = Location.objects.filter()
    return render(request, 'location/addImages.html',{"location_list": location_list})
        
def add_images (request):
    if request.method =="POST":
        locationlis = request.POST['location_id']
        location = Location.objects.get(id=locationlis)
        images = request.FILES.getlist('images')
        for img in images:
            im = Images.objects.create(location_id=location,image = img)
            im.save()
        return redirect('/administrators/formimages')
    else:
        return render(request, 'common/error.html')    
    
def edit_images (request,images_id):
    im = Location.objects.filter()
    immge = Images.objects.get( id=images_id)
    if request.method =="POST":
        if len(request.FILES) !=0:
            if len(immge.image) > 0:
                os.remove( immge.image.path)
            immge.image = request.FILES['images']
        immge.save()
        messages.success(request, "Cập nhật thành công!")
        return redirect('/administrators/location/formimages.html')
    return render(request, 'location/editImages.html',{"immge": immge, "im":im})

def delete_images(request, images_id):
    immge = Images.objects.get(id=images_id)
    if len(immge.image) > 0:
        os.remove(immge.image.path)
    immge.delete()
    messages.success(request, "Xoá thành công!")
    return redirect('/administrators/location') 
      
def viewImages(request):
    i = Images.objects.filter().order_by("-date")
    paginator = Paginator(i, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'location/formimages.html',{'page_obj': page_obj})


def viewComment(request):
    comment = Comment.objects.filter().order_by("-date")
    paginator = Paginator(comment, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'comment/index.html',{'page_obj': page_obj})

def get_comment_form(request):
    location_list = Location.objects.filter()
    return render(request, 'comment/add.html',{"location_list": location_list})


def viewAccount(request):
    group = Group.objects.filter().order_by('-id')
    paginator = Paginator(group, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'account/index.html',{'page_obj': page_obj})
    

def viewUser(request,id ):
    # group = Group.objects.get(id=id)
    user = User.objects.filter(groups=id)
    paginator = Paginator(user, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'account/indexUserGroup.html',{'page_obj': page_obj})