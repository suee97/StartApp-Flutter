import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_app/models/status_code.dart';
import 'package:start_app/screens/login/sign_up/signup_screen.dart';
import '../../../widgets/test_button.dart';

class CheckInfoScreen extends StatefulWidget {
  const CheckInfoScreen({Key? key}) : super(key: key);

  @override
  State<CheckInfoScreen> createState() => _CheckInfoScreenState();
}

class _CheckInfoScreenState extends State<CheckInfoScreen> {
  bool isPolicyAgree = false;

  @override
  void initState() {
    getUserDataAndCheckStudentId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Text(
            "회원가입",
            style: TextStyle(fontSize: 25.5.sp, fontWeight: FontWeight.w600),
          ),
          Text(
            "본인의 정보를 확인해주세요.",
            style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600),
          ),
          Container(
            width: 300.w,
            height: 200.h,
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("이름: 홍길동",
                    style: TextStyle(
                        fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 10.h),
                Text("학과: ITM전공",
                    style: TextStyle(
                        fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 10.h),
                Text("학번: 19102020",
                    style: TextStyle(
                        fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 10.h),
                Text("휴대전화: 010-1234-1234",
                    style: TextStyle(
                        fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 10.h),
                Text("이메일: hong1004@naver.com",
                    style: TextStyle(
                        fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(children: [
                  Text(
                    "개인정보 동의 약관",
                    style: TextStyle(
                        fontSize: 12.5.sp, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "자세히 보기 >",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 10.5.sp,
                            fontWeight: FontWeight.w400),
                      ))
                ]),
                Row(children: [
                  Checkbox(
                      value: isPolicyAgree,
                      onChanged: (value) {
                        setState(() {
                          isPolicyAgree = value!;
                        });
                      }),
                  Text("위 정보를 ST’art 어플에서 사용하는 것에 동의",
                      style: TextStyle(fontSize: 10.sp)),
                ])
              ],
            ),
          ),
          TestButton(
              title: "확인",
              onPressed: () => {
                    // Common.setNonLogin(true),
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignupScreen()))
                  })
        ])));
  }

  Future<StatusCode> getUserDataAndCheckStudentId() async {
    // 기존 pref 불러오기
    final pref = await SharedPreferences.getInstance();
    String? key = pref.getString("uuidKey");
    if (key == null) {
      return StatusCode.UNCATCHED_ERROR;
    }
    String? studentId = pref.getString("studentId");
    if (studentId == null) {
      return StatusCode.UNCATCHED_ERROR;
    }

    print("uuidKey 로드 : $key");
    print("studentId 로드 : $studentId");

    // 기존 키로 요청하기
    Map<String, dynamic> resData = {};

    try {
      var resString = await http
          .get(
            Uri.parse(
                "${dotenv.get("DEV_API_BASE_URL")}/auth/seoultech/check?key=$key"),
          )
          .timeout(const Duration(seconds: 10));
      resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] != 200) {
        return StatusCode.UNCATCHED_ERROR;
      }

      // 학번 일치하는지 확인하기
      var decodedString =
          utf8.decode(base64.decode(resData["data"][0]["jsonValue"]));
      String afterId = jsonDecode(decodedString)["STNT_NUMB"];

      if (studentId.toString() == afterId.toString()) {
        return StatusCode.SUCCESS;
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
