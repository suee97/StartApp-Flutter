import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        child: Container(
          width: double.infinity,
            child: SvgPicture.asset("assets/test.svg", fit: BoxFit.fill,)
        ),
      ),
    );
  }
}
