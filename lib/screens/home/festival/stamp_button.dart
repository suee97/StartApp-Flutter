import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class StampButton extends StatelessWidget {
  StampButton({Key? key, required this.title})
      : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 40.h,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 21.5.sp,
            fontWeight: FontWeight.w600,
            color: HexColor("#f8eae1")),
      ),
    );
  }
}
