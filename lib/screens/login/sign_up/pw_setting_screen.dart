import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/sign_up_notifier.dart';
import 'dart:io' show Platform;
import 'package:start_app/screens/login/sign_up/post_certificate_screen.dart';
import 'package:start_app/utils/common.dart';

class PwSettingScreen extends StatefulWidget {
  const PwSettingScreen({Key? key}) : super(key: key);

  @override
  State<PwSettingScreen> createState() => _PwSettingScreenState();
}

class _PwSettingScreenState extends State<PwSettingScreen> {
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
    return Consumer<SignUpNotifier>(builder: (context, signUpNotifier, child) {
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
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 21.h),
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
                      "회원가입",
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
                      "영어 대소문자, 숫자, 특수문를 각 1개 이상 사용",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBox(
                  height: 290.h,
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
                      GestureDetector(
                        onTap: () {
                          if (appPwController_1.text !=
                              appPwController_2.text) {
                            Common.showSnackBar(
                                context, "비밀번호 입력이 동일한지 확인해주세요.");
                            return;
                          }

                          signUpNotifier.setAppPassword(appPwController_1.text);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PostCertificateScreen()));
                        },
                        child: Container(
                            width: 304.w,
                            height: 54.h,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: HexColor("#f3f3f3"),
        ),
      );
    });
  }
}
