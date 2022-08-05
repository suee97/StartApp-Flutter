import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class RentCustomTextField extends StatelessWidget {
  const RentCustomTextField(
      {Key? key,
      required this.controller,
      required this.isObscure,
      required this.label,
      required this.labelHint,
      required this.inputType})
      : super(key: key);

  final TextEditingController controller;
  final bool isObscure;
  final String label;
  final String labelHint;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
          labelText: label,
          hintText: labelHint,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: HexColor("#425c5a")),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: HexColor("#425c5a")),
          ),
          labelStyle: TextStyle(
              color: HexColor("#425c5a"),
              fontSize: 17.5.sp,
              fontWeight: FontWeight.w400),
          hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w300)),
      style: TextStyle(color: Colors.black, fontSize: 17.5.sp),
      obscureText: isObscure,
      keyboardType: inputType,
      cursorColor: HexColor("#425c5a"),
    );
  }
}
