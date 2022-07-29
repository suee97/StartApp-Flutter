import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class EventApplyButton extends StatelessWidget {
  EventApplyButton(
      {Key? key, required this.onPressed, required this.buttonTitle, required this.mainHexColor, required this.buttonHexColor})
      : super(key: key);

  VoidCallback onPressed;
  String buttonTitle;
  String buttonHexColor;
  String mainHexColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(alignment: Alignment.center, children: [
        Container(
          width: 264.w,
          height: 50.h,
          decoration: BoxDecoration(
              color: HexColor(buttonHexColor),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
        ),
        Text(
          buttonTitle,
          style: TextStyle(
              color: HexColor(mainHexColor),
              fontSize: 21.5.sp,
              fontWeight: FontWeight.w600),
        )
      ]),
    );
  }
}
