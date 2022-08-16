import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../utils/common.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';
import 'login_widgets.dart';

class LoginOptionScreen extends StatelessWidget {
  const LoginOptionScreen({Key? key}) : super(key: key);

  get studentIdController => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 220.h,
            ),
            SizedBox(
              width: 200.w,
              height: 200.h,
              child: const Image(
                image: AssetImage("images/logo_app.png"),
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            LoginNavButton(
              colorHex: "#425c5a",
              title: '로그인',
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()))
              },
              width: 330.w,
            ),
            SizedBox(
              height: 12.h,
            ),
            LoginNavButton(
              colorHex: "#929d9c",
              title: '로그인 없이 이용하기',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: HexColor("#F8EAE1"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        title: Text(
                          "로그인 없이 이용하기",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24.sp, fontWeight: FontWeight.w500),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "로그인을 하지 않을 시 다음 사항에 제약이 있을 수 있습니다.",
                              style: TextStyle(
                                  fontSize: 15.5.sp,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 26.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Text(
                                "∙ 주 사업 이벤트",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Text(
                                "∙ 상시사업 예약 및 예약확인",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            SizedBox(
                              height: 28.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Common.setNonLogin(true);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => HomeScreen()),
                                            (route) => false);
                                  },
                                  child: Container(
                                    width: 114.w,
                                    height: 40.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: HexColor("#425c5a"),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Text(
                                      "확인",
                                      style: TextStyle(
                                          fontSize: 19.5.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 114.w,
                                    height: 40.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: HexColor("#425c5a"),
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: Text(
                                      "취소",
                                      style: TextStyle(
                                          fontSize: 19.5.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              width: 330.w,
            ),
          ],
        ),
      ),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }
}
