# Generated by Django 4.1.1 on 2022-12-10 16:26

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0040_rating_date'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='comment',
            name='rating',
        ),
    ]
