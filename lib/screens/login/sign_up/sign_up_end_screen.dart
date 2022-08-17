import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/home_screen.dart';

import '../../../widgets/test_button.dart';

class SignUpEndScreen extends StatelessWidget {
  const SignUpEndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUpEndScreen"),
      ),
      body: TestButton(
        title: "홈으로 이동",
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false);
        },
      ),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }
}
