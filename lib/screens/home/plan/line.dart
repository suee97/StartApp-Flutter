import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class Line extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 182.h,
          width: 1.5.w,
          margin: EdgeInsets.only(top: 42.h, left: 10.1.w),
          decoration: BoxDecoration(
            color: HexColor("#425C5A"),
          ),
        ),
        Container(
          height: 1.5.h,
          width: 341.w,
          margin: EdgeInsets.only(left: 10.1.w),
          decoration: BoxDecoration(
            color: HexColor("#425C5A"),
          ),
        )
      ],
    );
  }
}