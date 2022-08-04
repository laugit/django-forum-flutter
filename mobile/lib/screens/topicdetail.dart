import 'package:flutter/material.dart';
import 'package:mobile/serializers/topic.dart';
import 'package:mobile/widgets/bottombutton.dart';
import 'package:mobile/widgets/usericon.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../widgets/topicblock.dart';

class TopicDetailScreen extends StatelessWidget {
  const TopicDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(leading: const BackButton(), actions: const [UserIcon()]),
        floatingActionButton: const BottomButton(
          buttonIcon: Icons.add,
          onPushRoute: "/new-message",
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Consumer<TopicAndCreatorModel>(
          builder: (context, topicmodel, child) {
            return FutureBuilder<Topic>(
              future: topicmodel.topic,
              builder: (context, topic) {
                if (topic.hasData) {
                  return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              topic.data!.title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )),
                        TopicBlock(
                          avatarUrl:
                              "http://10.0.2.2:8000${topic.data!.creator.avatarUrl}",
                          headingText: Text(
                              textAlign: TextAlign.start,
                              topic.data!.description,
                              style: TextStyle(color: Colors.grey.shade600)),
                          title: "${topic.data!.creator.fullname}",
                          trailingText:
                              "about ${DateTime.now().difference(DateTime.parse("${topic.data?.createdAt}")).inDays ~/ 365} days ago",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Réponses",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        topic.data!.messagesCount > 0
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount:
                                    topic.data?.messagesList?.results.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TopicBlock(
                                    avatarUrl:
                                        "http://10.0.2.2:8000${topic.data?.messagesList!.results[index].creator.avatarUrl}",
                                    headingText: Text(
                                        textAlign: TextAlign.start,
                                        "${topic.data!.messagesList?.results[index].message}"),
                                    title:
                                        "${topic.data!.messagesList?.results[index].creator.fullname}",
                                    trailingText:
                                        "about ${DateTime.now().difference(DateTime.parse("${topic.data?.messagesList?.results[index].createdAt}")).inDays ~/ 365} days ago",
                                  );
                                })
                            : Container(
                                padding: const EdgeInsets.only(top: 10),
                                // ignore: prefer_const_constructors
                                child: Text(
                                    "Il n'y a pas de réponses pour ce sujet."))
                      ]);
                } else if (topic.hasError) {
                  return Text(
                    "${topic.error}",
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const CircularProgressIndicator();
              },
            );
          },
        ));
  }
}
