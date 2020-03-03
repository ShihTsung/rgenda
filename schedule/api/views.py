from django.shortcuts import render
from rest_framework import viewsets, generics, permissions
from .serializers import CustomUserSerializer
from account.models import CustomUser
from rest_framework.decorators import action
from rest_framework.response import Response
from datetime import datetime, timedelta
from rest_framework.permissions import BasePermission, SAFE_METHODS


class IsOwnerOrReadOnly(BasePermission):
    """
    Object-level permission to only allow owners of an object to edit it.
    Assumes the model instance has an `user` attribute.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        return obj.user == request.user or user.is_staff


class IsAdminOrReadOnly(BasePermission):
    def has_permission(self, request, view):
        if request.method in SAFE_METHODS:
            return True
        else:
            return request.user.is_staff


class CustomUserViewSet(viewsets.ModelViewSet):
    queryset = CustomUser.objects.all().order_by('username')
    serializer_class = CustomUserSerializer
    permission_classes = (IsAdminOrReadOnly, permissions.IsAuthenticated)

    def get_object(self):
        pk = self.kwargs.get('pk')

        if pk == "current":
            return self.request.user

        return super(CustomUserViewSet, self).get_object()

    def get_queryset(self):
        queryset = self.queryset
        mode = self.request.query_params.get('mode', None)
        if mode == 'onlyUser':
            return queryset.filter(is_staff=False)
        return queryset
