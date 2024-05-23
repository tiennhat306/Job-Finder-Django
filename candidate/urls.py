from django.urls import path
from .views import views, auth

urlpatterns = [
    path('', views.home, name='candidate-home'),
    path('login/', auth.login, name='candidate-login'),
    path('signup/', auth.signup, name='candidate-signup'),
    path('logout/', auth.logout, name='candidate-logout'),
    path('find-job/', views.find_job, name='find-job'),
    path('job-detail/<int:job_id>', views.job_detail, name='job-detail'),
    path('another-login/', auth.another_login, name='another-login'),
    path('upload-cv/', views.upload_cv, name='upload-cv'),
]