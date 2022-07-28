import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class EventApply extends StatelessWidget {
  EventApply({Key? key, required this.onPressed}) : super(key: key);

  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(alignment: Alignment.center, children: [
        Container(
          width: double.infinity,
          height: 50.h,
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          decoration: BoxDecoration(
              color: HexColor("#FFCEA2"),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
        ),
        Text(
          "신청하기",
          style: TextStyle(
            color: HexColor("#425C5A"),
            fontSize: 28.sp,
            fontWeight: FontWeight.w700
          ),
        )
      ]),
    );
  }
}
