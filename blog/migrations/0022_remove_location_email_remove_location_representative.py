# Generated by Django 4.1.1 on 2022-11-24 09:25

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0021_alter_location_logo'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='location',
            name='email',
        ),
        migrations.RemoveField(
            model_name='location',
            name='representative',
        ),
    ]
