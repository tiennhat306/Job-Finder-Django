from django.urls import path
from .views import views, auth

urlpatterns = [
    path('', views.home, name='employer-home'),
    path('login/', auth.login, name='employer-login'),
    path('logout/', auth.logout, name='employer-logout'),
    path('add-job-stage-1/', views.add_job_stage_1, name='add-job-stage-1'),
    path('add-job-stage-2/', views.add_job_stage_2, name='add-job-stage-2'),
    path('add-job-stage-3/', views.add_job_stage_3, name='add-job-stage-3'),
    path('add-job-stage-4/', views.add_job_stage_4, name='add-job-stage-4'),
    path('cv/', views.cv, name='employer-cv'),
    path('cv/<int:id>', views.cv_detail, name='cv-detail'),
    
]