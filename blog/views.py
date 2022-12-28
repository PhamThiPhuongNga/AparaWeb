from django.http import JsonResponse
from django.core import serializers
from django.core.paginator import Paginator
from django.shortcuts import render, get_object_or_404, redirect
from blog.models import Location, Comment, Rating, Images, Category
from blog.forms import CommentForm, RatingForm
from django.http import HttpResponseRedirect
from django.db.models import Q
from django.views.generic import DetailView, ListView
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.detail import SingleObjectMixin
from history.mixins import ObjectViewMixin

def locationList(request):
    comment = Location.objects.filter().order_by("-date")
    category = Category.objects.all()
    paginator = Paginator(comment, 8)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'location/location.html',{'page_obj': page_obj, 'category':category})

def search(request):   
    if 'name' in request.GET:
        name = request.GET['name']
        locations = Location.objects.order_by('-date').filter(name__icontains=name)
        location_count = locations.count()
        
    elif 'city' in request.GET:
        city = request.GET['city']
        locations = Location.objects.order_by('-date').filter(city=city)
        location_count = locations.count()   
    
    if 'name' and 'city' in request.GET:
        name = request.GET['name']
        city = request.GET['city']
        locations = Location.objects.order_by('-date').filter(name__icontains=name,city=city)
        location_count = locations.count()   
           
    elif 'name' and 'city' and 'qdistrict' in request.GET:
        name = request.GET['name']
        city = request.GET['city']
        qdistrict = request.GET['qdistrict']
        locations = Location.objects.order_by('-date').filter(name__icontains=name,city=city,district=qdistrict)
        location_count = locations.count()
    
    elif 'name' and 'city' and 'qdistrict' and 'qward' in request.GET:
        name = request.GET['name']
        qdistrict = request.GET['qdistrict']
        qward = request.GET['qward']
        city = request.GET['city'] 
        locations = Location.objects.order_by('-date').filter(name__icontains=name,city=city,district=qdistrict, wardcommune=qward)
        location_count = locations.count() 
                            
    if 'city' and 'qdistrict' in request.GET:
        city = request.GET['city']
        qdistrict = request.GET['qdistrict']
        locations = Location.objects.order_by('-date').filter(city=city,district=qdistrict)
        location_count = locations.count()
            
    if 'city' and 'qdistrict' and 'qward' in request.GET:
        qdistrict = request.GET['qdistrict']
        qward = request.GET['qward']
        city = request.GET['city'] 
        locations = Location.objects.order_by('-date').filter(city=city,district=qdistrict, wardcommune=qward)
        location_count = locations.count()   
    
    #======= city và code 
    elif 'city' and 'qcost'  in request.GET: 
        qcost = request.GET['qcost'] 
        city = request.GET['city']
        locations = Location.objects.order_by('-date').filter(city=city,costmax__lte = qcost)
        location_count = locations.count() 
               
    if 'qcost' in request.GET: 
        qcost = request.GET['qcost']
        locations = Location.objects.order_by('-date').filter(Q(Q(costmax__lte = qcost)))
        location_count = locations.count()  
            
    if 'name' and 'qcost'  in request.GET: 
        name = request.GET['name']
        qcost = request.GET['qcost'] 
        locations = Location.objects.order_by('-date').filter(name__icontains=name,costmax__lte = qcost)
        location_count = locations.count()
        
    elif 'name' and 'city' and 'qcost' in request.GET: 
        name = request.GET['name'] 
        city = request.GET['city']
        qcost = request.GET['qcost'] 
        locations = Location.objects.order_by('-date').filter(name__icontains=name,city=city,costmax__lte = qcost)
        location_count = locations.count()
        
    elif 'name' and 'city' and 'qdistrict' and 'qcost' in request.GET: 
        name = request.GET['name'] 
        city = request.GET['city']
        qdistrict = request.GET['qdistrict']
        qcost = request.GET['qcost']
        locations = Location.objects.order_by('-date').filter(name__icontains=name,city=city,costmax__lte = qcost,district=qdistrict)
        location_count = locations.count() 
      
    elif 'name' and 'city' and 'qdistrict' and 'qward' and 'qcost' in request.GET: 
        name = request.GET['name'] 
        city = request.GET['city']
        qdistrict = request.GET['qdistrict']
        qcost = request.GET['qcost']
        qward = request.GET['qward']
        locations = Location.objects.order_by('-date').filter(name__icontains=name,city=city,costmax__lte = qcost,district=qdistrict, wardcommune=qward)
        location_count = locations.count() 
        
    context = {
        'locations': locations,
        'location_count': location_count,
    }
    return render(request, 'location/searchlocation.html',context)
