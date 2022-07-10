import 'package:flutter/material.dart';
import 'package:start_app/models/event.dart';

class EventNotifier extends ChangeNotifier {
  static Event ev1 = Event("그때 그 시절", "image source", Colors.purpleAccent,
      "google form link", "그때 그 시절 content");
  static Event ev2 = Event("축제 미션 올클리어", "image source", Colors.cyan,
      "google form link", "축제 미션 올클리어 content");

  List<Event> _events = [ev1, ev2];

  List<Event> getEvents() {
    return _events;
  }

  Future<void> fetchEvents() async{

  }
}