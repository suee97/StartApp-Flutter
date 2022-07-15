import 'package:flutter/material.dart';
import 'package:start_app/screens/home/event/event_screen.dart';
import 'package:start_app/screens/home/festival/festival_screen.dart';
import 'package:start_app/screens/home/info/info_screen.dart';
import 'package:start_app/screens/home/plan/plan_screen.dart';
import 'package:start_app/screens/home/rent/rent_screen.dart';
import 'package:start_app/screens/home/status/status_screen.dart';
import 'package:start_app/widgets/main_widget.dart';

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
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () => {
              // TODO
            },
            icon: Icon(Icons.person_outline),
            color: Colors.black,
            iconSize: 40,
          )
        ],
      ),
      body: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          MainWidget(
              title: "이벤트 참여",
              icon: Icon(Icons.info),
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EventScreen()))
                  }),
          MainWidget(
              title: "축제",
              icon: Icon(Icons.info),
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FestivalScreen()))
                  }),
          MainWidget(
              title: "상시사업",
              icon: Icon(Icons.info),
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RentScreen()))
                  }),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          MainWidget(
              title: "총학생회 설명",
              icon: Icon(Icons.info),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InfoScreen()))
              }),
          MainWidget(
              title: "학사일정",
              icon: Icon(Icons.info),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlanScreen()))
              }),
          MainWidget(
              title: "재학생/자치회비\n확인",
              icon: Icon(Icons.info),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatusScreen()))
              }),
        ])
      ]),
    );
  }
}
