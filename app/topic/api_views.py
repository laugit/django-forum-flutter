from rest_framework import generics

from django.db.models import Count

import topic.models
import topic.serializer
import user.models

class TopicListAPIView(generics.ListAPIView):
    queryset = topic.models.Topic.objects.all()
    serializer_class = topic.serializer.TopicSerializer

    def get_queryset(self):
        """
        Return the list of items for this view.
        """
        queryset =  super().get_queryset()

        queryparam_user = self.request.GET.get('user', '')
        if queryparam_user != '':
            queryset = queryset.filter(creator__pk=int(queryparam_user))
            
        queryparam_filter = self.request.GET.get('filter', 'all')
        if queryparam_filter == 'solved':
            queryset = queryset.filter(is_solved=True)
        elif queryparam_filter == 'unsolved':
            queryset = queryset.filter(is_solved=False)
        elif queryparam_filter == 'noreplies':
            queryset = queryset.annotate(num_messages=Count('topicmessage')).filter(num_messages=0)

        queryparam_search = self.request.GET.get('search', '')
        if queryparam_search:
            queryset = queryset.filter(title__icontains=queryparam_search)

        return queryset

class TopicCreateAPIView(generics.CreateAPIView):
    queryset = topic.models.Topic.objects.all()
    serializer_class = topic.serializer.TopicSerializer

class TopicRetrieveAPIView(generics.RetrieveAPIView):
    queryset = topic.models.Topic.objects.all()
    serializer_class = topic.serializer.TopicRetrieveSerializer


class TopicMessageCreateAPIView(generics.CreateAPIView):
    queryset = topic.models.TopicMessage.objects.all()
    serializer_class = topic.serializer.TopicMessageSerializer

class GetConnectedUserAPIView(generics.ListAPIView):
    queryset = user.models.User.objects.filter(pk=1)
    serializer_class = topic.serializer.TopicCreatorSerializer