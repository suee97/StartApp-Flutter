import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/utils/common.dart';
import 'package:http/http.dart' as http;
import '../../../models/status_code.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  List<String> studentInfo = [];

  @override
  void initState() {
    fetchStudentInfo();
    super.initState();
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "재학생 확인 및 자치회비 납부 확인",
          style: Common.startAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: HexColor("#f3f3f3"),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
          child: FutureBuilder(
              future: fetchStudentInfo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == StatusCode.SUCCESS) {
                  return statusCard(studentInfo[4], studentInfo[0],
                      studentInfo[1], studentInfo[2], studentInfo[3]);
                }
                if (snapshot.data == StatusCode.SERVER_ERROR) {
                  return Column(
                    children: [
                      statusCard("정보를 불러오지 못했습니다.", "", "", "", ""),
                    ],
                  );
                }
                if (snapshot.data == StatusCode.UNCATCHED_ERROR) {
                  return Column(
                    children: [
                      statusCard("정보를 불러오지 못했습니다.", "", "", "", ""),
                    ],
                  );
                }
                if (snapshot.data == StatusCode.TIMEOUT_ERROR) {
                  return Column(
                    children: [
                      statusCard("정보를 불러오지 못했습니다.", "", "", "", ""),
                    ],
                  );
                }
                if (snapshot.data == StatusCode.CONNECTION_ERROR) {
                  return Column(
                    children: [
                      statusCard("정보를 불러오지 못했습니다.", "", "", "", ""),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                          child: Platform.isIOS
                              ? CupertinoActivityIndicator()
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: HexColor("#425c5a"),
                                  ),
                                )),
                    ],
                  );
                }
              })
          //statusCard("학생회비 납부자","조인혁","16161616","공과대학","컴퓨터공학과"),
          ),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  Widget statusCard(String isPaid, String name, String studentNo, String group,
      String department) {
    return Container(
        width: 320.w,
        height: 550.h,
        color: Colors.transparent,
        child: Stack(
          children: [
            isPaid == "학생회비 납부자"
                ? SvgPicture.asset(
                    "assets/card_payer.svg",
                    fit: BoxFit.fill,
                  )
                : SvgPicture.asset(
                    "assets/card_unpaid.svg",
                    fit: BoxFit.fill,
                  ),
            Column(
              children: [
                SizedBox(
                  height: 366.h,
                ),
                Container(
                  width: 320.w,
                  height: 184.h,
                  decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  padding: EdgeInsets.only(top: 27.h, left: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isPaid,
                        style: TextStyle(
                            fontSize: 21.5.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 15.5.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        studentNo,
                        style: TextStyle(fontSize: 13.5.sp),
                      ),
                      Text(
                        group,
                        style: TextStyle(fontSize: 13.5.sp),
                      ),
                      Text(
                        department,
                        style: TextStyle(fontSize: 13.5.sp),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  Future<StatusCode> fetchStudentInfo() async {
    Map<String, dynamic> resData = {};

    final secureStorage = FlutterSecureStorage();
    var ACCESS_TOKEN = await secureStorage.read(key: "ACCESS_TOKEN");

    try {
      // 여기 refresh token 고려한 로직도 넣어야 함
      var resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/member"), headers: {
        "Authorization": "Bearer $ACCESS_TOKEN"
      }).timeout(const Duration(seconds: 10));
      resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 200) {
        List<dynamic> data = resData["data"];

        print(resData["data"]);

        List<String> _studentInfo = [];

        for (var e in data) {
          _studentInfo.add(e["name"]);
          _studentInfo.add(e["studentNo"]);
          _studentInfo.add(e["studentStatus"]); //단과대
          _studentInfo.add(e["department"]);
          if (e["memberShip"]) {
            _studentInfo.add("학생회비 납부");
          } else {
            _studentInfo.add("학생회비 미납부");
          }
        }

        studentInfo = _studentInfo;

        return StatusCode.SUCCESS;
      }

      if (resData["status"] == 500) {
        return StatusCode.SERVER_ERROR;
      }

      if (resData["status"] != 200) {
        return StatusCode.UNCATCHED_ERROR;
      }

      return StatusCode.UNCATCHED_ERROR;
    } on TimeoutException catch (e) {
      return StatusCode.TIMEOUT_ERROR;
    } on SocketException catch (e) {
      return StatusCode.CONNECTION_ERROR;
    } catch (e) {
      return StatusCode.UNCATCHED_ERROR;
    }
  }
}
