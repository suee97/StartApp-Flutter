import 'package:flutter/material.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/widgets/test_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentIdController = TextEditingController();
    final pwController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  CustomTextField(
                    label: "Student ID",
                    controller: studentIdController,
                    isObscure: false,
                  ),
                  CustomTextField(
                    label: "Password",
                    controller: pwController,
                    isObscure: true,
                  ),
                  TestButton(title: "제출", onPressed: () => {})
                ],
              ),
            ),
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
