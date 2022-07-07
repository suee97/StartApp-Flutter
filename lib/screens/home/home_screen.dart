import 'package:flutter/material.dart';
import 'package:start_app/widgets/test_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "서울과학기술대학교\n총학생회",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: TestButton(
        title: 'button',
        callback: () => {},
      ),
    );
  }
}
