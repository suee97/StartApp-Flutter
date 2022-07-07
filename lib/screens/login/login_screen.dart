import 'package:flutter/material.dart';
import 'package:start_app/screens/login/sign_in/sign_in_screen.dart';
import 'package:start_app/screens/login/sign_up/sign_up_screen.dart';
import 'package:start_app/widgets/test_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            TestButton(
                title: "로그인",
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()))
                    }),
            TestButton(
                title: "회원가입",
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()))
                    })
          ],
        ),
      ),
    );
  }
}
