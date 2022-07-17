import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#f3f3f3"),
      appBar: AppBar(
        title: const Text(
          "총학생회 설명",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#f3f3f3"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child:
        Stack(
          children: [
            Container(
              width: 86.w,
              height: 26.w,
              color: HexColor("#425C5A"),
            ),
            Container(
              width: double.infinity,
              height: 147.w,
              color: HexColor("#425C5A"),
              margin: EdgeInsets.only(top: 26.w),
            ),
          ],
        )
      ),
    );
  }
}
