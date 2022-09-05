import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginNavButton extends StatelessWidget {
  LoginNavButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.colorHex,
    required this.width,
    this.margin = EdgeInsets.zero,
    this.isLoading = false,
  }) : super(key: key);

  VoidCallback onPressed;
  String title;
  String colorHex;
  double width;
  EdgeInsets margin;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading == false ? onPressed : () {},
      child: Container(
        width: width,
        margin: margin,
        height: 54.h,
        decoration: BoxDecoration(
            color: HexColor(colorHex), borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: isLoading == false
            ? Text(
                title,
                style: TextStyle(
                    fontSize: 19.5.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )
            : Center(
                child: Platform.isIOS == true
                    ? CupertinoActivityIndicator(
                        color: HexColor("#f3f3f3"),
                      )
                    : CircularProgressIndicator(
                        color: HexColor("#f3f3f3"),
                      ),
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
    return SizedBox(
      height: 24.h,
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w300),
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
