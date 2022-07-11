import 'package:flutter/material.dart';
import '../../../models/event.dart';

/// 단일 이벤트 타일 위젯

class EventTile extends StatelessWidget {
  EventTile({Key? key, required this.event, required this.onPressed, required this.enabled}) : super(key: key);

  Event event;
  VoidCallback onPressed;
  bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onTap: onPressed,
        enabled: enabled,
        tileColor: event.color,
        title: Text(event.title!),
      ),
    );
  }
}
