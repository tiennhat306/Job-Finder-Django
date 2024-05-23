from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.template import loader

from candidate.models import Candidate
from employer.models import Career, City, Employer, JobApplication, JobBoard, CareerGroup

from django.db.models import Count, Sum
from django.utils import timezone
from django.db.models import Q

from django.views.decorators.csrf import csrf_exempt

def home(request):
    if request.method == 'GET':
        search = request.GET.get('search', '')
        status = int(request.GET.get('status', 0))
        index = int(request.GET.get('index', 1))

        all_job_boards = get_all_jobboards(search, status)

        end_page = len(all_job_boards) / 5
        if len(all_job_boards) % 5 != 0:
            end_page += 1

        all_job_boards = all_job_boards[(index - 1) * 5:index * 5]

        today_jobboards = JobBoard.objects.filter(posting_date=timezone.now().date()).count()
        pending_jobboards = JobBoard.objects.filter(status=1).count()
        current_month_jobboards = JobBoard.objects.filter(posting_date__month=timezone.now().month).count()

        context = {
            'jobboard_list': all_job_boards,
            'search': search,
            'selected_status': status,
            'index': index,
            'end_page': range(1, int(end_page) + 1),
            'today_jobboards': today_jobboards,
            'pending_jobboards': pending_jobboards,
            'current_month_jobboards': current_month_jobboards,
        }

        template = loader.get_template('index_admin.html')
        return HttpResponse(template.render(context, request))


@csrf_exempt
def update_jobboard(request, id):
    if request.method == 'POST':
        status = int(request.POST.get('status', 0))

        print('status:', status)
        if status in [1, 2, 3]:
            job_board = JobBoard.objects.get(pk=id)
            job_board.status = status
            job_board.save()
            return JsonResponse({'status': 'success'})
        else:
            return JsonResponse({'status': 'error'})
        
def get_all_jobboards(search, status):
    if status < 4:
        job_boards = JobBoard.objects.filter(
            Q(title__icontains=search) if search != '' else Q(),
            Q(status=status) if status > 0 else Q()
        ).annotate(
            no_of_applicants=Count('jobapplication')
        ).order_by('-posting_date')
    elif status == 4:  # real status = 2 but posting date > now()
        job_boards = JobBoard.objects.filter(
            title__icontains=search,
            status=2,
            posting_date__gt=timezone.now().date()
        ).annotate(
            no_of_applicants=Count('jobapplication')
        ).order_by('-posting_date')
    elif status == 5:  # real status = 2 but expiration date < now()
        job_boards = JobBoard.objects.filter(
            title__icontains=search,
            status=2,
            expiration_date__lt=timezone.now().date()
        ).annotate(
            no_of_applicants=Count('jobapplication')
        ).order_by('-posting_date')

    all_job_boards = []
    for job_board in job_boards:
        no_of_applicants = JobApplication.objects.filter(job_board_id=job_board.id).count()
        job_board_dict = {
            'id': job_board.id,
            'title': job_board.title,
            'company_name': job_board.company_name,
            'status': job_board.status,
            'no_of_applicants': no_of_applicants,
            'views': job_board.views,
            'posting_date': job_board.posting_date,
            'expiration_date': job_board.expiration_date,
            'updated_person': job_board.updated_by.name if job_board.updated_by else '',
        }
        if job_board.status == 2:
            if job_board.posting_date > timezone.now().date():
                job_board_dict['status'] = 4
            elif job_board.expiration_date < timezone.now().date():
                job_board_dict['status'] = 5
        all_job_boards.append(job_board_dict)

    return all_job_boards


