import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 비동기 처리하기 위함

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '서울과학기술대학교 총학생회',
      theme: ThemeData(
        primaryColor: Colors.transparent,
      ),
      home: HomeScreen(),
    );
  }
}
