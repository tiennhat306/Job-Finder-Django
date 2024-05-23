from django.db import models
from admin.models import Admin
from candidate.models import Candidate

class City(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    code = models.CharField(max_length=255)

    def __str__(self):
        return self.name
    
class Career(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    description = models.TextField()

    def __str__(self):
        return self.name

class Employer(models.Model):
    COMPANY_SIZE_CHOICES = [
        (1, '<10'),
        (2, '<20'),
        (3, '<50'),
        (4, '<100'),
        (5, '<500'),
        (6, '>500'),
    ]
        
    id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=255)
    password = models.CharField(max_length=255)
    company_name = models.CharField(max_length=255)
    company_size = models.IntegerField(choices=COMPANY_SIZE_CHOICES)
    contact_name = models.CharField(max_length=255)
    contact_number = models.CharField(max_length=255)
    # city_id = models.IntegerField()  # Consider changing this to a ForeignKey if 'City' is another model
    city = models.ForeignKey(City, on_delete=models.CASCADE)
    address = models.CharField(max_length=255)
    business_license_code = models.CharField(max_length=255)
    website = models.CharField(max_length=255)
    description = models.TextField()
    # logo = models.ImageField(upload_to='logos/')
    logo = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    token = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return self.company_name

class JobBoard(models.Model):
    COMPANY_SIZE_CHOICES = [
        (1, 'Ít hơn 10'),
        (2, '10 - 24'),
        (3, '25 - 99'),
        (4, '100 - 499'),
        (5, 'Trên 500'),
    ]

    JOB_TYPE_CHOICES = [
        (1, 'Toàn thời gian'),
        (2, 'Bán thời gian'),
        (3, 'Hợp đồng'),
    ]

    JOB_LEVEL_CHOICES = [
        (1, 'Thực tập sinh'),
        (2, 'Nhân viên'),
        (3, 'Trưởng nhóm'),
        (4, 'Quản lý'),
        (5, 'Giám đốc'),
    ]

    SALARY_CHOICES = [
        (1, 'Tối thiểu'),
        (2, 'Tối đa'),
        (3, 'Từ - đến'),
        (4, 'Thỏa thuận')
    ]

    GENDER_CHOICES = [
        (1, 'Bất kỳ'),
        (2, 'Nam'),
        (3, 'Nữ'),
    ]

    AGE_CHOICES = [
        (1, 'Bất kỳ'),
        (2, 'Nhỏ hơn'),
        (3, 'Lớn hơn'),
        (4, 'Từ - đến'),
    ]


    EXPERIENCE_CHOICES = [
        (1, 'Chưa có kinh nghiệm'),
        (2, '6 tháng - 1 năm'),
        (3, '2 - 3 năm'),
        (4, '4 - 5 năm'),
        (5, 'Trên 5 năm'),
    ]

    QUALIFICATION_CHOICES = [
        (1, 'Không yêu cầu'),
        (2, 'Tốt nghiệp THPT'),
        (3, 'Có chứng chỉ nghề'),
        (4, 'Cao đẳng'),
        (5, 'Đại học'),
        (6, 'Sau đại học'),
    ]

    STATUS_CHOICES = [
        (1, 'Chưa xác nhận'),
        (2, 'Đã xác nhận'),
        (3, 'Bị từ chối'),
    ]
        
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255)
    code = models.CharField(max_length=255)
    company_name = models.CharField(max_length=255)
    company_size = models.IntegerField(choices=COMPANY_SIZE_CHOICES)
    company_description = models.TextField()
    website = models.URLField(max_length=200)
    city = models.ForeignKey(City, on_delete=models.CASCADE)
    address = models.CharField(max_length=255)
    job_type = models.IntegerField(choices=JOB_TYPE_CHOICES)
    job_level = models.IntegerField(choices=JOB_LEVEL_CHOICES)
    salary_type = models.IntegerField(choices=SALARY_CHOICES)
    salary_from = models.FloatField(null=True, blank=True)
    salary_to = models.FloatField(null=True, blank=True)
    age_type = models.IntegerField(choices=AGE_CHOICES)
    age_from = models.IntegerField(null=True, blank=True)
    age_to = models.IntegerField(null=True, blank=True)
    gender_type = models.IntegerField(choices=GENDER_CHOICES)
    job_description = models.TextField()
    quantity = models.IntegerField()
    qualification = models.IntegerField(choices=QUALIFICATION_CHOICES)
    years_of_experience = models.IntegerField(choices=EXPERIENCE_CHOICES)
    requirements = models.TextField()
    benefits = models.TextField()
    contact_name = models.CharField(max_length=255)
    contact_number = models.CharField(max_length=255)
    contact_email = models.EmailField(max_length=255)
    contact_address = models.CharField(max_length=255)
    posting_date = models.DateField()
    expiration_date = models.DateField()
    status = models.IntegerField(choices=STATUS_CHOICES)
    views = models.IntegerField()
    employer = models.ForeignKey(Employer, on_delete=models.CASCADE)
    updated_by = models.ForeignKey(Admin, on_delete=models.CASCADE, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title




class CareerGroup(models.Model):
    id = models.AutoField(primary_key=True)
    job_board = models.ForeignKey(JobBoard, on_delete=models.CASCADE)
    career = models.ForeignKey(Career, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)
    
class JobApplication(models.Model):
    STATUS_CHOICES = [
        (1, 'Chưa xử lý'),
        (2, 'Đã duyệt'),
        (3, 'Đã từ chối'),
    ]

    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=255)
    email = models.EmailField(max_length=255)
    cv = models.CharField(max_length=255)
    job_board = models.ForeignKey(JobBoard, on_delete=models.CASCADE)
    status = models.IntegerField(choices=STATUS_CHOICES)
    submission_date = models.DateField(auto_now_add=True)
    candidate = models.ForeignKey(Candidate, on_delete=models.CASCADE)

    def __str__(self):
        return self.name