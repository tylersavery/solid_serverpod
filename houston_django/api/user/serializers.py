from django.contrib.auth import get_user_model
from phonenumber_field.serializerfields import PhoneNumberField
from rest_framework import serializers
from rest_framework.validators import UniqueValidator

from api.user.querysets import ALL_USERS_QUERYSET

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    number = PhoneNumberField(
        max_length=User.get_field("number").max_length,
        read_only=True,
    )
    name = serializers.CharField(
        max_length=User.get_field("name").max_length,
        required=False,
    )
    email = serializers.EmailField(
        max_length=User.get_field("email").max_length,
        validators=[UniqueValidator(queryset=ALL_USERS_QUERYSET, lookup="iexact")],
        required=False,
    )

    class Meta:
        model = User
        fields = [
            "id",
            "uuid",
            "number",
            "name",
            "email",
            "image",
            "bio",
            "is_setup",
            "metadata",
            "created_at",
            "updated_at",
        ]
        read_only_fields = [
            "id",
            "uuid",
            "is_setup",
            "metadata",
            "created_at",
            "updated_at",
        ]
        extra_kwargs = {}


class UserPublicSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = [
            "id",
            "uuid",
            "name",
            "image",
            "bio",
            "created_at",
        ]
