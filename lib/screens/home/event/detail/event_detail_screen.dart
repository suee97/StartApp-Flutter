import 'package:flutter/material.dart';
import 'package:start_app/models/event.dart';

class EventDetailScreen extends StatefulWidget {
  EventDetailScreen({Key? key, required this.event}) : super(key: key);
  Event event;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("event detail screen"),),
      body: Center(
        child: Text(widget.event.content),
      ),
    );
  }
}
