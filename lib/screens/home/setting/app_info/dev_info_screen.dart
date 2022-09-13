import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/utils/common.dart';

class DevInfoScreen extends StatelessWidget {
  const DevInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "개발 관련 정보 및 문의하기",
          style: Common.startAppBarTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: HexColor("#f3f3f3"),
        foregroundColor: HexColor("#425C5A"),
      ),
      body: Stack(children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("images/logo_app_mini.png")),
              Text(
                "어플리케이션 버전",
                style: TextStyle(
                    fontSize: 17.5.sp,
                    fontWeight: FontWeight.w500,
                    color: HexColor("#425C5A")),
              ),
              Text(
                "1.0.0",
                style: TextStyle(
                    fontSize: 49.5.sp,
                    fontWeight: FontWeight.w500,
                    color: HexColor("#425C5A")),
              ),
              Text(
                "개발 관련 문의",
                style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w500,
                    color: HexColor("#425C5A")),
              ),
              Text(
                "dev.seoultech@gmail.com",
                style: TextStyle(
                    fontSize: 19.5.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#425C5A")),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "참여자",
                style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w300,
                    color: HexColor("#425C5A")),
              ),
              Text("오승언 양용수 강인영 위성률 조인혁 송민선 이유민",
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w300,
                      color: HexColor("#425C5A"))),
              Text("김영산 황정연 이도원 이혜윤 권오훈 김성우",
                  style: TextStyle(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w300,
                      color: HexColor("#425C5A"))),
              SizedBox(
                height: 16.h,
              )
            ],
          ),
        ),
      ]),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }
}
