import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io' show Platform;

class StampButton extends StatelessWidget {
  StampButton({Key? key, required this.title, required this.loading})
      : super(key: key);

  String title;
  bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 40.h,
      alignment: Alignment.center,
      child: loading ? Center(
        child: Platform.isIOS
            ? const CupertinoActivityIndicator(
          color: Colors.white,
        )
            : CircularProgressIndicator(
          color: HexColor("#f3f3f3"),
        ),
      ) : Text(
        title,
        style: TextStyle(
            fontSize: 21.5.sp,
            fontWeight: FontWeight.w600,
            color: HexColor("#f8eae1")),
      ),
    );
  }
}
