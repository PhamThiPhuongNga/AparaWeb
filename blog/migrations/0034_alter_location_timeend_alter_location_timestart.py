# Generated by Django 4.1.1 on 2022-12-07 06:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0033_location_timeend_location_timestart'),
    ]

    operations = [
        migrations.AlterField(
            model_name='location',
            name='timeend',
            field=models.DateTimeField(null=True),
        ),
        migrations.AlterField(
            model_name='location',
            name='timestart',
            field=models.DateTimeField(null=True),
        ),
    ]
