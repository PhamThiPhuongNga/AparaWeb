# Generated by Django 4.1.1 on 2022-11-22 02:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0018_comment_status'),
    ]

    operations = [
        migrations.AlterField(
            model_name='location',
            name='image',
            field=models.FileField(blank=True, upload_to=''),
        ),
    ]
