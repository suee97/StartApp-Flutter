import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginNavButton extends StatelessWidget {
  LoginNavButton(
      {Key? key,
        required this.onPressed,
        required this.title,
        required this.colorHex,
        required this.width})
      : super(key: key);

  VoidCallback onPressed;
  String title;
  String colorHex;
  double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
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

class LoginInputField extends StatelessWidget {
  LoginInputField({Key? key, required this.controller}) : super(key: key);

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      child: TextField(
        controller: controller,
        style: TextStyle(
            fontSize: 17.5.sp,
            fontWeight: FontWeight.w300
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: HexColor("#425c5a")),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: HexColor("#425c5a")),
          ),
        ),
      ),
    );
  }
}