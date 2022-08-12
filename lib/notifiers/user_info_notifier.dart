import 'package:flutter/material.dart';

class UserInfoNotifier extends ChangeNotifier {
  late bool isLogin;

  void setIsLogin(bool value) {
    isLogin = value;
    notifyListeners();
  }
}