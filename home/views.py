from urllib import response
from django.shortcuts import render
from django.http import HttpResponse
from .forms import ResistrationForm
from django.http import HttpResponseRedirect
# Create your views here.
def index(request):
    return render(request, 'pages/home.html')
def contact(request):
    return render(request, 'pages/contact.html')
def register(request):
    form = ResistrationForm()
    if request.method == 'POST':
        form = ResistrationForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect('/')
    return render(request, 'pages/register.html', {'form': form})
def error(request):
    return render(request, 'pages/error.html')