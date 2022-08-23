import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class StartAndroidDialog extends StatelessWidget {
  StartAndroidDialog(
      {Key? key,
      required this.title,
      required this.onOkPressed,
      required this.onCancelPressed})
      : super(key: key);

  String title;
  VoidCallback onOkPressed;
  VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: HexColor("#425C5A")),
      ),
      content: Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onOkPressed,
              child: Container(
                width: 114.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: HexColor("#425c5a"),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: Text(
                  "확인",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 6.w,),
            GestureDetector(
              onTap: onCancelPressed,
              child: Container(
                width: 114.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: HexColor("#425c5a"),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Text(
                  "취소",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}
