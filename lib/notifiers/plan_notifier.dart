import 'package:flutter/material.dart';

class PlanNotifier extends ChangeNotifier {
  int _curDay = DateTime.now().day;
  int _curWeekDay = DateTime.now().weekday;

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
}
