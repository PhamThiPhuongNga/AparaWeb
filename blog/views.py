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
# import pandas as pd
# from math import sqrt
# import numpy as np
# import matplotlib.pyplot as plt
# from math import ceil


# Create your views here.
# class LocationListView(ListView):
#     queryset = Location.objects.all().order_by("-date")
#     template_name = 'location/location.html'
#     context_object_name = 'Locations'
#     paginate_by = 8


def locationList(request):
    comment = Location.objects.filter().order_by("-date")
    paginator = Paginator(comment, 8)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'location/location.html',{'page_obj': page_obj})

def search(request):    
    if 'q'  in request.GET:
        q = request.GET['q']
        if q:
            locations = Location.objects.order_by('-date').filter (Q(Q(name__icontains=q)))
            location_count = locations.count() 
    if 'q' and 'qcity' in request.GET:
        q = request.GET['q']
        qcity = request.GET['qcity']
        if q and qcity:
            locations = Location.objects.order_by('-date').filter (Q(Q(name__icontains=q) and Q(city__icontains=qcity)))
            location_count = locations.count()
    if 'qcity' in request.GET:
        qcity = request.GET['qcity']
        if qcity:
            locations = Location.objects.order_by('-date').filter (Q(city__icontains=qcity))
            location_count = locations.count()
    if 'qcity' and 'qdistrict' in request.GET:
        qcity = request.GET['qcity']
        qdistrict = request.GET['qdistrict']
        if qcity and qdistrict:
            locations = Location.objects.order_by('-date').filter(Q(Q(city__icontains=qcity) and Q(district__icontains=qdistrict)))
            location_count = locations.count()
    if 'qcity' and 'qdistrict' and 'qward' in request.GET:
        qcity = request.GET['qcity']
        qdistrict = request.GET['qdistrict']
        qward = request.GET['qward']
        if qcity and qdistrict and qward:
            locations = Location.objects.order_by('-date').filter(Q(Q(city__icontains=qcity) and Q(district__icontains=qdistrict) and Q(wardcommune__icontains=qward)))
            location_count = locations.count()
    # if 'qmincost' and   in request.GET and :
    #     qmincost = request.GET['qmincost']
    #     if qmincost:
    #         locations = Location.objects.order_by('-date').filter(Q(mincost__icontains=qmincost))
    #         location_count = locations.count()
    # locationsp = Location.objects.all()
    # if 'qmaxcost'  in request.GET:       
    #     qmaxcost = request.GET['qmaxcost']
    #     if qmaxcost:
    #         locations = Location.objects.order_by('-date').filter(Q(maxcost__icontains=qmaxcost))
    #         location_count = locations.count()  
    # locationsp = Location.objects.all() 
    if 'qmincost' and 'qmaxcost'  in request.GET: 
        qmincost = request.GET['qmincost']
        qmaxcost = request.GET['qmaxcost']
        if qmaxcost and qmincost:
            locations = Location.objects.order_by('-date').filter(Q(Q(costmin__in = [qmincost,qmaxcost])))
            location_count = locations.count()   
             
    context = {
        'locations': locations,
        'location_count': location_count,
    }
    return render(request, 'location/searchlocation.html', context)
class detaillocation(ObjectViewMixin, DetailView):  
    model = Location
    template_name = 'location/detaillocation.html'
    context_object_name = 'detaillocation'
    
    def get(self,request, **kwargs):
        rateUsers = []
        detaillocation = Location.objects.get(pk=self.kwargs.get('pk'))
        print(detaillocation)
        category = Category.objects.get(location=self.kwargs.get('pk'))
        print(category)
        similarLoca = Location.objects.filter(category=category).order_by('-views')
        print(similarLoca)
        ratings = Rating.objects.filter(detaillocation=detaillocation)
        print("type  la : ",type(ratings))
        print("data  la : ",ratings.values())
        for i in ratings:
            rateUsers.append(i.author)
        rateUser = request.user in rateUsers
        image = Images.objects.filter(location_id=detaillocation).order_by('-id')[:5]
        # print(category)
        print(image)
        return render(self.request, 'location/detaillocation.html', {"detaillocation": detaillocation, "ratings":ratings, "image":image, "similarLoca":similarLoca,"rateUser":rateUser})
        
    def post(self,request, **kwargs):
        rateUsers = []
        detaillocation = Location.objects.get(pk=self.kwargs.get('pk'))
        print(detaillocation)
        category = Category.objects.get(location=self.kwargs.get('pk'))
        print(category)
        similarLoca = Location.objects.filter(category=category).order_by('-views')
        print(similarLoca)
        ratings = Rating.objects.filter(detaillocation=detaillocation)
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
                # data.rating = request.POST['rating']
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
    