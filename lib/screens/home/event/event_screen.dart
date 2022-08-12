import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/event/detail/event_detail_screen.dart';
import 'package:start_app/screens/home/event/event_tile.dart';
import '../../../models/event_list.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform, SocketException;
import 'package:flutter/cupertino.dart';
import '../../../utils/common.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    fetchEventList();
    super.initState();
  }

  Widget BranchByEventStatus(Event event) {
    if (event.eventStatus == "PROCEEDING") {
      return EventDetailScreen(
        event: event,
        mainColorHex: "#425C5A",
        buttonHexColor: "FFCEA2",
        buttonTitle: "신청하기",
      );
    } else if (event.eventStatus == "BEFORE") {
      return EventDetailScreen(
        event: event,
        mainColorHex: "#9AA695",
        buttonHexColor: "#F8EAE1",
        buttonTitle: Common.calDday(event.startTime),
      );
    } else {
      return EventDetailScreen(
        event: event,
        mainColorHex: "#8E908E",
        buttonHexColor: "#EBE4DE",
        buttonTitle: "마감된 이벤트입니다",
      );
    }
  }

  Future<List<Event>> fetchEventList() async {
    try {
      var resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/event"))
          .timeout(const Duration(seconds: 10));
      Map<String, dynamic> resData =
          jsonDecode(utf8.decode(resString.bodyBytes));

      List<Event> _eventList = [];
      List<Event> _tempList = [];
      if (resData["data"] != null) {
        /// not null
        List<dynamic> data = resData["data"];
        for (var e in data) {
          if (e["eventStatus"] == "END") _eventList.add(Event.fromJson(e));
        }
        for (var e in data) {
          if (e["eventStatus"] == "BEFORE") _tempList.add(Event.fromJson(e));
        }
        _eventList = _eventList + _tempList.reversed.toList();
        for (var e in data) {
          if (e["eventStatus"] == "PROCEEDING") {
            _eventList.add(Event.fromJson(e));
          }
        }
      } else {
        /// null
        print("${resData["status"]}");
        return Future.error("");
      }

      return _eventList.reversed.toList();
    } on TimeoutException catch (e) {
      return Future.error("TimeoutException : $e");
    } on SocketException catch (e) {
      return Future.error("SocketException : $e");
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
        centerTitle: true,
        title: Text(
          "서울과학기술대학교 총학생회",
          style: Common.startAppBarTextStyle,
        ),
      ),
      body: Container(
          color: HexColor("#f3f3f3"),
          child: Container(
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
                        fontSize: 21.5.sp,
                        fontWeight: FontWeight.w600,
                        color: HexColor("#D8E8E7")),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                FutureBuilder(
                  future: fetchEventList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData && snapshot.data.length != 0) {
                      return Expanded(
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
                                                  BranchByEventStatus(
                                                      snapshot.data[index])))
                                    });
                          },
                        ),
                      );
                    } else if (snapshot.hasData && snapshot.data.length == 0) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 120.h,
                          ),
                          Container(
                            width: 132.w,
                            child: const Image(
                                fit: BoxFit.fitWidth,
                                image:
                                    AssetImage("images/logo_wink_ready.png")),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            "현재 진행중인\n이벤트가 없습니다.",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: const Color.fromARGB(128, 216, 232, 231),
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 120.h,
                          ),
                          Container(
                            width: 132.w,
                            child: Image(
                              fit: BoxFit.fitWidth,
                              image: AssetImage("images/logo_crying_ready.png"),
                              color: Colors.white.withOpacity(0.5),
                              colorBlendMode: BlendMode.modulate,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "이벤트를 불러오지 못했습니다.",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: const Color.fromARGB(128, 216, 232, 231),
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            height: 200.h,
                          ),
                          Platform.isIOS
                              ? CupertinoActivityIndicator(
                                  color: HexColor("#f3f3f3"),
                                  radius: 12,
                                )
                              : CircularProgressIndicator(
                                  color: HexColor("#f3f3f3"),
                                ),
                        ],
                      );
                    }
                  },
                )
              ]))),
    );
  }
}
