from django import forms
from localflavor.us.forms import USStateField, USZipCodeField

class RegisterForm(forms.Form):
    email = forms.EmailField(label="Email", max_length=255)
    fname = forms.CharField(label="First name", max_length=50)
    lname = forms.CharField(label="Last name", max_length=50)
    password = forms.CharField(label="Password", widget=forms.PasswordInput, max_length=100)
    rpassword = forms.CharField(label="Confirm password", widget=forms.PasswordInput, max_length=100)
    street = forms.CharField(label="Street address", max_length=128)
    city = forms.CharField(label="City", max_length=64)
    state = USStateField(label="State")
    zip = USZipCodeField(label="Zip", max_length=5)
    action = forms.CharField(widget=forms.HiddenInput())
    action.initial = "register"

class LoginForm(forms.Form):
    email = forms.EmailField(label="Email", max_length=255)
    password = forms.CharField(label="Password", widget=forms.PasswordInput)
    action = forms.CharField(widget=forms.HiddenInput())
    action.initial = "login"
