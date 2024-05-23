from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader

from candidate.models import Candidate
from employer.models import Career, City, Employer, JobApplication, JobBoard, CareerGroup

from django.db.models import Count, Sum
from django.utils import timezone
from django.db.models import Q


def home(request):
    # template = loader.get_template('index.html')
    # cities = City.objects.all()
    # careers = Career.objects.all()
    # top_employers = get_top_employers()
    # jobboards = get_all_jobboards()

    # context = {
    #     'cities': cities,
    #     'careers': careers,
    #     'top_employers': top_employers,
    #     'jobboards': jobboards
    # }

    # return HttpResponse(template.render(context, request))
    if request.method == 'GET':
        search = request.GET.get('search') if request.GET.get('search') else ''
        status = int(request.GET.get('selected_status')) if request.GET.get('selected_status') else 0
        index = int(request.GET.get('index')) if request.GET.get('index') else 1

        employer_id = request.COOKIES.get('id')

        print('now', timezone.now())

        jobboards = get_my_job_board_list(employer_id, search, status)

        print('len(jobboards):', len(jobboards))
        
        end_page = len(jobboards) / 5
        if len(jobboards) % 5 != 0:
            end_page += 1

        # num_jobs = len(jobboards)
        job_list = jobboards[int(index) * 5 - 5:int(index) * 5]
        # job_list = []
        # for job_board in job_board_paging:
        #     job_list.append({
        #         'id': job_board.id,
        #         'title': job_board.title,
        #         'logo': job_board.employer.logo,
        #         'address': job_board.address,
        #         'type': job_board.get_job_type_display(),
        #         'exp_date': job_board.expiration_date,
        #     })

        # cities = City.objects.all()
        # careers = Career.objects.all()

        print('len(job_list):', len(job_list))
        
        this_month_jobboards = JobBoard.objects.filter(employer_id=employer_id, posting_date__month=timezone.now().month).count()
        last_month_jobboards = JobBoard.objects.filter(employer_id=employer_id, posting_date__month=timezone.now().month - 1).count()
        diffecence_percent = float(this_month_jobboards - last_month_jobboards) / last_month_jobboards * 100 if last_month_jobboards != 0 else 0
        # print('diffecence_percent:', diffecence_percent)
        this_quarter_jobboards = JobBoard.objects.filter(employer_id=employer_id, posting_date__month__in=[timezone.now().month, timezone.now().month - 1, timezone.now().month - 2]).count()
        last_quarter_jobboards = JobBoard.objects.filter(employer_id=employer_id, posting_date__month__in=[timezone.now().month - 3, timezone.now().month - 4, timezone.now().month - 5]).count()
        # diffecence_percent = float(this_quarter_jobboards - last_quarter_jobboards) / last_quarter_jobboards * 100 if last_quarter_jobboards != 0 else 0

        context = {
            'job_list': job_list,
            # 'num_jobs': num_jobs,
            # 'cities': cities,
            # 'careers': careers,
            'end_page': range(1, int(end_page) + 1),
            'index': index if index else 1,
            'search': search if search else '',
            'selected_status': status if status else 0,
            'this_month_jobboards': this_month_jobboards,
            'last_month_jobboards': last_month_jobboards,
            'diffecence_percent': diffecence_percent,
            'this_quarter_jobboards': this_quarter_jobboards,
        }
        
        template = loader.get_template('index_employer.html',)
        return HttpResponse(template.render(context, request))
    

