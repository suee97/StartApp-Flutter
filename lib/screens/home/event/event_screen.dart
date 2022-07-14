import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/event_notifier.dart';
import 'package:start_app/screens/home/event/detail/event_detail_screen.dart';
import 'package:start_app/screens/home/event/event_tile.dart';

/// 이곳에서 컨슘 하고 디테일스크린에는 파라미터로 보낼 예정

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EventNotifier>(builder: (context, eventNotifier, child) {
      var eventList = eventNotifier.getEvents();

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text("서울과학기술대학교 총학생회"),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: HexColor("#425C5A"),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Column(children: <Widget>[
            SizedBox(
              height: 23.h,
            ),
            Container(
              margin: const EdgeInsets.only(left: 26),
              width: double.infinity,
              child: Text(
                "이벤트 참여",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#92AEAC")),
              ),
            ),
            SizedBox(height: 13.h,),
            Expanded(
              child: ListView.builder(
                itemCount: eventList.length,
                itemBuilder: (context, index) {
                  return EventTile(
                      event: eventList[index],
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventDetailScreen(
                                        event: eventList[index])))
                          });
                },
              ),
            )
          ]),
        ),
      );
    });
  }
}
