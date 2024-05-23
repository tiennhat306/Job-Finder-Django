from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader
from employer.models import Employer
from common.utils.hash import hashing, verifying

def login(request):
    if request.method == 'POST':
        username = request.POST['email']
        password = request.POST['password']
        employer = Employer.objects.filter(username=username).first()

        print('employer', employer.password)

        if not employer or not verifying(employer.password, password):
            print('Invalid email or password')
            return render(request, 'login.html', {'error': 'Invalid email or password'})
        
        if not employer.token:
            employer.token = hashing(username)
            employer.save()

        print('hahah', employer.token)
        
        response = HttpResponseRedirect('/employer/')
        response.set_cookie('cookie', employer.token)
        response.set_cookie('username', employer.username)
        response.set_cookie('company_name', employer.company_name)
        response.set_cookie('id', str(employer.id))
        response.set_cookie('role', 'employer')
        response.set_cookie('logo', employer.logo)

        print('employer login')
        print(employer.token)

        return response
    elif request.method == 'GET':
        return render(request, '_')
    
def logout(request):
    response = HttpResponseRedirect('/another-login')
    response.delete_cookie('cookie')
    response.delete_cookie('username')
    response.delete_cookie('company_name')
    response.delete_cookie('id')
    response.delete_cookie('role')
    response.delete_cookie('logo')
    return response
    
