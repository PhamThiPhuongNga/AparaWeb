# Generated by Django 4.1.1 on 2022-11-27 06:30

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0025_images'),
    ]

    operations = [
        migrations.AlterField(
            model_name='images',
            name='location_id',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='images', to='blog.location'),
        ),
    ]
