import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class StackLine extends StatelessWidget {
  const StackLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: 2.w,
      margin: EdgeInsets.only(top: 42.h, left: 9.w),
      color: HexColor("425c5a"),
    );
  }
}
