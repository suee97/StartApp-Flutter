import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/utils/common.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "재학생 확인 및 자치회비 납부 확인",
          style: Common.startAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: HexColor("#f3f3f3"),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: statusCard(),
      ),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  Widget statusCard() {
    return Container(
      width: 320.w,
      height: 550.h,
      color: Colors.pink,
    );
  }
}
