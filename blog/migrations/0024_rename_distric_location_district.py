# Generated by Django 4.1.1 on 2022-11-25 02:28

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0023_alter_location_image'),
    ]

    operations = [
        migrations.RenameField(
            model_name='location',
            old_name='distric',
            new_name='district',
        ),
    ]