class detaillocation(ObjectViewMixin, DetailView):  
    model = Location
    template_name = 'location/detaillocation.html'
    context_object_name = 'detaillocation'
    
    def get(self,request, **kwargs):
        rateUsers = []
        detaillocation = Location.objects.get(pk=self.kwargs.get('pk'))
        categoryy = Category.objects.get(location=self.kwargs.get('pk'))
        category = Category.objects.all()
        similarLoca = Location.objects.filter(category=categoryy).order_by('-views')
        ratings = Rating.objects.filter(detaillocation=detaillocation).order_by('-date')
        print("type  la : ",type(ratings))
        print("data  la : ",ratings.values())
        for i in ratings:
            rateUsers.append(i.author)
        rateUser = request.user in rateUsers
        image = Images.objects.filter(location_id=detaillocation).order_by('-id')[:5]
        return render(self.request, 'location/detaillocation.html', {"detaillocation": detaillocation, "ratings":ratings, "image":image, "similarLoca":similarLoca,"rateUser":rateUser, "category":category})
        
    def post(self,request, **kwargs):
        rateUsers = []
        detaillocation = Location.objects.get(pk=self.kwargs.get('pk'))
        print(detaillocation)
        category = Category.objects.get(location=self.kwargs.get('pk'))
        print(category)
        similarLoca = Location.objects.filter(category=category).order_by('-views')
        print(similarLoca)
        ratings = Rating.objects.filter(detaillocation=detaillocation).order_by('-date')
        print("type  la : ",type(ratings))
        print("data  la : ",ratings.values())
        for i in ratings:
            rateUsers.append(i.author)
        rateUser = request.user in rateUsers
        image = Images.objects.filter(location_id=detaillocation).order_by('-id')[:5]
        # print(category)
        print(image)
        
        if detaillocation:
            detaillocation.views = detaillocation.views + 1
            detaillocation.save()

        if self.request.method == 'POST':
            form = CommentForm(self.request.POST,author = self.request.user,detaillocation=detaillocation )
            # form.save()
            if form.is_valid(): 
                data = form.save(commit=False) 
                data.body = self.request.POST['body']
                data.author = self.request.user
                data.detaillocation = detaillocation
                data.save() 
                messages.success(self.request, ' Cảm ơn bạn đã bình luận')
                return HttpResponseRedirect(self.request.path)
        else:
            form = CommentForm()
        if self.request.method == 'POST':
            form = RatingForm(self.request.POST,author = self.request.user,detaillocation=detaillocation )
            # form.save()
            if form.is_valid(): 
                data = form.save(commit=False) 
                data.rating = self.request.POST['rating']
                data.author = self.request.user
                data.detaillocation = detaillocation
                data.save() 
                messages.success(self.request, ' Cảm ơn bạn đã đánh giá')
                return HttpResponseRedirect(self.request.path)
        else:
            form = RatingForm()
        return render(self, 'location/detaillocation.html', {"detaillocation": detaillocation, "form":form, "ratings":ratings, "image":image, "similarLoca":similarLoca,"rateUser":rateUser})

def edit_review(request, pk, review_id):
    detaillocation = Location.objects.get(pk=pk)
    review = Comment.objects.get(detaillocation=detaillocation, id=review_id)
    if request.user == review.author:
        if request.method =="POST":
            review.body = request.POST['body']
            # review.rating = request.POST['rating']  
            review.save()
            messages.success(request, "Cập nhật thành công!")
            return redirect('/blog/location/' + str(detaillocation.id))
        return render(request, 'location/editreview.html',{"detaillocation": detaillocation, "review": review})
    
def delete_review(request, pk, review_id):
    detaillocation = Location.objects.get(pk=pk)
    review = Comment.objects.get(detaillocation=detaillocation, id=review_id)
    if request.user == review.author:
        review.delete()
        messages.success(request, "Xoá thành công!")
        return redirect('/blog/location/' + str(detaillocation.id))
    