from django.http import JsonResponse
from django.core import serializers
from django.shortcuts import render, get_object_or_404, redirect
from blog.models import Location, Comment
from blog.forms import CommentForm
from django.http import HttpResponseRedirect
from django.db.models import Q
from django.views.generic import ListView, DetailView
from django.contrib import messages


# Create your views here.
class LocationListView(ListView):
    queryset = Location.objects.all().order_by("-date")
    template_name = 'location/location.html'
    context_object_name = 'Locations'
    paginate_by = 4
    
# def search(self):
#     if 'q' in self.request.GET:
#         q = self.request.GET.get['q']
#         multiple_q = Q(Q(city__icontains=q) | Q(district__icontains=q))
#         locations = Location.objects.filter(multiple_q)
#     else:
#         locations = {'locations': Location.objects.all().order_by("-date")}
#         return locations
def search(request):
    if 'q' in request.GET:
        q = request.GET['q']
        if q:
            locations = Location.objects.order_by('-date').filter(Q(Q(city__icontains=q) | Q(distric__icontains=q) | Q(wardcommune__icontains=q) | Q(address__icontains=q) | Q(name__icontains=q) ))
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
            return HttpResponseRedirect(request.path)
            messages.success(request, ' Cảm ơn bạn đã bình luận')
    else:
        form = CommentForm()
    return render(request, 'location/detaillocation.html', {"detaillocation": detaillocation, "form":form})


def edit_review(request, pk, review_id):
    detaillocation = Location.objects.get(pk=pk)
    review = Comment.objects.get(detaillocation=detaillocation, id=review_id)
    if request.user == review.author:
        if request.method == "POST":
            form = CommentForm(request.POST,instance=review)
            if form.is_valid():
                data = form.save(commit=False)
                if (float(data.rating) > 5) or (float(data.rating) < 0):
                    error="Vui lòng chọn từ 1 đến 5"
                    return render(request, 'location/editreview.html', {"error": error, "form":form})
                else:
                    data.save()
                    return HttpResponseRedirect(request.path)
        else:
            form = CommentForm(instance=review)
            return render(request, 'location/editreview.html', { "form":form})
    else:
        return HttpResponseRedirect(request.path)
    
def delete_review(request, pk, review_id):
    detaillocation = Location.objects.get(pk=pk)
    review = Comment.objects.get(detaillocation=detaillocation, id=review_id)
    if request.user == review.author:
        review.delete()
        return HttpResponseRedirect(request.path)