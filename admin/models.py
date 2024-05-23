from django.db import models

class Admin(models.Model):
    GENDER_CHOICES = (
        (0, 'Male'),
        (1, 'Female'),
    )

    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    email = models.EmailField(max_length=255)
    password = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=255)
    gender = models.IntegerField(choices=GENDER_CHOICES)
    birthday = models.DateField()
    address = models.CharField(max_length=255)
    avatar = models.CharField(max_length=255, blank=True, null=True)
    enabled = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    token = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return self.name
