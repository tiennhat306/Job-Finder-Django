from admin.models import Admin
from candidate.models import Candidate
from employer.models import Career, City, Employer, JobBoard, CareerGroup, JobApplication

# add random data
from django.contrib.auth.models import User
from faker import Faker
import random
from datetime import datetime
from django.utils import timezone

fake = Faker()

def add_admin():
    for i in range(10):
        admin = Admin.objects.create(
            name=fake.name(),
            email='admin' + str(i) + '@gmail.com',
            password='123456',
            phone_number=fake.phone_number(),
            gender=random.choice([0, 1]),
            birthday=fake.date_of_birth(),
            address=fake.address(),
            avatar='avatar.jpg',
            enabled=True
        )
        admin.save()


def add_candidate():
    for i in range(50):
        candidate = Candidate.objects.create(
            name=fake.name(),
            email='candidate' + str(i) + '@gmail.com',
            password='123456',
            phone_number=fake.phone_number(),
            gender=random.choice([0, 1]),
            birthday=fake.date_of_birth(),
            address=fake.address(),
            avatar='avatar.jpg'
        )
        candidate.save()

        
def add_city():
    city_name = [
        "An Giang", "Bà Rịa - Vũng Tàu", "Bắc Giang", "Bắc Kạn", "Bạc Liêu", "Bắc Ninh", 
        "Bến Tre", "Bình Định", "Bình Dương", "Bình Phước", "Bình Thuận", "Cà Mau", 
        "Cần Thơ", "Cao Bằng", "Đà Nẵng", "Đắk Lắk", "Đắk Nông", "Điện Biên", 
        "Đồng Nai", "Đồng Tháp", "Gia Lai", "Hà Giang", "Hà Nam", "Hà Nội", 
        "Hà Tĩnh", "Hải Dương", "Hải Phòng", "Hậu Giang", "Hòa Bình", "Hưng Yên", 
        "Khánh Hòa", "Kiên Giang", "Kon Tum", "Lai Châu", "Lâm Đồng", "Lạng Sơn", 
        "Lào Cai", "Long An", "Nam Định", "Nghệ An", "Ninh Bình", "Ninh Thuận", 
        "Phú Thọ", "Phú Yên", "Quảng Bình", "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", 
        "Quảng Trị", "Sóc Trăng", "Sơn La", "Tây Ninh", "Thái Bình", "Thái Nguyên", 
        "Thanh Hóa", "Thừa Thiên Huế", "Tiền Giang", "TP. Hồ Chí Minh", "Trà Vinh", 
        "Tuyên Quang", "Vĩnh Long", "Vĩnh Phúc", "Yên Bái"
    ]

    for i in range(len(city_name)):
        city = City.objects.create(
            name=city_name[i],
            code='CT' + str(i)
        )
        city.save()
    
        
def add_career():
    career_name = [
        "Kế toán / Kiểm toán", "Bán hàng", "Marketing", "IT phần cứng / Mạng", "IT phần mềm", 
        "Lao động phổ thông", "Y tế / Dược", "Xây dựng", "Hành chính / Văn phòng", "Nhân sự", 
        "Thiết kế", "Giáo dục / Đào tạo", "Tài chính / Ngân hàng", "Du lịch / Nhà hàng", "Thực phẩm / Đồ uống", 
        "Môi trường", "Nông nghiệp", "Thể thao / Giải trí", "Bảo vệ / An ninh", "Bưu chính viễn thông", 
        "Dệt may / Da giày", "Dầu khí / Hóa chất", "Hàng không / Du lịch", "Hàng hải", "Hàng tiêu dùng", 
        "Hàng tồn kho / Vận chuyển", "Hàng xuất nhập khẩu", "Hàng không"
    ]

    for i in range(len(career_name)):
        career = Career.objects.create(
            name=career_name[i],
            description='Mô tả ngành nghề ' + career_name[i]
        )
        career.save()

        
def add_employer():
    for i in range(20):
        employer = Employer.objects.create(
            username='employer' + str(i) + '@gmail.com',
            password='123456',
            company_name=fake.company(),
            company_size=random.choice([1, 2, 3, 4, 5, 6]),
            contact_name=fake.name(),
            contact_number=fake.phone_number(),
            city=City.objects.get(pk=random.randint(1, 63)),
            address=fake.address(),
            business_license_code=fake.ean8(),
            website=fake.url(),
            description=fake.text(),
            logo='logo.jpg'
        )
        employer.save()


        
def add_job_board():
    for i in range(100):
        job_board = JobBoard.objects.create(
            title=fake.job(),
            code='JB' + str(i),
            company_name=fake.company(),
            company_size=random.choice([1, 2, 3, 4, 5, 6]),
            company_description=fake.text(),
            website=fake.url(),
            city=City.objects.get(pk=random.randint(1, 63)),
            address=fake.address(),
            job_type=random.choice([1, 2, 3]),
            job_level=random.choice([1, 2, 3, 4, 5]),
            salary_type=random.choice([1, 2, 3]),
            salary_from=random.uniform(5, 10),
            salary_to=random.uniform(10, 20),
            age_type=random.choice([1, 2, 3, 4]),
            age_from=random.randint(18, 30),
            age_to=random.randint(30, 60),
            gender_type=random.choice([1, 2, 3]),
            job_description=fake.text(),
            quantity=random.randint(1, 10),
            qualification=random.choice([1, 2, 3, 4, 5, 6]),
            years_of_experience=random.choice([1, 2, 3, 4, 5]),
            requirements=fake.text(),
            benefits=fake.text(),
            contact_name=fake.name(),
            contact_number=fake.phone_number(),
            contact_email=fake.email(),
            contact_address=fake.address(),
            # posting_date random from 3 months ago to 2 months later
            posting_date=timezone.now() + timezone.timedelta(days=random.randint(-90, 60)),
            # expiration_date random from 1 2 months ago to 6 months later
            expiration_date=timezone.now() + timezone.timedelta(days=random.randint(-60, 180)),
            status=random.choice([1, 2, 3, 4]),
            views=random.randint(0, 100),
            employer=Employer.objects.get(pk=random.randint(1, 20)),
            updated_by=Admin.objects.get(pk=random.randint(1, 10))
        )
        job_board.save()

        
def add_career_group():
    for i in range(100):
        career_group = CareerGroup.objects.create(
            job_board=JobBoard.objects.get(pk=random.randint(1, 100)),
            career=Career.objects.get(pk=random.randint(1, 24))
        )
        career_group.save()
    
        
def add_job_application():
    for i in range(100):
        job_application = JobApplication.objects.create(
            name=fake.name(),
            phone_number=fake.phone_number(),
            email=fake.email(),
            cv='cv' + str(i) + '.pdf',
            job_board=JobBoard.objects.get(pk=random.randint(1, 100)),
            status=random.choice([1, 2, 3]),
            submission_date=timezone.now(),
            candidate=Candidate.objects.get(pk=random.randint(1, 50))
        )
        job_application.save()
        

# main
def __main__():
    add_admin()
    add_candidate()
    add_city()
    add_career()
    add_employer()
    add_job_board()
    add_career_group()
    add_job_application()