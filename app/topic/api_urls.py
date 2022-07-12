from django.urls import path

import topic.api_views


urlpatterns = [
    path('topic/', topic.api_views.TopicListAPIView.as_view()),
    path('topic-create/', topic.api_views.TopicCreateAPIView.as_view()),

    path('topic/<int:pk>/', topic.api_views.TopicRetrieveAPIView.as_view()),
    path('topic/<int:topic_pk>/message/', topic.api_views.TopicMessageCreateAPIView.as_view()),

    path('user/', topic.api_views.GetConnectedUserAPIView.as_view()),
    path('user/<int:pk>/update/', topic.api_views.UpdateUserAPIView.as_view())
]