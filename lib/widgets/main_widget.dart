import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class MainWidget extends StatelessWidget {
  MainWidget({
    Key? key,
    required this.title,
    required this.svgPath,
    required this.onPressed,
    required this.isUnderRow
  }) : super(key: key);

  String title = "";
  String svgPath;
  VoidCallback onPressed;
  bool isUnderRow = false;

  double returnUnderRowHeight(bool isUnderRow) {
    return isUnderRow == true ? 80.w : 95.w;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 95.w,
        height: returnUnderRowHeight(isUnderRow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 50.w,
              height: 50.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp,color: HexColor("#222E2D"), fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
