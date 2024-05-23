from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader
from admin.models import Admin
from common.utils.hash import hashing, verifying

def login(request):
    if request.method == 'POST':
        email = request.POST['email']
        password = request.POST['password']
        admin = Admin.objects.filter(email=email).first()
        admin.password = hashing(password)

        if not admin or not verifying(admin.password, password):
            return render(request, 'login.html', {'error': 'Invalid email or password'})
        
        if not admin.token:
            admin.token = hashing(email)
            admin.save()
        
        response = HttpResponseRedirect('/admin/')
        response.set_cookie('cookie', admin.token)
        response.set_cookie('role', 'admin')
        response.set_cookie('email', email)
        response.set_cookie('id', str(admin.id))
        response.set_cookie('name', admin.name)
        response.set_cookie('avatar', admin.avatar)
        return response
    elif request.method == 'GET':
        return render(request, 'login.html')
    
def logout(request):
    response = HttpResponseRedirect('/another-login')
    response.delete_cookie('cookie')
    return response
    
