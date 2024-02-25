# Generated by Django 4.2.5 on 2024-02-25 11:14

import django.core.serializers.json
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("notification", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="notification",
            name="meta",
            field=models.JSONField(
                encoder=django.core.serializers.json.DjangoJSONEncoder,
                null=True,
            ),
        ),
    ]