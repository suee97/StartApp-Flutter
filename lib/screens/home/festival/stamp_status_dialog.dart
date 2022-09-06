import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/festival/festival_screen.dart';

class StampStatusDialog extends StatelessWidget {
  StampStatusDialog({Key? key, required this.stampStatusWithError})
      : super(key: key);

  StampStatusWithError stampStatusWithError;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "방문 도장 이벤트 현황",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: HexColor("#425C5A")),
          ),
        ],
      ),
      content: Container(
        width: double.infinity,
        height: 120.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                stampStatusWithError.ground == true ? SvgPicture.asset(
                  "assets/stamp_ground.svg",
                  width: 60.w,
                  height: 60.h,
                ) : SvgPicture.asset(
                  "assets/stamp_ground_grey.svg",
                  width: 60.w,
                  height: 60.h,
                ),
                SizedBox(width: 12.w,),
                stampStatusWithError.exhibition == true ? SvgPicture.asset(
                  "assets/stamp_exhibition.svg",
                  width: 60.w,
                  height: 60.h,
                ) : SvgPicture.asset(
                  "assets/stamp_exhibition_grey.svg",
                  width: 60.w,
                  height: 60.h,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                stampStatusWithError.fleamarket == true ? SvgPicture.asset(
                  "assets/stamp_fleamarket.svg",
                  width: 60.w,
                  height: 60.h,
                ) : SvgPicture.asset(
                  "assets/stamp_fleamarket_grey.svg",
                  width: 60.w,
                  height: 60.h,
                ),
                SizedBox(width: 12.w,),
                stampStatusWithError.bungeobang == true ? SvgPicture.asset(
                  "assets/stamp_bungeobang.svg",
                  width: 60.w,
                  height: 60.h,
                ) : SvgPicture.asset(
                  "assets/stamp_bungeobang_grey.svg",
                  width: 60.w,
                  height: 60.h,
                ),
                SizedBox(width: 12.w,),
                stampStatusWithError.sangsang == true ? SvgPicture.asset(
                  "assets/stamp_sangsang.svg",
                  width: 60.w,
                  height: 60.h,
                ) : SvgPicture.asset(
                  "assets/stamp_sangsang_grey.svg",
                  width: 60.w,
                  height: 60.h,
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: HexColor("#F8EAE1"),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }
}
