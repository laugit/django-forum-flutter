import 'package:flutter/material.dart';
import 'package:mobile/screens/topicdetail.dart';
import 'package:mobile/widgets/bottombutton.dart';
import 'package:mobile/widgets/usericon.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../serializers/topicslist.dart';

class UserTopics extends StatefulWidget {
  const UserTopics({super.key});

  @override
  State<UserTopics> createState() => UserTopicsState();
}

class UserTopicsState extends State<UserTopics> {
  Future<TopicsList> topics = fetchTopicsOfUser();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopicsList>(
      future: topics,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.results.isNotEmpty
              ? RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async {
                    setState(() {
                      topics = fetchTopicsOfUser();
                    });
                  },
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    itemCount: snapshot.data!.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: [
                        InkWell(
                            child: Material(
                                elevation: 2,
                                child: ListTile(
                                  onTap: () {
                                    Provider.of<TopicAndCreatorModel>(context,
                                            listen: false)
                                        .changePk(
                                            snapshot.data!.results[index].id);
                                    Navigator.pushNamed(context, "/details");
                                  },
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "http://10.0.2.2:8000${snapshot.data!.results[index].creator.avatarUrl}")),
                                  title: Text(
                                    snapshot.data!.results[index].title,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.results[index].description,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ))),
                        const SizedBox(
                          height: 15,
                        )
                      ]);
                    },
                  ))
              : const Center(child: Text("There are no topics available."));
        } else if (snapshot.hasError) {
          return Text(
            "${snapshot.error}",
            style: const TextStyle(color: Colors.red),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
