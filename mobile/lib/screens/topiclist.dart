import 'package:flutter/material.dart';
import 'package:mobile/widgets/bottombutton.dart';
import 'package:mobile/widgets/usericon.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../serializers/topicslist.dart';

class TopicListScreen extends StatefulWidget {
  const TopicListScreen({super.key});

  @override
  State<TopicListScreen> createState() => TopicListScreenState();
}

class TopicListScreenState extends State<TopicListScreen> {
  Future<TopicsList> topics = fetchTopics();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>(); // Inutile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Topics"),
            actions: const [UserIcon()]),
        floatingActionButton: const BottomButton(
          buttonIcon: Icons.add,
          onPushRoute: "/new",
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Stack(alignment: AlignmentDirectional.center, children: [
          FutureBuilder<TopicsList>(
            future: topics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.results.isNotEmpty
                    ? RefreshIndicator(
                        key: _refreshIndicatorKey,
                        onRefresh: () async {
                          setState(() {
                            topics = fetchTopics();
                          });
                        },
                        child: ListView.builder(
                          itemCount: snapshot.data!.results.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(children: [
                              ListTile(
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
                              ),
                              const Divider()
                            ]);
                          },
                        ))
                    : const Center(
                        child: Text("There are no topics available."));
              } else if (snapshot.hasError) {
                return Text(
                  "${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ]));
  }
}
