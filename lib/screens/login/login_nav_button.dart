import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginNavButton extends StatelessWidget {
  LoginNavButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.colorHex})
      : super(key: key);

  VoidCallback onPressed;
  String title;
  String colorHex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 330.w,
        height: 54.h,
        decoration: BoxDecoration(
            color: HexColor(colorHex),
          borderRadius: BorderRadius.circular(10)
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 19.5.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
    );
  }
}
