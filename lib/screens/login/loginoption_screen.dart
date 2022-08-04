import 'package:flutter/material.dart';
import '../../utils/common.dart';
import '../../widgets/test_button.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';

class LoginOptionScreen extends StatelessWidget {
  const LoginOptionScreen({Key? key}) : super(key: key);

  get studentIdController => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  TestButton(title: "로그인", onPressed: () =>
                    {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen())
                      )
                    }
                  )
                ],
              ),
            ),
            TestButton(title: "로그인 없이 이용하기", onPressed: () => {
              Common.setNonLogin(true),
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen()))
            })
          ],
        ),
      ),
    );
  }
}
