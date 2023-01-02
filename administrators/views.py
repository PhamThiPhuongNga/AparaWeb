from django.core.paginator import Paginator
from django.shortcuts import render, redirect
from django.http import HttpResponse
from blog.models import Location, Comment, Category, Images
from django.contrib.auth.models import Group, User
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import View, DetailView
from .forms import AddManagerForm
from django.contrib import messages 

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
    return render(request, 'common/home_admin.html')

def index(request):
    return render(request, 'pages/home.html')

def get_location_form(request):
    category_list = Category.objects.filter()
    return render(request, 'location/add.html',{"category_list": category_list})

def add_location (request):
    if request.user.is_authenticated:  
        if request.method =="POST":
            category = request.POST['category']
            name = request.POST['name']
            if len(request.FILES) != 0:
                logo = request.FILES['logo']
                image = request.FILES['image']
            phone = request.POST['phone']
            wardcommune = request.POST['ward']
            district = request.POST['district']
            city = request.POST['city']
            address = request.POST['address']
            costmin = request.POST['costmin']
            costmax = request.POST['costmax']
            describe = request.POST['describe']
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
    else:
        return redirect('/login')
        

def edit_location (request, id):
    if request.user.is_authenticated: 
        loca = Location.objects.get(id=id)
        cate =  Category.objects.filter()
        if request.method =="POST":
            if len(request.FILES) !=0:
                if len(loca.logo) > 0 and len(loca.image) > 0 :
                    os.remove(loca.logo.path)
                    os.remove(loca.image.path)  
                elif len(loca.logo) > 0 :
                    os.remove(loca.logo.path)
                elif len(loca.image) > 0:
                    os.remove(loca.image.path)
                    
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
    else:
        return redirect('/login')
    
def delete_location (request, id):
    if request.user.is_authenticated:
        loca = Location.objects.get(id=id)
        # if len(loca.logo) > 0 and len(loca.image) > 0:
        #     os.remove(loca.logo.path)
        #     os.remove(loca.image.path)
        # if len(loca.logo) > 0:
        #     os.remove(loca.logo.path)
        # if len(loca.image) > 0:
        #     os.remove(loca.image.path)
        loca.delete()
        messages.success(request, "Xoá thành công!")
        return redirect('/administrators/location')  
    else:
        return redirect('/login')
    
# =============================IMAGES=========================
def get_images_form(request):
    location_list = Location.objects.filter()
    return render(request, 'location/addImages.html',{"location_list": location_list})

def add_images (request):    
    if request.user.is_authenticated:
        if request.method =="POST":
            locationlis = request.POST['location_id']
            location = Location.objects.get(id=locationlis)
            images = request.FILES.getlist('images')
            for img in images:
                im = Images.objects.create(location_id=location,image = img)
                im.save()
            messages.success(request, "Thêm thành công!")
            return redirect('/administrators/formimages')
        else:
            messages.error(request, "Thêm mới thất bại!")
            return render(request, 'common/error.html')  
    else:
        return redirect('/login')  

def delete_images(request, images_id):
    if request.user.is_authenticated:
        immge = Images.objects.get(id=images_id)
        if len(immge.image) > 0:
            os.remove(immge.image.path)
        immge.delete()
        messages.success(request, "Xoá thành công!")
        return redirect('/administrators/formimages') 
    else:
        return redirect('/login')
      
def viewImages(request):
    i = Images.objects.filter().order_by("-date")
    paginator = Paginator(i, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'location/formimages.html',{'page_obj': page_obj})
# ==============================================

# ================================CATEGORY==========================
def viewCategory(request):
    comment = Category.objects.filter().order_by("-id")
    paginator = Paginator(comment, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'category/index.html',{'page_obj': page_obj})

def add_category(request):
    if request.user.is_authenticated:
        if request.method =="POST":
            name = request.POST['name']
            cate = Category.objects.create(name = name)
            cate.save()
            messages.success(request, "Thêm mới thành công!")
            return redirect('/administrators/category')
        return render(request, 'category/add.html')
    else: 
        return redirect('/login')

def edit_category (request, id):
    if request.user.is_authenticated:
        category = Category.objects.get(id=id)
        if request.method =="POST":
            category.name = request.POST['name']
            category.save()
            messages.success(request, "Cập nhật thành công!")
            return redirect('/administrators/category')
        return render(request, 'category/edit.html',{"category": category})
    else:
        return redirect('/login')

def delete_category(request, id):
    if request.user.is_authenticated:
        category = Category.objects.get(id=id)
        category.delete()
        messages.success(request, "Xoá thành công!")
        return redirect('/administrators/category')  
    else:
        return redirect('/login')

# ===================================================

# =========================ACCOUNT===========================
def viewAccount(request):
    group = Group.objects.filter().order_by('-id')
    paginator = Paginator(group, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'account/index.html',{'page_obj': page_obj})
    

def viewUser(request,id ):
    user = User.objects.filter(groups=id).order_by('-id')
    paginator = Paginator(user, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'account/indexUserGroup.html',{'page_obj': page_obj})

def get_group_list(request):
    group = Group.objects.all()
    return render(request, 'account/add.html',{'group': group})

def add_account(request):
    if request.user.is_authenticated:
        form = AddManagerForm()
        if request.method=='POST':
            form = AddManagerForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request,'Thêm mới thành công')
                return redirect('account_list')
            else:
                form = AddManagerForm()
        return render(request,'account/add.html',{'form':form})
    else:
        return redirect('/login')