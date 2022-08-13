import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../utils/common.dart';
import '../home/home_screen.dart';
import 'login_nav_button.dart';
import 'sign_in/login_screen.dart';

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
            Container(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                    }),
            SizedBox(
              height: 12.h,
            ),
            LoginNavButton(
                colorHex: "#929d9c",
                title: '로그인 없이 이용하기',
                onPressed: () {
                  Common.setNonLogin(true);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
                }),
          ],
        ),
      ),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }
}
