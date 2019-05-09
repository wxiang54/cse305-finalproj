from django import forms
from localflavor.us.forms import USStateField, USZipCodeField

class RegisterForm(forms.Form):
    email = forms.EmailField(label="Email", max_length=255)
    fname = forms.CharField(label="First name", max_length=50)
    lname = forms.CharField(label="Last name", max_length=50)
    street = forms.CharField(label="Street address", max_length=128)
    city = forms.CharField(label="City", max_length=64)
    state = USStateField(label="State")
    zip = USZipCodeField(label="Zip", max_length=5)

class LoginForm(forms.Form):
    email = forms.EmailField(label="Email", max_length=255)
    password = forms.CharField(widget=forms.PasswordInput)
