# Generated by Django 4.2.5 on 2023-10-14 12:28

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("accounts", "0004_alter_myuser_managers"),
    ]

    operations = [
        migrations.AddField(
            model_name="myuser",
            name="is_test",
            field=models.BooleanField(default=False),
        ),
    ]
