import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/rent/my_rent/rent_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform, SocketException;
import '../../../../models/rent_list.dart';
import '../../../../utils/common.dart';

class MyRentScreen extends StatefulWidget {
  const MyRentScreen({Key? key}) : super(key: key);

  @override
  State<MyRentScreen> createState() => _MyRentScreenState();
}

class _MyRentScreenState extends State<MyRentScreen> {
  @override
  void initState() {
    fetchRentList();
    super.initState();
  }

  Future<List<Rent>> fetchRentList() async {
    try {
      var resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/member/rent"))
          .timeout(const Duration(seconds: 10));
      Map<String, dynamic> resData =
          jsonDecode(utf8.decode(resString.bodyBytes));

      List<Rent> _rentList = [];
      List<Rent> _tempList = [];
      if (resData["data"] != null) {
        /// not null
        List<dynamic> data = resData["data"];
        for (var e in data) {
          if (e["rentStatus"] == "DENY") _rentList.add(Rent.fromJson(e));
        }
        for (var e in data) {
          if (e["rentStatus"] == "DONE") _tempList.add(Rent.fromJson(e));
        }
        for (var e in data) {
          if (e["rentStatus"] == "WAIT") _tempList.add(Rent.fromJson(e));
        }
        for (var e in data) {
          if (e["rentStatus"] == "CONFIRM") _tempList.add(Rent.fromJson(e));
        }

        _rentList = _rentList + _tempList.reversed.toList();

        for (var e in data) {
          if (e["rentStatus"] == "RENT") _rentList.add(Rent.fromJson(e));
        }
      } else {
        /// null
        return Future.error("");
      }

      return _rentList.reversed.toList();
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
        title: Text(
          "내 예약",
          style: Common.startAppBarTextStyle,
        ),
        backgroundColor: HexColor("#425C5A"),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(top: 55.h),
            decoration: BoxDecoration(
                color: HexColor("#f3f3f3"),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Container(
              padding: EdgeInsets.only(top: 72.h, left: 20.w, right: 20.w),
              child: Column(
                children: [
                  /// RENT TILE UI TEST
                  RentTile(
                      rent: Rent(1, "TABLE", "2022-08-05T22:23:21.159220",
                          "2022-08-07T22:23:21.159220", 5, "CONFIRM"),
                      onPressed: () {}),

                  /// RENT TILE UI TEST

                  FutureBuilder(
                    future: fetchRentList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData && snapshot.data.length != 0) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return RentTile(
                                  rent: snapshot.data[index],
                                  onPressed: () => {});
                            },
                          ),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data.length == 0) {
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
                              "예약된 물품이 없습니다.",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color:
                                      const Color.fromARGB(128, 216, 232, 231),
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
                                image:
                                    AssetImage("images/logo_crying_ready.png"),
                                color: Colors.white.withOpacity(0.5),
                                colorBlendMode: BlendMode.modulate,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "예약 정보를 불러오지 못했습니다.",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color:
                                      const Color.fromARGB(128, 216, 232, 231),
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
                  ),
                ],
              ),
            )),
        Container(
          width: 110.w,
          height: 110.w,
          margin: EdgeInsets.only(left: 38.w),
          decoration: BoxDecoration(
              color: HexColor("#f3f3f3"),
              shape: BoxShape.circle,
              border: Border.all(width: 9.w, color: HexColor("#f3f3f3"))),
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: HexColor("#425C5A"), shape: BoxShape.circle),
              child: SvgPicture.asset(
                "assets/icon_rent_person.svg",
                color: HexColor("#f3f3f3"),
                fit: BoxFit.fill,
              )),
        ),
        Container(
          width: 170.w,
          height: 90.h,
          margin: EdgeInsets.only(left: 160.w, top: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "오승언",
                    style: TextStyle(
                        fontSize: 17.5.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              myUserInfoText("19101686"),
              myUserInfoText("에너지바이오대학"),
              myUserInfoText("식품공학과"),
            ],
          ),
        )
      ]),
      backgroundColor: HexColor("#425C5A"),
    );
  }

  Widget myUserInfoText(String title) {
    return Text(
      title,
      style: TextStyle(
          color: HexColor("#5C7775"),
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w500),
    );
  }
}
