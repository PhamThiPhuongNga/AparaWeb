# Generated by Django 4.1.1 on 2022-11-13 13:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0010_rename_location_comment_detaillocation'),
    ]

    operations = [
        migrations.AddField(
            model_name='comment',
            name='rating',
            field=models.CharField(max_length=70, null=True),
        ),
    ]