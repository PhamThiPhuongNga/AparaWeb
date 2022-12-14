# Generated by Django 4.1.1 on 2022-10-22 09:00

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='location',
            name='describe',
            field=models.TextField(max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='location',
            name='logo',
            field=models.ImageField(blank=True, upload_to='users/%Y/%m/%d/'),
        ),
    ]
