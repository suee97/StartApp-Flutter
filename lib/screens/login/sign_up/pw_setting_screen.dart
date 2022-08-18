import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io' show Platform;
import 'package:start_app/screens/login/sign_up/post_certificate_screen.dart';

class PwSettingScreen extends StatefulWidget {
  const PwSettingScreen({Key? key}) : super(key: key);

  @override
  State<PwSettingScreen> createState() => _PwSettingScreenState();
}

class _PwSettingScreenState extends State<PwSettingScreen> {
  final appPw1 = TextEditingController();
  final appPw2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    appPw1.dispose();
    appPw2.dispose();
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
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
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
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
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
                            controller: appPw1,
                            cursorColor: HexColor("#425C5A"),
                            maxLines: 1,
                            enableSuggestions: false,
                            obscureText: true,
                            style: TextStyle(
                                fontSize: 17.5.sp, fontWeight: FontWeight.w300),
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
                            controller: appPw2,
                            cursorColor: HexColor("#425C5A"),
                            maxLines: 1,
                            enableSuggestions: false,
                            obscureText: true,
                            style: TextStyle(
                                fontSize: 17.5.sp, fontWeight: FontWeight.w300),
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
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostCertificateScreen()));
                      },
                      child: Container(
                          width: 304.w,
                          height: 54.h,
                          decoration: BoxDecoration(
                              color: HexColor("#425C5A"),
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text(
                            "확인",
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
  }
}
