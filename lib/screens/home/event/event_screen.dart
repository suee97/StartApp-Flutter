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

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy
    final List<Event> _eventListDummy = [
      Event(
          1,
          "그때 그 시절",
          "https://docs.google.com/forms/d/e/1FAIpQLSe0NjSatm6bLuJHayA8BSNOEnCdQ6RxjRgJRFO_85Q6f4A8yg/viewform",
          "https://img",
          "#ffff00",
          "2022-08-05T22:23:21.159220",
          "2022-08-06T22:23:21.159220",
          false),
      Event(
          2,
          "축제 미션 올 클리어",
          "https://docs.google.com/forms/d/e/1FAIpQLSe0NjSatm6bLuJHayA8BSNOEnCdQ6RxjRgJRFO_85Q6f4A8yg/viewform",
          "https://img",
          "#ff12ff",
          "2022-07-13T22:23:21.159220",
          "2022-07-22T22:23:21.159220",
          false),
      Event(
          3,
          "어의체전",
          "https://docs.google.com/forms/d/e/1FAIpQLSe0NjSatm6bLuJHayA8BSNOEnCdQ6RxjRgJRFO_85Q6f4A8yg/viewform",
          "https://img",
          "#f45fff",
          "2022-07-05T22:23:21.159220",
          "2022-07-10T22:23:21.159220",
          true),
      Event(
          3,
          "무엇이든 물어보살",
          "https://docs.google.com/forms/d/e/1FAIpQLSe0NjSatm6bLuJHayA8BSNOEnCdQ6RxjRgJRFO_85Q6f4A8yg/viewform",
          "https://img",
          "#f45fff",
          "2022-07-05T22:23:21.159220",
          "2022-07-10T22:23:21.159220",
          true),
      Event(
          3,
          "그때 그 시절",
          "https://docs.google.com/forms/d/e/1FAIpQLSe0NjSatm6bLuJHayA8BSNOEnCdQ6RxjRgJRFO_85Q6f4A8yg/viewform",
          "https://img",
          "#f45fff",
          "2022-07-05T22:23:21.159220",
          "2022-07-10T22:23:21.159220",
          true),
      Event(3, "그때 그 시절", "https://form", "https://img", "#f45fff",
          "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
      Event(3, "그때 그 시절", "https://form", "https://img", "#f45fff",
          "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
      Event(3, "그때 그 시절", "https://form", "https://img", "#f45fff",
          "2022-07-05T22:23:21.159220", "2022-07-10T22:23:21.159220", true),
    ]; /// Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy Dummy


    /// Network Network Network Network Network Network Network Network
    Future<List<Event>> fetchEventList() async {
      try {
        var resString = await http.get(Uri.parse(dotenv.get('API_BASE_URL')));
        Map<String, dynamic> resData = jsonDecode(resString.body);
        var statusCode = resData['status'];
        var message = resData['message'];

        if (statusCode == 400) {
          return Future.error(
              "#### status code : $resData\n#### message : $message");
        } else {
          return resData['data'];
        }
      } catch (e) {
        return Future.error(e);
      }
    }
    /// Network Network Network Network Network Network Network Network

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("#f3f3f3"),
        foregroundColor: Colors.black,
        title: const Text("서울과학기술대학교 총학생회"),
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
                itemCount: _eventListDummy.length,
                itemBuilder: (context, index) {
                  return EventTile(
                      event: _eventListDummy[index],
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventDetailScreen(
                                        event: _eventListDummy[index])))
                          });
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class EventLoadingScreen extends StatelessWidget {
  const EventLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const Center(
        child: CupertinoActivityIndicator(
          radius: 12,
          color: Colors.white,
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
  }
}
