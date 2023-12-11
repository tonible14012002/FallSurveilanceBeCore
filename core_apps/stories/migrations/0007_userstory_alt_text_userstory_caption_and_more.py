# Generated by Django 4.2.5 on 2023-12-10 15:54

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("stories", "0006_alter_storyview_options_alter_userstory_options"),
    ]

    operations = [
        migrations.AddField(
            model_name="userstory",
            name="alt_text",
            field=models.CharField(default="", max_length=200),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name="userstory",
            name="caption",
            field=models.CharField(default="", max_length=200),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name="userstory",
            name="view_option",
            field=models.CharField(
                choices=[("ONLY_ME", "Only me"), ("EVERYONE", "Every one")],
                default="EVERYONE",
            ),
        ),
    ]
