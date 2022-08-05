import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        labelStyle: TextStyle(color: Colors.black, fontSize: 21.5.sp, fontWeight: FontWeight.w400),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14.5.sp, fontWeight: FontWeight.w300)
      ),
      style: TextStyle(color: Colors.black, fontSize: 17.5.sp),
      enableSuggestions: true,
      obscureText: isObscure,
        keyboardType: inputType
    );
  }
}
