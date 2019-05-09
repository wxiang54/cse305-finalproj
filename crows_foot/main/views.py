from django.shortcuts import render
from django.http import HttpResponse
from .db_util import db_util

# Create your views here.
def home(request):
    #return HttpResponse("hello")
    return render(request, "homepage.html")

def about(request):
    return render(request, "about.html")

def cart(request):
    return render(request, "cart.html")

def login(request):
    return render(request, "login.html")

def orders(request):
    return render(request, "orders.html")

def settings(request):
    return render(request, "settings.html")
