# Generated by Django 4.2.5 on 2024-01-20 17:29

from django.db import migrations


class Migration(migrations.Migration):
    dependencies = [
        ("user", "0001_initial"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="myuser",
            name="followers",
        ),
    ]
