import 'package:flutter/material.dart';
import 'package:start_app/widgets/main_widget.dart';
import '../login/login_screen.dart';

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
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()))
            },
            icon: Icon(Icons.person_outline),
            color: Colors.black,
            iconSize: 40,
          )
        ],
      ),
      body: MainWidget(
          title: "총학생회 설명", icon: Icon(Icons.info), onPressed: () => {}),
    );
  }
}
