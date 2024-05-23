from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from candidate.models import Candidate
from employer.models import Career, City, Employer, JobApplication, JobBoard, CareerGroup
from django.db.models import Count, Sum
from django.db.models import Q

import uuid
import os

def home(request):
    template = loader.get_template('index.html')
    cities = City.objects.all()
    careers = Career.objects.all()
    top_employers = get_top_employers()
    jobboards = get_all_jobboards()

    context = {
        'cities': cities,
        'careers': careers,
        'top_employers': top_employers,
        'jobboards': jobboards
    }

    return HttpResponse(template.render(context, request))

def find_job(request):
    if request.method == 'GET':
        search = request.GET.get('search_text') if request.GET.get('search_text') else ''
        location = int(request.GET.get('location')) if request.GET.get('location') else 0
        career = int(request.GET.get('career')) if request.GET.get('career') else 0
        job_type = int(request.GET.get('job_type')) if request.GET.get('job_type') else 0
        index = int(request.GET.get('index')) if request.GET.get('index') else 1

        jobboards = JobBoard.objects.filter(
            Q(title__icontains=search) if search != ''  else Q(),
            Q(employer__city_id=location) if location > 0 else Q(),
            Q(job_type=job_type) if job_type > 0 else Q(),
            Q(careergroup__career_id=career) if career > 0 else Q()
        ).distinct()

        end_page = len(jobboards) / 5
        if len(jobboards) % 5 != 0:
            end_page += 1

        num_jobs = len(jobboards)
        job_board_paging = jobboards[int(index) * 5 - 5:int(index) * 5]
        job_list = []
        for job_board in job_board_paging:
            job_list.append({
                'id': job_board.id,
                'title': job_board.title,
                'logo': job_board.employer.logo,
                'address': job_board.address,
                'type': job_board.get_job_type_display(),
                'exp_date': job_board.expiration_date,
            })

        cities = City.objects.all()
        careers = Career.objects.all()

       

        context = {
            'job_list': job_list,
            'num_jobs': num_jobs,
            'cities': cities,
            'careers': careers,
            'end_page': range(1, int(end_page) + 1),
            'index': index if index else 1,
            'search': search if search else '',
            'location_id': location if location else 0,
            'career_id': career if career else 0,
            'jobtype_id': job_type if job_type else 0,
        }
        
        template = loader.get_template('find_job.html')
        return HttpResponse(template.render(context, request))

def job_detail(request, job_id):
    job_board = JobBoard.objects.get(id=job_id)
    job_board.views += 1
    job_board.save()

    salary = ''
    job_board.salary_from = round(job_board.salary_from, 1)
    job_board.salary_to = round(job_board.salary_to, 1)
    if job_board.salary_type == 1:
        salary = 'Tối thiểu ' + str(job_board.salary_from) + ' triệu đồng/tháng'
    elif job_board.salary_type == 2:
        salary = 'Tối đa ' + str(job_board.salary_to) + ' triệu đồng/tháng'
    elif job_board.salary_type == 3:
        salary = 'Từ ' + str(job_board.salary_from) + ' đến ' + str(job_board.salary_to) + ' triệu đồng/tháng'
    else:
        salary = 'Thỏa thuận'

    age = ''
    if job_board.age_type == 1:
        age = 'Bất kỳ'
    elif job_board.age_type == 2:
        age = 'Nhỏ hơn ' + str(job_board.age_from) + ' tuổi'
    elif job_board.age_type == 3:
        age = 'Lớn hơn ' + str(job_board.age_from) + ' tuổi'
    else:
        age = 'Từ ' + str(job_board.age_from) + ' đến ' + str(job_board.age_to) + ' tuổi'

    job_detail = {
        'id': job_board.id,
        'title': job_board.title,
        'logo': job_board.employer.logo,
        'website': job_board.website,
        'company_name': job_board.company_name,
        'company_size': job_board.get_company_size_display(),
        'city_name': job_board.employer.city.name,
        'address': job_board.address,
        'job_type': job_board.get_job_type_display(),
        'job_level': job_board.get_job_level_display(),
        'salary': salary,
        'age': age,
        'gender': job_board.get_gender_type_display(),
        'job_description': job_board.job_description,
        'quantity': job_board.quantity,
        'qualification': job_board.get_qualification_display(),
        'years_of_experience': job_board.get_years_of_experience_display(),
        'requirements': job_board.requirements,
        'benefits': job_board.benefits,
        'contact_name': job_board.contact_name,
        'contact_email': job_board.contact_email,
        'contact_number': job_board.contact_number,
        'contact_address': job_board.contact_address,
        'posting_date': job_board.posting_date,
        'expiration_date': job_board.expiration_date,
        'status': job_board.get_status_display(),
        'views': job_board.views,
        'employer': job_board.employer,
    }

    template = loader.get_template('job_detail.html')
    context = {
        'jobboard': job_detail
    }

    return HttpResponse(template.render(context, request))

        
