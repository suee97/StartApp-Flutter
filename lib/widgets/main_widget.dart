import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class MainWidget extends StatelessWidget {
  MainWidget(
      {Key? key,
      required this.title,
      required this.svgPath,
      required this.onPressed,
      required this.isUnderRow})
      : super(key: key);

  String title = "";
  String svgPath;
  VoidCallback onPressed;
  bool isUnderRow = false;

  double returnUnderRowHeight(bool isUnderRow) {
    return isUnderRow == true ? 80.h : 95.h;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 110.w,
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 13.sp,
                  color: HexColor("#222E2D"),
                  fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
