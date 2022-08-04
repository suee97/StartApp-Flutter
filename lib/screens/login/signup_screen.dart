import 'package:flutter/material.dart';

import '../../widgets/test_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TestButton(title: "회원가입스크린", onPressed: () => {
      }),
    );
  }
}
