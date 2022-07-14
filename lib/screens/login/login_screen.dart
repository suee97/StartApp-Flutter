import 'package:flutter/material.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/screens/login/sign_in/sign_in_screen.dart';
import 'package:start_app/widgets/test_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TestButton(
                title: "로그인",
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()))
                    }),
            TestButton(title: "로그인 없이 이용하기", onPressed: () => {
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
