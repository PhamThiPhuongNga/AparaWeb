# Generated by Django 4.1.1 on 2022-11-20 15:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0014_alter_comment_rating'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comment',
            name='rating',
            field=models.CharField(max_length=70, null=True),
        ),
    ]
