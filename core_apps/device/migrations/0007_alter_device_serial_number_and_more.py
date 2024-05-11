# Generated by Django 4.2.5 on 2024-05-05 08:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("device", "0006_alter_devicespec_series_name"),
    ]

    operations = [
        migrations.AlterField(
            model_name="device",
            name="serial_number",
            field=models.CharField(max_length=255, unique=True),
        ),
        migrations.AlterField(
            model_name="devicespec",
            name="series_name",
            field=models.CharField(max_length=255),
        ),
    ]
