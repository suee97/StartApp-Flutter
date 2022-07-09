import 'package:flutter/material.dart';
import '../../../models/event.dart';

/// 단일 이벤트 타일 위젯

class EventTile extends StatelessWidget {
  EventTile({Key? key, required this.event, required this.onPressed}) : super(key: key);

  Event event;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onTap: onPressed,
        tileColor: event.color,
        title: Text(event.title),
      ),
    );
  }
}
