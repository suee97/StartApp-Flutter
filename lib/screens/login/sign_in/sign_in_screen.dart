import 'package:flutter/material.dart';
import 'package:start_app/widgets/custom_text_field.dart';
import 'package:start_app/widgets/test_button.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final studentIdController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in screen"),
      ),
      body: Center(
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
    );
  }
}
