import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpNotifier extends ChangeNotifier {
  var _studentNo = "";
  var _appPassword = "";
  var _name = "";
  var _department = "";
  var _fcmToken = "";
  var _phoneNo = "";
  var _file;

  String getStudentNo() {
    return _studentNo;
  }
  String getAppPassword() {
    return _appPassword;
  }
  String getName() {
    return _name;
  }
  String getDepartment() {
    return _department;
  }
  String getFcmToken() {
    return _fcmToken;
  }
  String getPhoneNo() {
    return _phoneNo;
  }
  String getFile() {
    return _file;
  }

  void setStudentNo(String value) {
    _studentNo = value;
    notifyListeners();
  }
  void setAppPassword(String value) {
    _appPassword = value;
    notifyListeners();
  }
  void setName(String value) {
    _name = value;
    notifyListeners();
  }
  void setDepartment(String value) {
    _department = value;
    notifyListeners();
  }
  void setFcmToken(String value) {
    _fcmToken = value;
    notifyListeners();
  }
  void setPhoneNo(String value) {
    _phoneNo = value;
    notifyListeners();
  }
  void setFile(String value) {
    _file = value;
    notifyListeners();
  }

  void clear() {
    _studentNo = "";
    _appPassword = "";
    _name = "";
    _department = "";
    _fcmToken = "";
    _file = null;

    notifyListeners();
  }
}

class EnrollStudent {
  EnrollStudent(this.studentNo, this.appPassword, this.name, this.department,
      this.fcmToken, this.file);

  String studentNo;
  String appPassword;
  String name;
  String department;
  String fcmToken;
  String file;
}
