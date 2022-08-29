import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/login/login_screen.dart';
import '../../../utils/common.dart';

class PwResetScreen extends StatefulWidget {
  PwResetScreen({Key? key, required this.studentId}) : super(key: key);

  String studentId;

  @override
  State<PwResetScreen> createState() => _PwResetScreenState();
}

class _PwResetScreenState extends State<PwResetScreen> {
  final appPwController_1 = TextEditingController();
  final appPwController_2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    appPwController_1.dispose();
    appPwController_2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 260.h,
                  child: const Center(
                    child: Image(
                      image: AssetImage("images/logo_app.png"),
                    ),
                  ),
                ),
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
                Row(
                  children: [
                    SizedBox(
                      width: 28.w,
                    ),
                    Text(
                      "ST'art 어플에서 사용할 비밀번호를 설정해주세요.",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 28.w,
                    ),
                    Text(
                      "특수문자, 대소문자, 숫자 포함\n8자 이상 15자 이내로 입력해주세요.",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(
                  height: 240.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 28.w,
                          ),
                          Text(
                            "비밀번호",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w300,
                                color: HexColor("#425c5a")),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 28.w, right: 28.w),
                          child: SizedBox(
                            height: 30.h,
                            child: TextField(
                              controller: appPwController_1,
                              cursorColor: HexColor("#425C5A"),
                              maxLines: 1,
                              enableSuggestions: false,
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: 17.5.sp,
                                  fontWeight: FontWeight.w300),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor("#425c5a")),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor("#425c5a")),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 28.w,
                          ),
                          Text(
                            "비밀번호 확인",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w300,
                                color: HexColor("#425c5a")),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 28.w, right: 28.w),
                          child: SizedBox(
                            height: 30.h,
                            child: TextField(
                              controller: appPwController_2,
                              cursorColor: HexColor("#425C5A"),
                              maxLines: 1,
                              enableSuggestions: false,
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: 17.5.sp,
                                  fontWeight: FontWeight.w300),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor("#425c5a")),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor("#425c5a")),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 28.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                String pw1 = appPwController_1.text;
                String pw2 = appPwController_2.text;

                /// 비어있는지 확인
                if (pw1.isEmpty || pw2.isEmpty) {
                  Common.showSnackBar(context, "비어있는 필드가 있는지 확인해주세요.");
                  return;
                }

                /// 같은지 확인
                if (pw1 != pw2) {
                  Common.showSnackBar(context, "비밀번호 입력이 동일한지 확인해주세요.");
                  return;
                }

                /// 유효성 검사 (특수문자, 대소문자, 숫자 포함 8자 이상 16자 이내)
                final validationResult = RegExp(
                        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,16}$')
                    .hasMatch(pw1);
                if (!validationResult) {
                  Common.showSnackBar(context,
                      "비밀번호를 다음과 같이 맞춰주세요.\n특수문자, 대소문자, 숫자 포함 8자 이상 16자 이내");
                  return;
                }

                final resetPwResult = await resetPw(pw1);
                if(resetPwResult == PwResetNonLoginCode.ST066) {
                  if(!mounted) return;
                  Common.showSnackBar(context,
                      "오류가 발생했습니다.");
                  return;
                }
                if(resetPwResult == PwResetNonLoginCode.UNCATCHED_ERROR) {
                  if(!mounted) return;
                  Common.showSnackBar(context,
                      "오류가 발생했습니다.");
                  return;
                }
                if(resetPwResult == PwResetNonLoginCode.SUCCESS) {
                  if(!mounted) return;
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                  Common.showSnackBar(context,
                      "비밀번호 설정이 완료되었습니다. 로그인해주세요.");
                  return;
                }
                if(!mounted) return;
                Common.showSnackBar(context,
                    "오류가 발생했습니다.");
                return;
              },
              child: Container(
                  width: double.infinity,
                  height: 54.h,
                  margin: EdgeInsets.only(left: 27.w, right: 27.w, top: 570.h),
                  decoration: BoxDecoration(
                      color: HexColor("#425C5A"),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: Text(
                    "다음",
                    style: TextStyle(
                        fontSize: 19.5.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
            ),
          ]),
        ),
        backgroundColor: HexColor("#f3f3f3"),
      ),
    );
  }

  Future<PwResetNonLoginCode> resetPw(String pw) async {
    Map bodyData = {"password": pw, "studentNo": widget.studentId};

    try {
      final resString = await http
          .patch(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/member/password"),
              headers: {"Content-Type": "application/json"},
              body: json.encode(bodyData))
          .timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));
      debugPrint(resData.toString());
      if (resData["status"] == 200) {
        return PwResetNonLoginCode.SUCCESS;
      }
      if (resData["errorCode"] == "ST066") {
        return PwResetNonLoginCode.ST066;
      }

      return PwResetNonLoginCode.UNCATCHED_ERROR;
    } catch (e) {
      debugPrint(e.toString());
      return PwResetNonLoginCode.UNCATCHED_ERROR;
    }
  }
}

enum PwResetNonLoginCode { SUCCESS, ST066, UNCATCHED_ERROR }