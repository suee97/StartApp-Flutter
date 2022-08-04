import 'package:flutter/material.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/widgets/test_button.dart';

import '../../../utils/common.dart';
import '../../splash/splash_screen.dart.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "profile Screen",
          style: Common.startAppBarTextStyle,
        ),
      ),
      body: Center(
          child: TestButton(
        onPressed: () {
          Common.setNonLogin(false);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              SplashScreen()), (route) => false);
        },
        title: "set nonlogin false",
      )),
    );
  }
}
