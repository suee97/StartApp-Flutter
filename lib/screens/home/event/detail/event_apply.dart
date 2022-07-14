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
          width: 240.w,
          height: 70.w,
          decoration: BoxDecoration(
              color: HexColor("#FBBB61"),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
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
