import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/login/login_screen.dart';
import 'package:start_app/screens/login/login_widgets.dart';

class SignUpEndScreen extends StatelessWidget {
  const SignUpEndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "회원가입 요청 완료",
              style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                  color: HexColor("#425C5A")),
            ),
            SizedBox(
              height: 32.h,
            ),
            Text(
              "72시간 내로 승인이 완료됩니다.\n문의 : 02-970-7012",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "행사 기간 중에는 빠른 처리가 진행될 예정입니다.",
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#f26464")),
            ),
            SizedBox(
              height: 24.h,
            ),
            LoginNavButton(
                margin: EdgeInsets.only(bottom: 16.h),

                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                title: "로그인 화면으로 이동",
                colorHex: "#425C5A",
                width: 228.w)
          ],
        ),
      ),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }
}
