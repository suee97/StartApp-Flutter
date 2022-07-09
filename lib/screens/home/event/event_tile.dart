import 'package:flutter/material.dart';
import '../../../models/event.dart';

class EventTile extends StatelessWidget {
  EventTile({Key? key, required this.event}) : super(key: key);

  Event event;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        tileColor: event.color,
        title: Text(event.title),
      ),
    );
  }
}
