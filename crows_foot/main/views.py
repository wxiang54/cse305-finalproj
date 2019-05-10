from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib import messages
from django import forms
from .db_util import db_util
from .forms import RegisterForm, LoginForm


def test(request):
    print(db_util.search_itemstock())
    return HttpResponse("test")

# Create your views here.
def home(request):
    itemstocks = db_util.search_itemstock()
    categories = db_util.get_categories()
    return render(request, "homepage.html", {'itemstocks': itemstocks, 'categories': categories})

def about(request):
    return render(request, "about.html")

def cart(request):
    return render(request, "cart.html")

def login(request):
    if request.method == 'POST':
        action = request.POST.get("action")
        if action == "register":
            register_form = RegisterForm(request.POST)
            login_form = LoginForm()
            if register_form.is_valid():
                print(register_form.cleaned_data)
                if register_form.cleaned_data.get("password") != register_form.cleaned_data.get("rpassword"):
                    register_form.add_error("rpassword", forms.ValidationError('Passwords do not match.'))
                    #del register_form.cleaned_data['rpassword']
                else:
                    if db_util.insert_customer(register_form.cleaned_data) != 0:
                        # unknown error
                        print("error oh no!")
                    else:
                        # customer inserted: redirect to homepage
                        messages.success(request, "Registration successful. Welcome to the Crow's Foot.")
                        print("successful registration")
                        return redirect('/')

        else:   # assume action is login
            register_form = RegisterForm()
            login_form = LoginForm(request.POST)
            if login_form.is_valid():
                if db_util.authenticate_customer(login_form.cleaned_data):
                    print("auth success")
                    messages.success(request, "Login successful. Welcome back.")
                    return redirect('/')
                else:
                    print("auth fail")
                    login_form.add_error("password", forms.ValidationError('Password incorrect.'))
                    #del register_form.cleaned_data['password']
            else:
                print("invalid form")

    else:   #for get requests, reset the forms
        register_form = RegisterForm()
        login_form = LoginForm()
    return render(request, "login.html", {'register_form': register_form, 'login_form': login_form})

def orders(request):
    return render(request, "orders.html")

def settings(request):
    return render(request, "settings.html")

def item(request, stock_id):
    itemstock_info = db_util.get_itemstock_info(stock_id)
    #print(itemstock_info)
    return render(request, "item.html", {'itemstock': itemstock_info})
