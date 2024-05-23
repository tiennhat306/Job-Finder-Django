from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader
from candidate.models import Candidate
from common.utils.hash import hashing, verifying

def login(request):
    if request.method == 'POST':
        email = request.POST['email']
        password = request.POST['password']
        candidate = Candidate.objects.filter(email=email).first()

        if not candidate or not verifying(candidate.password, password):
            print('Invalid email or password')
            return render(request, 'login.html', {'error': 'Invalid email or password'})
        
        if not candidate.token:
            candidate.token = hashing(email)
            candidate.save()
        response = HttpResponseRedirect('/')
        # response = HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))
        response.set_cookie('cookie', candidate.token)
        response.set_cookie('email', candidate.email)
        response.set_cookie('name', candidate.name)
        response.set_cookie('id', str(candidate.id))
        response.set_cookie('role', 'candidate')
        response.set_cookie('avatar', candidate.avatar)
        return response
    elif request.method == 'GET':
        return render(request, 'login.html')
    
def signup(request):
    if request.method == 'POST':
        email = request.POST['email']
        password = request.POST['password']
        name = request.POST['name']
        avatar = request.POST['avatar']
        candidate = Candidate.objects.filter(email=email).first()
        
        if candidate:
            return render(request, 'signup.html', {'error': 'Email already exists'})
        
        candidate = Candidate(email=email, password=password, name=name, avatar=avatar)
        candidate.save()
        
        response = HttpResponseRedirect('/login')
        response.set_cookie('email', email)
        response.set_cookie('name', name)
        response.set_cookie('id', str(candidate.id))
        response.set_cookie('role', 'candidate')
        response.set_cookie('avatar', avatar)
        return response
    elif request.method == 'GET':
        return render(request, 'signup.html')
    
def logout(request):
    response = HttpResponseRedirect('/login')
    response.delete_cookie('cookie')
    response.delete_cookie('email')
    response.delete_cookie('name')
    response.delete_cookie('id')
    response.delete_cookie('role')
    response.delete_cookie('avatar')
    return response

def another_login(request):
    template = loader.get_template('another_login.html')
    context = {}
    return HttpResponse(template.render(context, request))
    
