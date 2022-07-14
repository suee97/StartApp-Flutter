import 'package:flutter/material.dart';
import 'package:start_app/models/event_list.dart';

class EventNotifier extends ChangeNotifier {
  List<Event> _eventList = [
    Event(1, "그때 그 시절", "https://form", "https://img", "#ffff00",
        "2022-08-05T22:23:21.159220", "2022-08-06T22:23:21.159220", false),
    Event(2, "축제 미션 올 클리어", "https://form", "https://img", "#ff12ff",
        "2022-07-13T22:23:21.159220", "2022-07-22T22:23:21.159220", false),
    Event(3, "어의체전", "https://form", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    Event(3, "무엇이든 물어보살", "https://form", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    Event(3, "그때 그 시절", "https://form", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    Event(3, "그때 그 시절", "https://form", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    Event(3, "그때 그 시절", "https://form", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    Event(3, "그때 그 시절", "https://form", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
  ];

  List<Event> getEvents() {
    return _eventList;
  }

  Future<void> fetchEvents() async {}
}
