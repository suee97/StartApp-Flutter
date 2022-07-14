import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:start_app/models/event_list.dart';
import 'package:http/http.dart' as http;

class EventNotifier extends ChangeNotifier {
  /// Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy
  final List<Event> _eventListDummy = [
    Event(1, "그때 그 시절", "https://docs.google.com/forms/d/e/1FAIpQLSe0NjSatm6bLuJHayA8BSNOEnCdQ6RxjRgJRFO_85Q6f4A8yg/viewform", "https://img", "#ffff00",
        "2022-08-05T22:23:21.159220", "2022-08-06T22:23:21.159220", false),
    Event(2, "축제 미션 올 클리어", "https://docs.google.com/forms/d/e/1FAIpQLSe0NjSatm6bLuJHayA8BSNOEnCdQ6RxjRgJRFO_85Q6f4A8yg/viewform", "https://img", "#ff12ff",
        "2022-07-13T22:23:21.159220", "2022-07-22T22:23:21.159220", false),
    Event(3, "어의체전", "https://docs.google.com/forms/d/e/1FAIpQLSe0NjSatm6bLuJHayA8BSNOEnCdQ6RxjRgJRFO_85Q6f4A8yg/viewform", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    Event(3, "무엇이든 물어보살", "https://docs.google.com/forms/d/e/1FAIpQLSe0NjSatm6bLuJHayA8BSNOEnCdQ6RxjRgJRFO_85Q6f4A8yg/viewform", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    Event(3, "그때 그 시절", "https://docs.google.com/forms/d/e/1FAIpQLSe0NjSatm6bLuJHayA8BSNOEnCdQ6RxjRgJRFO_85Q6f4A8yg/viewform", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    Event(3, "그때 그 시절", "https://form", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    Event(3, "그때 그 시절", "https://form", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    Event(3, "그때 그 시절", "https://form", "https://img", "#f45fff",
        "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
  ];
  List<Event> getDummyEventList() {
    return _eventListDummy;
  }
  /// Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy


  List<Event> _eventList = [];
  Future<void> fetchEventList() async {
    try {
      var resString = await http.get(Uri.parse(dotenv.get('API_BASE_URL')));
      Map<String, dynamic> resData = jsonDecode(resString.body);
      if (resData['status'] == 400) {
        print("Message ==> ${resData['message']}");
      } else {
        print("Message ==> ${resData['message']}");
        _eventList = resData['data'];
      }
    } catch(e) {
      print("Error ==> $e}");
    }
  }

  List<Event> getEventList() {
    return _eventList;
  }

}
