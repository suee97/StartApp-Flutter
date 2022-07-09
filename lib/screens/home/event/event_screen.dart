import 'package:flutter/material.dart';
import 'package:start_app/models/event.dart';
import 'package:start_app/screens/home/event/detail/event_detail_screen.dart';
import 'package:start_app/screens/home/event/event_tile.dart';

/// 이곳에서 컨슘 하고 디테일스크린에는 파라미터로 보낼 예정

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Event ev1 = Event("그때 그 시절", "image source", Colors.purpleAccent,
        "google form link", "그때 그 시절 content");
    Event ev2 = Event("축제 미션 올클리어", "image source", Colors.cyan,
        "google form link", "축제 미션 올클리어 content");

    return Scaffold(
        appBar: AppBar(
          title: const Text("이벤트 참여"),
        ),
        body: Column(children: [
          EventTile(
            event: ev1,
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: ev1)))
            },
          ),
          EventTile(
            event: ev2,
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: ev2)))
            },
          ),
        ]));
  }
}
