import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RentWidget extends StatelessWidget {
  RentWidget(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.svgPath})
      : super(key: key);

  VoidCallback onPressed;
  String title;
  String svgPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100.w,
        height: 125.h,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h),
              width: 60.w,
              child: SvgPicture.asset(
                svgPath,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.5.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