def upload_cv(request):
    if request.method == 'POST':
        cv = request.FILES['cv']
        name = request.POST['name']
        email = request.POST['email']
        phone = request.POST['phone_number']

        job_id = request.POST['job_id']
        candidate_id = request.POST['candidate_id']

        if cv and name and email and phone and job_id and candidate_id:

            uuid_code = uuid.uuid4()

            filename, extension = os.path.splitext(cv.name)
            new_filename = f'{filename}_{uuid_code}{extension}'
            # save file cv to /static/media/cv/
            
            with open(f'static/media/cv/{new_filename}', 'wb+') as destination:
                for chunk in cv.chunks():
                    destination.write(chunk)

            job_application = JobApplication(
                name=name,
                phone_number=phone,
                email=email,
                cv='/static/media/cv/' + new_filename,
                job_board_id=job_id,
                candidate_id=candidate_id,
                status=1
            )
            job_application.save()

            if job_application.id > 0:
                template = loader.get_template('success_upload_cv.html')
                return HttpResponse(template.render(request=request))
            else:
                template = loader.get_template('failed_upload_cv.html')
                return HttpResponse(template.render(request=request))
            
        else:
            template = loader.get_template('failed_upload_cv.html')
            return HttpResponse(template.render(request=request))


def get_top_employers():
    top_employers = Employer.objects.annotate(
        num_jobs=Count('jobboard'),
        views=Sum('jobboard__views')
    ).order_by('-views', '-num_jobs')[:20]

    top_employer_items = []
    for employer in top_employers:
        top_employer_items.append({
            'id': employer.id,
            'company_name': employer.company_name,
            'logo': employer.logo,
            'city_name': employer.city.name,
            'num_jobs': employer.num_jobs,
            'views': employer.views
        })

    return top_employer_items

def get_all_jobboards():
    jobboards = JobBoard.objects.all()
    jobboard_items = []
    for jobboard in jobboards:
        jobboard.salary_from = round(jobboard.salary_from, 1)
        jobboard.salary_to = round(jobboard.salary_to, 1)
        salary = ''
        if jobboard.salary_type == 1:
            salary = 'Tối thiểu ' + str(jobboard.salary_from) + ' triệu đồng/tháng'
        elif jobboard.salary_type == 2:
            salary = 'Tối đa ' + str(jobboard.salary_to) + ' triệu đồng/tháng'
        elif jobboard.salary_type == 3:
            salary = 'Từ ' + str(jobboard.salary_from) + ' đến ' + str(jobboard.salary_to) + ' triệu đồng/tháng'
        else:
            salary = 'Thỏa thuận'
        jobboard_items.append({
            'id': jobboard.id,
            'title': jobboard.title,
            'logo': jobboard.employer.logo,
            'company_name': jobboard.employer.company_name,
            'city_name': jobboard.employer.city.name,
            'salary': salary,
        })

    return jobboard_items