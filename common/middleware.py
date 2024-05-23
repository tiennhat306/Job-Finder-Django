from queue import Full
from django.shortcuts import render
from candidate.models import Candidate
from admin.models import Admin
from employer.models import Employer

class AuthMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
    def __call__(self, request):
        if request.path.startswith(('/login', '/register', '/logout', '/another-login', '/employer/login', '/admin/login', '/employer/logout', '/admin/logout', '/job-detail', '/find-job', '/404')) or request.path == '' or request.path == '/':
            response = self.get_response(request)
            return response
        cookie_name = 'cookie'
        if cookie_name not in request.COOKIES:
            if request.path.startswith('/admin'):
                return render(request, 'another_login.html', {
                    'message': 'Phiên đăng nhập đã hết hạn. Bạn cần đăng nhập với vai trò Quản trị viên để truy cập trang này.'
                })
            elif request.path.startswith('/employer'):
                return render(request, 'another_login.html', {
                    'message': 'Phiên đăng nhập đã hết hạn. Bạn cần đăng nhập với vai trò Nhà tuyển dụng để truy cập trang này.'
                })
            else:
                # response = self.get_response(request)
                # return response
                return render(request, '404.html', {
                    'message': 'Phiên đăng nhập đã hết hạn. Bạn cần đăng nhập với vai trò Nhà tuyển dụng để truy cập trang này.'
                })
        cookie = request.COOKIES[cookie_name]
        admin = Admin.objects.filter(token=cookie).first()
        candidate = Candidate.objects.filter(token=cookie).first()
        employer = Employer.objects.filter(token=cookie).first()

        # if request path is /admin or /admin/*
        if request.path.startswith('/admin'):
            if not admin:
                return render(request, 'another_login.html', {
                    'message': 'Phiên đăng nhập đã hết hạn. Bạn cần đăng nhập với vai trò Quản trị viên để truy cập trang này.'
                })
        elif request.path.startswith('/employer'):
            if not employer:
                return render(request, 'another_login.html', {
                    'message': 'Phiên đăng nhập đã hết hạn. Bạn cần đăng nhập với vai trò Nhà tuyển dụng để truy cập trang này.'
                })
        else:
            if not candidate:
                return render(request, 'login.html', {
                    'message': 'Phiên đăng nhập đã hết hạn. Bạn cần đăng nhập với vai trò Ứng viên để truy cập trang này.'
                })
        request.candidate = candidate
        request.admin = admin
        request.employer = employer
        response = self.get_response(request)
        return response