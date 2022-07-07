import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '서울과학기술대학교\n총학생회',
      theme: ThemeData(
        primaryColor: Colors.transparent,
      ),
      home: HomeScreen(),
    );
  }
}
