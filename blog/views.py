from django.http import JsonResponse
from django.core import serializers
from django.shortcuts import render, get_object_or_404, redirect
from blog.models import Location, Comment
from blog.forms import CommentForm
from django.http import HttpResponseRedirect
from django.db.models import Q
from django.views.generic import ListView, DetailView
from django.contrib import messages
# import pandas as pd
# from math import sqrt
# import numpy as np
# import matplotlib.pyplot as plt
# from math import ceil


# Create your views here.
class LocationListView(ListView):
    queryset = Location.objects.all().order_by("-date")
    template_name = 'location/location.html'
    context_object_name = 'Locations'
    paginate_by = 4
    

def search(request):
    if 'q' in request.GET:
        q = request.GET['q']
        if q:
            locations = Location.objects.order_by('-date').filter(Q(Q(city__icontains=q) | Q(district=q) | Q(wardcommune__icontains=q) | Q(address__icontains=q) | Q(name__icontains=q) ))
            location_count = locations.count()
    context = {
        'locations': locations,
        'location_count': location_count,
    }
    return render(request, 'location/searchlocation.html', context)


def detaillocation(request , pk):
    detaillocation = Location.objects.get(pk=pk)
    # form = CommentForm()
    if request.method == 'POST':
        form = CommentForm(request.POST,author = request.user,detaillocation=detaillocation )
        # form.save()
        if form.is_valid(): 
            data = form.save(commit=False) 
            data.body = request.POST['body']
            data.rating = request.POST['rating']
            data.author = request.user
            data.detaillocation = detaillocation
            data.save() 
            messages.success(request, ' Cảm ơn bạn đã bình luận')
            return HttpResponseRedirect(request.path)
    else:
        form = CommentForm()
    return render(request, 'location/detaillocation.html', {"detaillocation": detaillocation, "form":form})


def edit_review(request, pk, review_id):
    detaillocation = Location.objects.get(pk=pk)
    review = Comment.objects.get(detaillocation=detaillocation, id=review_id)
    if request.user == review.author:
        if request.method =="POST":
            review.body = request.POST['body']
            review.rating = request.POST['rating']  
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
    


