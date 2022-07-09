import 'package:flutter/material.dart';
import 'package:start_app/models/event.dart';
import 'package:start_app/screens/home/event/event_tile.dart';

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Event ev1 = Event("그때 그 시절", "2", Colors.purpleAccent, "4", "5");
    Event ev2 = Event("축제 미션 올클리어", "2", Colors.cyan, "4", "5");

    return Scaffold(
        appBar: AppBar(
          title: const Text("이벤트 참여"),
        ),
        body: EventTile(
          event: ev1,
        ));
  }
}
