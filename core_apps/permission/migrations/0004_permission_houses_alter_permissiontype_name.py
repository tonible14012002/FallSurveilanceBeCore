# Generated by Django 4.2.5 on 2024-02-03 05:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("house", "0007_rename_owners_house_members"),
        ("permission", "0003_generate_permissions"),
    ]

    operations = [
        migrations.AddField(
            model_name="permission",
            name="houses",
            field=models.ManyToManyField(
                related_name="permissions", to="house.house"
            ),
        ),
        migrations.AlterField(
            model_name="permissiontype",
            name="name",
            field=models.CharField(
                max_length=100,
                unique=True,
                verbose_name=[
                    ("REMOVE_HOUSE", "Remove house"),
                    ("INVITE_HOUSE_MEMBER", "Invite house member"),
                    ("REMOVE_HOUSE_MEMBER", "Remove house member"),
                    ("ACCESS", "Access"),
                    ("ASSIGN", "Assign"),
                    ("DELETE", "Delete"),
                    ("RECEIVE_NOTIFICATION", "Receive Notification"),
                    ("REMOVE_MEMBER", "Remove Member"),
                    ("ASSIGN_ROOM_PERMISSION", "Assign Room Permission"),
                ],
            ),
        ),
    ]