from django.shortcuts import render
from django.http import HttpResponse
from .db_util import db_util
from .forms import RegisterForm, LoginForm


def test(request):
    print(db_util.search_itemstock())
    return HttpResponse("test")

# Create your views here.
def home(request):
    return render(request, "homepage.html")

def about(request):
    return render(request, "about.html")

def cart(request):
    return render(request, "cart.html")

def login(request):
    if request.method == 'POST':
        #< check which action it was >
        register_form = RegisterForm(request.POST)
        login_form = LoginForm()
        if register_form.is_valid():
            pass
    else:
        register_form = RegisterForm()
        login_form = LoginForm()
    return render(request, "login.html", {'register_form': register_form, 'login_form': login_form})

def orders(request):
    return render(request, "orders.html")

def settings(request):
    return render(request, "settings.html")

def item(request):
    return render(request, "item.html")
