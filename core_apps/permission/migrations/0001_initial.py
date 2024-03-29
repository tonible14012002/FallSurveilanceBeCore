# Generated by Django 4.2.5 on 2024-02-02 09:30

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ("house", "0006_alter_room_description"),
    ]

    operations = [
        migrations.CreateModel(
            name="PermissionType",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "name",
                    models.CharField(
                        max_length=100,
                        unique=True,
                        verbose_name=[
                            ("INVITE_HOUSE_MEMBER", "Invite house member"),
                            ("REMOVE_HOUSE_MEMBER", "Remove house member"),
                            ("ACCESS", "Access"),
                            ("ASSIGN", "Assign"),
                            ("DELETE", "Delete"),
                            ("RECEIVE_NOTIFICATION", "Receive Notification"),
                            ("REMOVE_MEMBER", "Remove Member"),
                            (
                                "ASSIGN_ROOM_PERMISSION",
                                "Assign Room Permission",
                            ),
                        ],
                    ),
                ),
                ("description", models.TextField(blank=True)),
            ],
            options={
                "db_table": "permission_type",
            },
        ),
        migrations.CreateModel(
            name="UserPermission",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                (
                    "permission_type",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="permissions",
                        to="permission.permissiontype",
                    ),
                ),
                (
                    "rooms",
                    models.ManyToManyField(
                        related_name="permissions", to="house.room"
                    ),
                ),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="permissions",
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
            options={
                "db_table": "user_permission",
                "unique_together": {("permission_type", "user")},
            },
        ),
    ]
