import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/event/detail/event_detail_screen.dart';
import 'package:start_app/screens/home/event/event_tile.dart';
import '../../../models/event_list.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late bool isLoading;

  @override
  void initState() {
    isLoading = true;
    fetchEventList();
    super.initState();
  }

  Future<List<Event>> fetchEventList() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      var resString =
          await http.get(Uri.parse("${dotenv.get("LOCAL_API_BASE_URL")}/list"));
      Map<String, dynamic> resData = jsonDecode(resString.body);
      List<dynamic> data = resData["data"];
      List<Event> _eventList = [];
      _eventList = data.map((e) => Event.fromJson(e)).toList();

      if (resData["status"] == 404) {
        return Future.error(
            "#### status code : ${resData["status"]}\n#### message : ${resData["message"]}");
      } else {
        return _eventList;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("#f3f3f3"),
        foregroundColor: Colors.black,
        title: const Text("서울과학기술대학교 총학생회"),
      ),
      body: Container(
        color: HexColor("#f3f3f3"),
        child: FutureBuilder(
          future: fetchEventList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data.length != 0) {
              return Container(
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
                    SizedBox(
                      height: 13.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return EventTile(
                              event: snapshot.data[index],
                              onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EventDetailScreen(
                                                    event:
                                                        snapshot.data[index])))
                                  });
                        },
                      ),
                    )
                  ]));
            } else if (snapshot.hasData && snapshot.data.length == 0) {
              return Text("진행중인 이벤트가 없습니다.");
            } else if (snapshot.hasData == false) {
              return Container(
                decoration: BoxDecoration(
                    color: HexColor("#425C5A"),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Platform.isIOS
                        ? CupertinoActivityIndicator(
                            color: HexColor("#f3f3f3"),
                            radius: 12,
                          )
                        : CircularProgressIndicator(
                            color: HexColor("#f3f3f3"),
                          ),
                  ),
                ),
              );
            } else {
              return Text("에러 발생");
            }
          },
        ),
      ),
    );
  }
}
