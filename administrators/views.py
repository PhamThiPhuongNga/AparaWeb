from urllib import response
from django.core.paginator import Paginator
from django.shortcuts import render, redirect
from django.http import HttpResponse
from blog.models import Location, Comment, Category, Images
# from .forms import ResistrationForm
from django.views.generic import ListView
from django.http import HttpResponseRedirect
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
        # form_class = uploadMultiForm
        # forms = self.get_form(form_class)
        
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
        categoryyy = Category.objects.get(id=category)
        # for f in image:
            # image = Location(image = f)
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
                                    image = image)
        location.save()
        # images = Location.objects.all()
        return redirect('/administrators/location')
    else:
        return render(request, 'common/error.html')
    
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
        
# class ImagesListView(ListView):
#     queryset = Images.objects.all().order_by("-date")
#     template_name = 'location/formimages.html'
#     context_object_name = 'i'
#     paginate_by = 10   
    
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