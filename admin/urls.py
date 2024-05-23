from django.urls import path
from .views import views, auth

urlpatterns = [
    path('', views.home, name='admin-home'),
    path('login/', auth.login, name='admin-login'),
    path('logout/', auth.logout, name='admin-logout'),
    path('jobboards/update/<int:id>', views.update_jobboard, name='admin-update-jobboard'),
]