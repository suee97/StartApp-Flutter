import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class SuggestTitleTextField extends StatelessWidget {
  SuggestTitleTextField(
      {Key? key, required this.textController, required this.hintText})
      : super(key: key);

  TextEditingController textController;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      cursorColor: HexColor("#EE795F"),
      textAlignVertical: TextAlignVertical.center,
      maxLines: 1,
      maxLength: 20,
      enableSuggestions: false,
      style: TextStyle(
          fontSize: 17.5.sp, fontWeight: FontWeight.w400, color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
        filled: true,
        fillColor: HexColor("f5efea"),
        contentPadding: EdgeInsets.only(left: 16.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: HexColor("#f9b7a9").withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: HexColor("#f9b7a9")),
        ),
      ),
    );
  }
}

class SuggestContentTextField extends StatelessWidget {
  SuggestContentTextField(
      {Key? key, required this.textController, required this.hintText})
      : super(key: key);

  TextEditingController textController;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      cursorColor: HexColor("#EE795F"),
      textAlignVertical: TextAlignVertical.center,
      maxLines: null,
      minLines: 10,
      maxLength: 500,
      enableSuggestions: false,
      keyboardType: TextInputType.multiline,
      style: TextStyle(
          fontSize: 17.5.sp, fontWeight: FontWeight.w400, color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
        filled: true,
        fillColor: HexColor("f5efea"),
        contentPadding: EdgeInsets.only(left: 16.w, top: 28.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: HexColor("#f9b7a9").withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: HexColor("#f9b7a9")),
        ),
      ),
    );
  }
}
