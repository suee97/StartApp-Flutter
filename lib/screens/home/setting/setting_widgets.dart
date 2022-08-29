import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingSemiTitle extends StatelessWidget {
  SettingSemiTitle({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  String title;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          margin: EdgeInsets.only(left: 12.w),
          child: Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 4.h, bottom: 4.h),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
          )),
    );
  }
}

class SettingSemiTitleLoginFalse extends StatelessWidget {
  SettingSemiTitleLoginFalse({Key? key, required this.title})
      : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 12.w),
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 4.h, bottom: 4.h),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.5)),
          ),
        ));
  }
}
