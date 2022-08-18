import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class StackLine extends StatelessWidget {
  StackLine({Key? key, required this.colorHex}) : super(key: key);

  String colorHex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 2.w,
      margin: EdgeInsets.only(top: 42.h, left: 9.w),
      color: HexColor(colorHex),
    );
  }
}
