import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/login/login_option_screen.dart';
import 'package:start_app/screens/login/login_widgets.dart';
import 'package:start_app/utils/common.dart';
import 'package:http/http.dart' as http;
import '../../../models/status_code.dart';
import '../../../utils/auth.dart';

class PwChangeScreen extends StatefulWidget {
  const PwChangeScreen({Key? key}) : super(key: key);

  @override
  State<PwChangeScreen> createState() => _PwChangeScreenState();
}

class _PwChangeScreenState extends State<PwChangeScreen> {
  final beforeAppPwController = TextEditingController();
  final afterAppPwController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "비밀번호 재설정",
          style: Common.startAppBarTextStyle,
        ),
        foregroundColor: HexColor("#425C5A"),
        backgroundColor: HexColor("#f3f3f3"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 28.w,
              ),
              Text(
                "비밀번호 재설정",
                style: TextStyle(
                    fontSize: 21.5.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#425c5a")),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.w),
            child: Text(
              "특수문자, 대소문자, 숫자 포함\n8자 이상 15자 이내로 입력해주세요.",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.w),
            child: Text(
              "기존 비밀번호",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w300,
                  color: HexColor("#425c5a")),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 28.w, right: 28.w),
              child: SizedBox(
                height: 30.h,
                child: TextField(
                  controller: beforeAppPwController,
                  cursorColor: HexColor("#425C5A"),
                  maxLines: 1,
                  enableSuggestions: false,
                  obscureText: true,
                  style:
                      TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#425c5a")),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#425c5a")),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.w),
            child: Text(
              "변경할 비밀번호",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w300,
                  color: HexColor("#425c5a")),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 28.w, right: 28.w),
              child: SizedBox(
                height: 30.h,
                child: TextField(
                  controller: afterAppPwController,
                  cursorColor: HexColor("#425C5A"),
                  maxLines: 1,
                  enableSuggestions: false,
                  obscureText: true,
                  style:
                      TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#425c5a")),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#425c5a")),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 27.w, right: 27.w),
            child: LoginNavButton(
                onPressed: () async {
                  if (afterAppPwController.text.isEmpty ||
                      beforeAppPwController.text.isEmpty) {
                    Common.showSnackBar(context, "비어있는 필드가 있는지 확인해주세요.");
                    return;
                  }

                  if (afterAppPwController.text == beforeAppPwController.text) {
                    Common.showSnackBar(
                        context, "변경할 비밀번호를 기존 비밀번호와 다르게 설정해주세요.");
                    return;
                  }

                  final validationResult = RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,16}$')
                      .hasMatch(afterAppPwController.text);
                  if (!validationResult) {
                    Common.showSnackBar(context,
                        "비밀번호를 다음과 같이 맞춰주세요.\n특수문자, 대소문자, 숫자 포함 8자 이상 16자 이내");
                    return;
                  }

                  final changePwResult = await changePw();
                  if (changePwResult == StatusCode.REFRESH_EXPIRED) {
                    final secureStorage = FlutterSecureStorage();
                    await secureStorage.write(key: "ACCESS_TOKEN", value: "");
                    await secureStorage.write(key: "REFRESH_TOKEN", value: "");
                    await Common.setNonLogin(false);
                    await Common.setAutoLogin(false);
                    Common.setIsLogin(false);
                    await Common.clearStudentInfoPref();
                    if (!mounted) return;
                    Common.showSnackBar(context, "다시 로그인해주세요.");
                    return;
                  }
                  if (changePwResult == StatusCode.REQUEST_ERROR) {
                    if (!mounted) return;
                    Common.showSnackBar(context, "패스워드가 일치하지 않습니다. 확인해주세요.");
                    return;
                  }
                  if (changePwResult == StatusCode.UNCATCHED_ERROR ||
                      changePwResult != StatusCode.SUCCESS) {
                    if (!mounted) return;
                    Common.showSnackBar(context, "오류가 발생했습니다.");
                    return;
                  }
                  // 성공 케이스
                  if (!mounted) return;
                  Common.showSnackBar(context, "변경이 완료되었습니다. 다시 로그인해주세요.");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginOptionScreen()),
                      (route) => false);
                  return;
                },
                title: "변경하기",
                colorHex: "#425C5A",
                width: double.infinity),
          )
        ],
      ),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  Future<StatusCode> changePw() async {
    final authTokenAndReIssueResult = await Auth.authTokenAndReIssue();
    if (authTokenAndReIssueResult == StatusCode.REFRESH_EXPIRED) {
      return StatusCode.REFRESH_EXPIRED;
    }

    if (authTokenAndReIssueResult != StatusCode.SUCCESS) {
      return StatusCode.UNCATCHED_ERROR;
    }
    final AT = await Common.secureStorage.read(key: "ACCESS_TOKEN");

    Map bodyData = {
      "currentPassword": beforeAppPwController.text,
      "newPassword": afterAppPwController.text
    };

    try {
      final resString = await http
          .patch(
              Uri.parse(
                  "${dotenv.get("DEV_API_BASE_URL")}/member/login/password"),
              headers: {
                "Authorization": "Bearer $AT",
                "Content-Type": "application/json"
              },
              body: json.encode(bodyData))
          .timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));
      debugPrint(resData.toString());
      if (resData["status"] == 200) {
        return StatusCode.SUCCESS;
      }
      if (resData["errorCode"] == "ST050") {
        return StatusCode.REQUEST_ERROR;
      }

      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      debugPrint(e.toString());
      return StatusCode.UNCATCHED_ERROR;
    }
  }
}
