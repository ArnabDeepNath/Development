from django.contrib import admin
from django.urls import path
from core.views import index , contact , profiles

urlpatterns = [
    path("admin/", admin.site.urls),
    path("" ,index),
    path("contact/" , contact , name='contact'),
    path("profile/" , profiles , name='profile' )
]
