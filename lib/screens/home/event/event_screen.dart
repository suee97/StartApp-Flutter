import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/event_notifier.dart';
import 'package:start_app/screens/home/event/detail/event_detail_screen.dart';
import 'package:start_app/screens/home/event/event_tile.dart';

/// 이곳에서 컨슘 하고 디테일스크린에는 파라미터로 보낼 예정

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EventNotifier>(builder: (context, eventNotifier, child) {
      var events = eventNotifier.getEvents();

      return Scaffold(
          appBar: AppBar(
            title: const Text("이벤트 참여"),
          ),
          body: Column(children: [
            EventTile(
              event: events[0],
              enabled: true,
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventDetailScreen(event: events[0])))
              },
            ),
            EventTile(
              event: events[1],
              enabled: true,
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventDetailScreen(event: events[1])))
              },
            ),
            EventTile(
              event: events[2],
              enabled: false,
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventDetailScreen(event: events[2])))
              },
            ),
          ]));
    });
  }
}
