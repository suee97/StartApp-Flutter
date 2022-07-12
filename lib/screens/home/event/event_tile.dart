import 'package:flutter/material.dart';
import 'package:start_app/utils/common.dart';
import '../../../models/event_list.dart';

/// 단일 이벤트 타일 위젯

class EventTile extends StatelessWidget {
  EventTile(
      {Key? key,
      required this.event,
      required this.onPressed})
      : super(key: key);

  Event event;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        child: ListTile(
          onTap: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
          ),
          enabled: !event.isExpired!,
          subtitle: Text(Common.parseTime(event.startTime!, event.endTime!)),
          tileColor: Colors.blue,
          title: Text(event.title!),
        ),
      ),
    );
  }
}
