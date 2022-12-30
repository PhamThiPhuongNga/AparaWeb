from django.core.paginator import Paginator
from django.shortcuts import render, redirect
from django.http import HttpResponse
from blog.models import Location, Comment, Category, Images
from django.contrib.auth.models import Group, User
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import View, DetailView
from .forms import AddUserForm

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

class add_location (LoginRequiredMixin, View):
    login_url = '/login/'      
    def post(self, request):   
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
            # if request.user.has_perm('Login.add_location'):
            #     location.save()
            #     return redirect('/administrators/location')
            # else:
            #     return render(request, 'common/error.html')
        else:
            return render(request, 'common/error.html')

class edit_location (LoginRequiredMixin, View):
    login_url = '/login/' 
    def post (request, id):
        loca = Location.objects.get(id=id)
        cate =  Category.objects.filter()
        if request.method =="POST":
            # if len(request.FILES) !=0:
            #     if len(loca.logo) > 0 and len(loca.image) > 0 :
            #         os.remove(loca.logo.path)
            #         os.remove(loca.image.path)  
            #     if len(loca.logo) > 0 :
            #         os.remove(loca.logo.path)
            #     elif len(loca.image) > 0:
            #         os.remove(loca.image.path)
                    
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
    
class delete_location (LoginRequiredMixin, View):
    login_url = '/login/' 
    def post(request, id):
        loca = Location.objects.get(id=id)
        if len(loca.logo) > 0 and len(loca.image) > 0:
            os.remove(loca.logo.path)
            os.remove(loca.image.path)
        if len(loca.logo) > 0 and len(loca.image) == 0:
            os.remove(loca.logo.path)
        if len(loca.logo) == 0 and len(loca.image) > 0:
            os.remove(loca.image.path)
        loca.delete()
        messages.success(request, "Xoá thành công!")
        return redirect('/administrators/location')  
    
# =============================IMAGES=========================
def get_images_form(request):
    location_list = Location.objects.filter()
    return render(request, 'location/addImages.html',{"location_list": location_list})

class add_images (LoginRequiredMixin, View):    
    login_url = '/login/'     
    def post (request):
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

def delete_images(request, images_id):
    immge = Images.objects.get(id=images_id)
    if len(immge.image) > 0:
        os.remove(immge.image.path)
    immge.delete()
    messages.success(request, "Xoá thành công!")
    return redirect('/administrators/formimages') 
      
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
    if request.method =="POST":
        name = request.POST['name']
        cate = Category.objects.create(name = name)
        cate.save()
        return redirect('/administrators/category')
    return render(request, 'category/add.html')

def edit_category (request, id):
    category = Category.objects.get(id=id)
    if request.method =="POST":
        category.name = request.POST['name']
        category.save()
        messages.success(request, "Cập nhật thành công!")
        return redirect('/administrators/category')
    return render(request, 'category/edit.html',{"category": category})

def delete_category(request, id):
    category = Category.objects.get(id=id)
    category.delete()
    messages.success(request, "Xoá thành công!")
    return redirect('/administrators/category')  


# ===================================================

# =========================ACCOUNT===========================
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

def get_group_list(request):
    group = Group.objects.all()
    return render(request, 'account/add.html',{'group': group})

# class add_account(LoginRequiredMixin, View):
#     login_url = '/login/'      
#     def post(self, request):   
#         if request.method =="POST":
#             group = request.POST['group']
#             username = request.POST['username']
#             email = request.POST['email']
#             password = request.POST['password']
          
#             group = Group.objects.get(id=group)
#             account = User.objects.create(groups=group,
#                                         username = username,
#                                         email = email,
#                                         password = password)
#             account.save()
#             return redirect('account/index.html')
#         else:
#             return render(request, 'common/error.html')

def add_account(request):
    form = AddUserForm()
    if request.method == 'POST':
        form = AddUserForm(request.POST)
        if form.is_valid():
            # form.save()
            # user = form.save()
            # group = Group.objects.get(name='Manager')
            # group.user_set.add(user)
            g = Group.objects.get(name='Manager')
            users = form.save()
            g.user_set.add(users)
            return redirect('account_list')
        else:
            form = AddUserForm()
    return render(request, 'account/add.html', {'form': form})