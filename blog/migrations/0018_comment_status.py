# Generated by Django 4.1.1 on 2022-11-21 16:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0017_comment_updated_at'),
    ]

    operations = [
        migrations.AddField(
            model_name='comment',
            name='status',
            field=models.BooleanField(default=True, null=True),
        ),
    ]