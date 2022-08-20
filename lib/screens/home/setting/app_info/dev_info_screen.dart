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
        backgroundColor: HexColor("#425C5A"),
        foregroundColor: HexColor("#f3f3f3"),
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("어플리케이션 버전", style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500, color: HexColor("#f3f3f3")),),
              Text("1.0.0", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: HexColor("#f3f3f3")),),
              Text("대표 관리자", style: TextStyle(fontSize: 15.sp, color: HexColor("#f3f3f3")),),
              Text("dev.suee97@gmail.com", style: TextStyle(fontSize: 15.sp, color: HexColor("#f3f3f3")),),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("어플리케이션 버전"),
              Text("1.0.0"),
              Text("대표 관리자"),
              Text("dev.suee97@gmail.com"),
              Text("참여자"),
              Text("오승언 양용수 강인영 위성률 조인혁 송민선 이유민"),
              Text("김영산 황정연 이도원 이혜윤 권오훈"),
              SizedBox(height: 28.h,)
            ],
          ),
        ),
      ]),
      backgroundColor: HexColor("#425c5a"),
    );
  }
}
