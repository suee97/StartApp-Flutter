import 'package:flutter/material.dart';
import 'package:start_app/screens/login/sign_up/check_info_screen.dart';
import 'package:start_app/widgets/test_button.dart';

class PolicyAgreeScreen extends StatefulWidget {
  const PolicyAgreeScreen({Key? key}) : super(key: key);

  @override
  State<PolicyAgreeScreen> createState() => _PolicyAgreeScreenState();
}

class _PolicyAgreeScreenState extends State<PolicyAgreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("약관 동의 화면"),
      ),
      body: TestButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CheckInfoScreen()));
        },
        title: "다음",
      ),
    );
  }
}
