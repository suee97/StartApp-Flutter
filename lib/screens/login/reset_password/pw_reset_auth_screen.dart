import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/login/login_widgets.dart';
import 'package:start_app/screens/login/reset_password/pw_reset_screen.dart';
import 'package:start_app/utils/common.dart';

class PwResetAuthScreen extends StatefulWidget {
  const PwResetAuthScreen({Key? key}) : super(key: key);

  @override
  State<PwResetAuthScreen> createState() => _PwResetAuthScreenState();
}

class _PwResetAuthScreenState extends State<PwResetAuthScreen> {
  final studentIdController = TextEditingController();
  final codeController = TextEditingController();
  bool studentIdActive = true;
  bool authCodeActive = false;
  bool nextButtonActive = false;

  @override
  void dispose() {
    studentIdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
        appBar: Common.SignUpAppBar("비밀번호 재설정"),
        body: Stack(
          children: [
            SingleChildScrollView(
              reverse: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 102.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200.h,
                    child: const Center(
                      child: Image(
                        image: AssetImage("images/logo_app.png"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w),
                    child: Text(
                      "비밀번호 재설정",
                      style: TextStyle(
                          fontSize: 21.5.sp,
                          fontWeight: FontWeight.w600,
                          color: HexColor("#425C5A")),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w),
                    child: Text(
                      "비밀번호 재설정을 위해 가입된 계정의 학번을 입력해주세요.\n인증요청을 누르면 학번으로 가입된 계정의 휴대전화 번호로 인증코드가 발송됩니다.\n인증코드는 3분 내로 입력해주세요.",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          height: 1.25),
                    ),
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  textFiledTitleRowWidget("학번"),
                  Padding(
                      padding: EdgeInsets.only(left: 28.w, right: 28.w),
                      child: SizedBox(
                        height: 30.h,
                        child: TextField(
                          controller: studentIdController,
                          keyboardType: TextInputType.number,
                          cursorColor: HexColor("#425C5A"),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLines: 1,
                          enableSuggestions: false,
                          style: TextStyle(
                              fontSize: 17.5.sp, fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: studentIdActive == true
                                  ? phoneAuthButton("인증요청", () async {
                                      final id = studentIdController.text;
                                      if (id.length != 8) {
                                        Common.showSnackBar(
                                            context, "올바른 학번을 입력해주세요.");
                                        return;
                                      }
                                      final postSmsByIdResult =
                                          await postSmsById(id);
                                      if (postSmsByIdResult ==
                                          PostSmsByIdCode.SUCCESS) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "인증번호가 발송되었습니다.");
                                        setState(() {
                                          studentIdActive = false;
                                          authCodeActive = true;
                                        });
                                        return;
                                      }
                                      if (postSmsByIdResult ==
                                          PostSmsByIdCode.ST041) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "등록된 학번이 아닙니다.");
                                        return;
                                      }
                                      if (postSmsByIdResult ==
                                          PostSmsByIdCode.ST057) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "인증 대기중인 학번입니다.");
                                        return;
                                      }
                                      if (postSmsByIdResult ==
                                          PostSmsByIdCode.ST065) {
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "너무 많은 요청을 보냈습니다. 잠시 후 다시 시도해주세요.");
                                        return;
                                      }
                                      if (postSmsByIdResult ==
                                          PostSmsByIdCode.ST058) {
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "탈퇴한 계정입니다. 재가입시 문의해주세요. (02-970-7012)");
                                        return;
                                      }
                                      if (!mounted) return;
                                      Common.showSnackBar(
                                          context, "오류가 발생했습니다.");
                                    }, HexColor("#EE795F"))
                                  : phoneAuthButton(
                                      "인증요청", () {}, HexColor("#F9B7A9")),
                            ),
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
                  textFiledTitleRowWidget("인증코드"),
                  Padding(
                      padding: EdgeInsets.only(left: 28.w, right: 28.w),
                      child: SizedBox(
                        height: 30.h,
                        child: TextField(
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          cursorColor: HexColor("#425C5A"),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLines: 1,
                          enableSuggestions: false,
                          style: TextStyle(
                              fontSize: 17.5.sp, fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: authCodeActive == true
                                  ? phoneAuthButton("확인", () async {
                                      final id = studentIdController.text;
                                      final code = codeController.text;
                                      if (code.length != 6) {
                                        Common.showSnackBar(
                                            context, "올바른 인증코드를 입력해주세요.");
                                        return;
                                      }

                                      final checkPassWordAuthCodeResult =
                                          await checkPassWordAuthCode(id, code);
                                      if (checkPassWordAuthCodeResult ==
                                          PostSmsByIdCode.ST066) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "인증 정보가 일치하지 않습니다.");
                                        return;
                                      }
                                      if (checkPassWordAuthCodeResult ==
                                          PostSmsByIdCode.ST067) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "시간이 초과했습니다. 다시 요청해주세요.");
                                        setState(() {
                                          authCodeActive = false;
                                          studentIdActive = true;
                                        });
                                        return;
                                      }
                                      if (checkPassWordAuthCodeResult ==
                                          PostSmsByIdCode.SUCCESS) {
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "인증에 성공했습니다. 다음으로 이동해주세요.");
                                        setState(() {
                                          authCodeActive = false;
                                          nextButtonActive = true;
                                        });
                                        return;
                                      }
                                      if (checkPassWordAuthCodeResult ==
                                          PostSmsByIdCode.UNCATCHED_ERROR) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "오류가 발생했습니다.");
                                        return;
                                      }
                                      if (!mounted) return;
                                      Common.showSnackBar(
                                          context, "오류가 발생했습니다.");
                                      return;
                                    }, HexColor("#EE795F"))
                                  : phoneAuthButton(
                                      "확인", () {}, HexColor("#F9B7A9")),
                            ),
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
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: nextButtonActive == true
                  ? LoginNavButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PwResetScreen(
                                      studentId: studentIdController.text,
                                    )));
                      },
                      title: "다음",
                      colorHex: "#425C5A",
                      margin: EdgeInsets.only(bottom: 16.h),
                      width: 304.w)
                  : LoginNavButton(
                      onPressed: () {},
                      title: "다음",
                      colorHex: "#929d9c",
                      margin: EdgeInsets.only(bottom: 16.h),
                      width: 304.w),
            )
          ],
        ),
        backgroundColor: HexColor("#f3f3f3"),
      ),
    );
  }

  Future<PostSmsByIdCode> checkPassWordAuthCode(String id, String code) async {
    Map bodyData = {"studentNo": id, "code": code};

    try {
      final resString = await http
          .post(
              Uri.parse(
                  "${dotenv.get("DEV_API_BASE_URL")}/auth/sms/password/check"),
              headers: {"Content-Type": "application/json"},
              body: json.encode(bodyData))
          .timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));
      debugPrint(resData.toString());
      if (resData["status"] == 200) {
        return PostSmsByIdCode.SUCCESS;
      }
      if (resData["errorCode"] == "ST066") {
        return PostSmsByIdCode.ST066;
      }
      if (resData["errorCode"] == "ST067") {
        return PostSmsByIdCode.ST067;
      }
      return PostSmsByIdCode.UNCATCHED_ERROR;
    } catch (e) {
      return PostSmsByIdCode.UNCATCHED_ERROR;
    }
  }

  Future<PostSmsByIdCode> postSmsById(String studentNo) async {
    Map bodyData = {"studentNo": studentNo};

    try {
      final resString = await http
          .post(
              Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth/sms/password"),
              headers: {"Content-Type": "application/json"},
              body: json.encode(bodyData))
          .timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));
      debugPrint(resData.toString());
      if (resData["status"] == 200) {
        return PostSmsByIdCode.SUCCESS;
      }
      if (resData["errorCode"] == "ST041") {
        return PostSmsByIdCode.ST041;
      }
      if (resData["errorCode"] == "ST057") {
        return PostSmsByIdCode.ST057;
      }
      if (resData["errorCode"] == "ST058") {
        return PostSmsByIdCode.ST058;
      }

      return PostSmsByIdCode.UNCATCHED_ERROR;
    } catch (e) {
      debugPrint(e.toString());
      return PostSmsByIdCode.UNCATCHED_ERROR;
    }
  }

  Widget textFiledTitleRowWidget(String title) {
    return Row(
      children: [
        SizedBox(
          width: 28.w,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w300,
              color: HexColor("#425c5a")),
        ),
      ],
    );
  }

  Widget phoneAuthButton(String title, VoidCallback onPressed, Color color) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80.w,
        height: 30.h,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ),
    );
  }
}

enum PostSmsByIdCode {
  SUCCESS,
  ST041,
  ST057,
  ST058,
  ST065,
  ST066,
  ST067,
  UNCATCHED_ERROR
}
