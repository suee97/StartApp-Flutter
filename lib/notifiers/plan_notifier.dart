import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:start_app/models/meeting.dart';

class PlanNotifier extends ChangeNotifier {
  int _curDay = DateTime.now().day;
  int _curWeekDay = DateTime.now().weekday;
  List<Meeting> _meetingList = [];
  List<Meeting> _selectedMeetingList = [];

  int getCurDay() {
    return _curDay;
  }

  void setCurDay(int value) {
    _curDay = value;
    notifyListeners();
  }

  String getCurWeekDay() {
    switch (_curWeekDay) {
      case 1:
        return "월";
      case 2:
        return "화";
      case 3:
        return "수";
      case 4:
        return "목";
      case 5:
        return "금";
      case 6:
        return "토";
      case 7:
        return "일";
      default:
        return "";
    }
  }

  void setCurWeekDay(int value) {
    _curWeekDay = value;
    notifyListeners();
  }

  List<Meeting> getMeetingList() {
    return _meetingList;
  }

  Future<void> fetchMeetingList(int year, int month) async {
    final List<Meeting> tempMeetingList = [];
    Map<String, dynamic> resData = {};
    resData["status"] = 400;

    try {
      var resString = await http
          .get(Uri.parse(
              "${dotenv.get("DEV_API_BASE_URL")}/plan?year=$year&month=$month"))
          .timeout(const Duration(seconds: 10));
      resData = jsonDecode(utf8.decode(resString.bodyBytes));
    } on TimeoutException catch (e) {
      return print("TimeoutException : $e");
    } on SocketException catch (e) {
      return print("SocketException : $e");
    } catch (e) {
      return print("error : $e");
    }

    if (resData["status"] != 200) {
      return;
    }

    List<dynamic> data = resData["data"];
    for (var e in data) {
      tempMeetingList.add(Meeting(
          e["planName"],
          DateTime(
              int.parse(e["startTime"].substring(0, 4)),
              int.parse(e["startTime"].substring(5, 7)),
              int.parse(e["startTime"].substring(8, 10))),
          DateTime(
              int.parse(e["endTime"].substring(0, 4)),
              int.parse(e["endTime"].substring(5, 7)),
              int.parse(e["endTime"].substring(8, 10))),
          hexToColor(e["color"]),
          false));
    }
    _meetingList = tempMeetingList;
    notifyListeners();
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 9), radix: 16) + 0x00000000);
  }

  List<Meeting> getSelectedDayMeetingList() {
    return _selectedMeetingList;
  }

  void setSelectedDayMeetingList(int? year, int? month, int? day) {

    var tempDateTime = DateTime(year!, month!, day!);

    List<Meeting> selectedDayMeetingList = [];
    for(var item in _meetingList) {
      if(tempDateTime.difference(item.from) >= Duration(seconds: 0) && tempDateTime.difference(item.to) <= Duration(seconds: 0)) {
        selectedDayMeetingList.add(item);
      }
    }

    _selectedMeetingList = selectedDayMeetingList;
    notifyListeners();
  }
}