def add_job_stage_1(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        code = request.POST.get('code')
        company_name = request.POST.get('company_name')
        company_size = request.POST.get('company_size')
        company_description = request.POST.get('company_description')
        website = request.POST.get('website')

        cities = City.objects.all()
        careers = Career.objects.all()

        context = {
            'cities': cities,
            'careers': careers,
        }

        print('context', context)
        template = loader.get_template('stage2.html')

        # save to cookie
        response = HttpResponse(template.render(context, request))
        request.session['stage1_title'] = title
        request.session['stage1_code'] = code
        request.session['stage1_company_name'] = company_name
        request.session['stage1_company_size'] = company_size
        request.session['stage1_company_description'] = company_description
        request.session['stage1_website'] = website

        return response
    
    else:
        context = {
        }
        template = loader.get_template('stage1.html')
        return HttpResponse(template.render(context, request))
    
def add_job_stage_2(request):
    if request.method == 'POST':
        career = request.POST.get('career')
        city = request.POST.get('city')
        address = request.POST.get('address')
        job_type = request.POST.get('job_type')
        job_level = request.POST.get('job_level')
        salary_type = request.POST.get('salary_type')
        salary_from = request.POST.get('salary_from')
        salary_to = request.POST.get('salary_to')
        age_type = request.POST.get('age_type')
        age_from = request.POST.get('age_from')
        age_to = request.POST.get('age_to')

        quantity = request.POST.get('quantity')
        gender_type = request.POST.get('gender_type')

        job_description = request.POST.get('job_description')
        qualification = request.POST.get('qualification')
        years_of_experience = request.POST.get('years_of_experience')
        requirements = request.POST.get('requirements')
        benefits = request.POST.get('benefits')


        template = loader.get_template('stage3.html')
        # save to cookie
        response = HttpResponse(template.render(request=request))
        request.session['stage2_career'] = career
        request.session['stage2_city'] = city
        request.session['stage2_address'] = address
        request.session['stage2_job_type'] = job_type
        request.session['stage2_job_level'] = job_level
        request.session['stage2_salary_type'] = salary_type
        request.session['stage2_salary_from'] = salary_from
        request.session['stage2_salary_to'] = salary_to
        request.session['stage2_age_type'] = age_type
        request.session['stage2_age_from'] = age_from
        request.session['stage2_age_to'] = age_to
        request.session['stage2_quantity'] = quantity
        request.session['stage2_gender_type'] = gender_type
        request.session['stage2_job_description'] = job_description
        request.session['stage2_qualification'] = qualification
        request.session['stage2_years_of_experience'] = years_of_experience
        request.session['stage2_requirements'] = requirements
        request.session['stage2_benefits'] = benefits

        return  response
    
    else:
        cities = City.objects.all()
        careers = Career.objects.all()

        context = {
            'cities': cities,
            'careers': careers,
        }

        template = loader.get_template('stage2.html')
        return HttpResponse(template.render(context, request))
    
def add_job_stage_3(request):
    if request.method == 'POST':
        contact_name = request.POST.get('contact_name')
        contact_number = request.POST.get('contact_number')
        contact_email = request.POST.get('contact_email')
        contact_address = request.POST.get('contact_address')

        template = loader.get_template('stage4.html')
        # save to cookie
        response = HttpResponse(template.render(request=request))
        request.session['stage3_contact_name'] = contact_name
        request.session['stage3_contact_number'] = contact_number
        request.session['stage3_contact_email'] = contact_email
        request.session['stage3_contact_address'] = contact_address

        return response
    
    else:
        context = {
        }
        template = loader.get_template('stage3.html')
        return HttpResponse(template.render(context, request))
    
def add_job_stage_4(request):
    if request.method == 'POST':
        posting_date = request.POST.get('posting_date')
        expiration_date = request.POST.get('expiration_date')

        # save to database
        employer_id = request.COOKIES.get('id')

        job_board = JobBoard(
            title=request.session.get('stage1_title') if request.session.get('stage1_title') else '',
            code=request.session.get('stage1_code') if request.session.get('stage1_code') else '',
            company_name=request.session.get('stage1_company_name') if request.session.get('stage1_company_name') else '',
            company_size=int(request.session.get('stage1_company_size')) if request.session.get('stage1_company_size') else 0,
            company_description=request.session.get('stage1_company_description') if request.session.get('stage1_company_description') else '',
            website=request.session.get('stage1_website') if request.session.get('stage1_website') else '',
            city_id=int(request.session.get('stage2_city')) if request.session.get('stage2_city') else 0,
            address=request.session.get('stage2_address') if request.session.get('stage2_address') else '',
            job_type=int(request.session.get('stage2_job_type')) if request.session.get('stage2_job_type') else 1,
            job_level=int(request.session.get('stage2_job_level')) if request.session.get('stage2_job_level') else 1,
            salary_type=int(request.session.get('stage2_salary_type')) if request.session.get('stage2_salary_type') else 4,
            salary_from=float(request.session.get('stage2_salary_from')) if request.session.get('stage2_salary_from') else 0,
            salary_to=float(request.session.get('stage2_salary_to')) if request.session.get('stage2_salary_to') else 0,
            age_type=int(request.session.get('stage2_age_type')) if request.session.get('stage2_age_type') else 1,
            age_from=int(request.session.get('stage2_age_from')) if request.session.get('stage2_age_from') else 0,
            age_to=int(request.session.get('stage2_age_to')) if request.session.get('stage2_age_to') else 0,
            quantity=int(request.session.get('stage2_quantity')) if request.session.get('stage2_quantity') else 0,
            gender_type=int(request.session.get('stage2_gender_type')) if request.session.get('stage2_gender_type') else 1,
            job_description=request.session.get('stage2_job_description') if request.session.get('stage2_job_description') else '',
            qualification=int(request.session.get('stage2_qualification')) if request.session.get('stage2_qualification') else 1,
            years_of_experience=int(request.session.get('stage2_years_of_experience')) if request.session.get('stage2_years_of_experience') else 1,
            requirements=request.session.get('stage2_requirements') if request.session.get('stage2_requirements') else '',
            benefits=request.session.get('stage2_benefits') if request.session.get('stage2_benefits') else '',
            contact_name=request.session.get('stage3_contact_name') if request.session.get('stage3_contact_name') else '',
            contact_number=request.session.get('stage3_contact_number') if request.session.get('stage3_contact_number') else '',
            contact_email=request.session.get('stage3_contact_email') if request.session.get('stage3_contact_email') else '',
            contact_address=request.session.get('stage3_contact_address') if request.session.get('stage3_contact_address') else '',
            posting_date=posting_date,
            expiration_date=expiration_date,
            status=1,
            views=0,
            employer_id=employer_id,
        )
        job_board.save()

        # save career group
        career_group = CareerGroup(
            job_board_id=job_board.id,
            career_id=int(request.session.get('stage2_career')) if request.session.get('stage2_career') else 0,
        )

        career_group.save()

        print('jobboard:', job_board)
        print('careergroup:', career_group)

        # delete session
        request.session.flush()

        response = HttpResponseRedirect('/employer/')
        return response
    else:
        context = {
        }
        template = loader.get_template('stage4.html')
        return HttpResponse(template.render(context, request))


def cv(request):
    job_board_id = int(request.GET.get('jb_id', 0))
    status = int(request.GET.get('status', 0))

    employer_id = request.COOKIES.get('id')

    job_boards = JobBoard.objects.filter(
        employer_id=employer_id,
    ).order_by('-posting_date')

    job_applications = JobApplication.objects.filter(
        Q(job_board__employer_id=employer_id) if employer_id else Q(),
        Q(job_board_id=job_board_id) if job_board_id > 0 else Q(),
        Q(status=status) if status > 0 else Q()
    ).order_by('-submission_date')

    list_title = []
    sum_views = 0
    for job_board in job_boards:
        sum_views += job_board.views
        jb = {
            'id': job_board.id,
            'title': job_board.title,
        }
        list_title.append(jb)

    no_of_applicants = job_applications.count()

    job_application_list = []
    for job_application in job_applications:
        job_application_list.append({
            'id': job_application.id,
            'title': job_application.job_board.title,
            'name': job_application.name,
            'phone_number': job_application.phone_number,
            'email': job_application.email,
            'cv': job_application.cv,
            'status': job_application.status,
            'submission_date': job_application.submission_date,
        })

    

    # if jb_id == 0:
    #     if list_title.count() != 0:
    #         list_cv_info = job_board_bo.getInfoByJBId(list_title.first().id)
    #         if len(list_cv_info) != 0:
    #             post_day = list_cv_info[-1].publishDay
    #             list_cv_data = job_board_bo.getDataCV(list_title.first().id, 0, 0, post_day)
    # else:
    #     list_cv_info = job_board_bo.getInfoByJBId(id)
    #     if len(list_cv_info) != 0:
    #         post_day = list_cv_info[-1].publishDay
    #         list_cv_data = job_board_bo.getDataCV(id, status, range, post_day)

    context = {
        'list_title': list_title,
        'no_of_applicants': no_of_applicants,
        'sum_views': sum_views,
        'job_application_list': job_application_list,
    }

    # return render(request, 'employer/cvManagement.html', context)
    template = loader.get_template('cv_management.html')
    return HttpResponse(template.render(context, request))

def cv_detail(request, id):
    if request.method == 'GET':
        job_application = JobApplication.objects.get(id=id)

        context = {
            'id': job_application.id,
            'title': job_application.job_board.title,
            'name': job_application.name,
            'phone_number': job_application.phone_number,
            'email': job_application.email,
            'cv': job_application.cv,
            'file_name': job_application.cv.split('/')[-1],
            'status': job_application.status,
            'submission_date': job_application.submission_date,
        }

        template = loader.get_template('cv_detail.html')
        return HttpResponse(template.render(context, request))
    
    elif request.method == 'POST':
        status = request.POST.get('status')
        job_application = JobApplication.objects.get(id=id)
        job_application.status = status
        job_application.save()

        return redirect('/employer/cv/')

def get_my_job_board_list(employer_id, search, status):
    if status < 4:
        job_boards = JobBoard.objects.filter(
            Q(employer_id=employer_id) if employer_id else Q(),
            Q(title__icontains=search) if search != '' else Q(),
            Q(status=status) if status > 0 else Q()
        ).annotate(
            no_of_applicants=Count('jobapplication')
        ).order_by('-posting_date')
    elif status == 4:  # real status = 2 but posting date > now()
        job_boards = JobBoard.objects.filter(
            employer_id=employer_id,
            title__icontains=search,
            status=2,
            posting_date__gt=timezone.now().date()
        ).annotate(
            no_of_applicants=Count('jobapplication')
        ).order_by('-posting_date')
    elif status == 5:  # real status = 2 but expiration date < now()
        job_boards = JobBoard.objects.filter(
            employer_id=employer_id,
            title__icontains=search,
            status=2,
            expiration_date__lt=timezone.now().date()
        ).annotate(
            no_of_applicants=Count('jobapplication')
        ).order_by('-posting_date')

    my_job_board_list = []
    for job_board in job_boards:
        no_of_applicants = JobApplication.objects.filter(job_board_id=job_board.id).count()

        my_job_board = {
            'id': job_board.id,
            'title': job_board.title,
            'status': job_board.status,
            'no_of_applicants': no_of_applicants,
            'views': job_board.views,
            'posting_date': job_board.posting_date,
            'expiration_date': job_board.expiration_date,
        }
        if my_job_board['status'] == 2:
            if job_board.posting_date > timezone.now().date():
                my_job_board['status'] = 4
            elif job_board.expiration_date < timezone.now().date():
                my_job_board['status'] = 5
        my_job_board_list.append(my_job_board)

    return my_job_board_list