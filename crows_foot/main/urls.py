from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name="home"),
    path('about/', views.about, name="about"),
    path('cart/', views.cart, name="cart"),
    path('login/', views.login, name="login"),
    path('orders/', views.orders, name="orders"),
    path('settings/', views.settings, name="settings"),
    path('test/', views.test, name="test"),
    path('checkout/', views.checkout, name = "checkout"),
    path('item/<stock_id>', views.item, name="item")
]
