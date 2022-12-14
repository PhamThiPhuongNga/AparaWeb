from django.core.paginator import Paginator
from django.shortcuts import render, get_object_or_404, redirect
from blog.models import Location, Comment, Rating, Images, Category
from blog.forms import CommentForm, RatingForm
from django.http import HttpResponseRedirect
from django.views.generic import DetailView
from django.contrib import messages
from history.mixins import ObjectViewMixin
import json
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt

def locationList(request):
    comment = Location.objects.filter().order_by("-date")
    category = Category.objects.all()
    paginator = Paginator(comment, 8)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'location/location.html',{'page_obj': page_obj, 'category':category})

def search(request):   
    category = Category.objects.all()
    name = request.GET['name'] if 'name' in request.GET else ''
    city = request.GET['city'] if 'city' in request.GET else ''
    qdistrict = request.GET['qdistrict'] if 'qdistrict' in request.GET else ''
    qward = request.GET['qward'] if 'qward' in request.GET else ''
    qcost = request.GET['qcost'] if 'qcost' in request.GET else 300000
    
    locations = Location.objects.order_by('-views').filter(
        name__icontains=name,
        city__contains=city,
        district__contains=qdistrict, 
        wardcommune__contains=qward, 
        costmax__lte = qcost
        
    )
    location_count = locations.count()    
    
    # if 'name' in request.GET:
    #     name = request.GET['name']
    #     locations = Location.objects.order_by('-date').filter(name__icontains=name)
    #     location_count = locations.count()
        
    context = {
        'locations': locations,
        'location_count': location_count,
        'category':category,
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
        if detaillocation:
            detaillocation.views = detaillocation.views + 1
            detaillocation.save()
        for i in ratings:
            rateUsers.append(i.author)
        rateUser = request.user in rateUsers
        image = Images.objects.filter(location_id=detaillocation).order_by('-id')[:5]
        return render(self.request, 'location/detaillocation.html', {"detaillocation": detaillocation, "ratings":ratings, "image":image, "similarLoca":similarLoca,"rateUser":rateUser, "category":category})
        
    def post(self,request, **kwargs):
        rateUsers = []
        detaillocation = Location.objects.get(pk=self.kwargs.get('pk'))
        category = Category.objects.get(location=self.kwargs.get('pk'))
        similarLoca = Location.objects.filter(category=category).order_by('-views')
        ratings = Rating.objects.filter(detaillocation=detaillocation).order_by('-date')
        for i in ratings:
            rateUsers.append(i.author)
        rateUser = request.user in rateUsers
        image = Images.objects.filter(location_id=detaillocation).order_by('-id')[:5]
        
        if self.request.method == 'POST':
            form = CommentForm(self.request.POST,author = self.request.user,detaillocation=detaillocation )
            if form.is_valid(): 
                data = form.save(commit=False) 
                data.body = self.request.POST['body']
                data.author = self.request.user
                data.detaillocation = detaillocation
                data.save() 
                messages.success(self.request, ' C???m ??n b???n ???? b??nh lu???n')
                return HttpResponseRedirect(self.request.path)
        else:
            form = CommentForm()
        if self.request.method == 'POST':
            form = RatingForm(self.request.POST,author = self.request.user,detaillocation=detaillocation )
            if form.is_valid(): 
                data = form.save(commit=False) 
                data.rating = self.request.POST['rating']
                data.author = self.request.user
                data.detaillocation = detaillocation
                data.save() 
                messages.success(self.request, ' C???m ??n b???n ???? ????nh gi??')
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
            review.save()
            messages.success(request, "C???p nh???t th??nh c??ng!")
            return redirect('/blog/location/' + str(detaillocation.id))
        return render(request, 'location/editreview.html',{"detaillocation": detaillocation, "review": review})
    
def delete_review(request, pk, review_id):
    detaillocation = Location.objects.get(pk=pk)
    review = Comment.objects.get(detaillocation=detaillocation, id=review_id)
    if request.user == review.author:
        review.delete()
        messages.success(request, "Xo?? th??nh c??ng!")
        return redirect('/blog/location/' + str(detaillocation.id))
    
@csrf_exempt
def searchkeyup(request):
    valueSearch = request.POST.get('valueSearch')
    locations = Location.objects.order_by('-date').filter(
        name__icontains=valueSearch,
    )
    data = []
    for i in locations:
        data.append({
            'name':i.name,
            'id':i.id,
            'image' : i.image.url
        })
    return HttpResponse(json.dumps({'data':data}), content_type="application/json")