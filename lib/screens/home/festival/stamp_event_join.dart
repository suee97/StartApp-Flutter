import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class StampEventJoin extends StatelessWidget {
  StampEventJoin({Key? key, required this.onPressed}) : super(key: key);

  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 40.h,
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        decoration: BoxDecoration(
          color: HexColor("#EE795F"),
            borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
        child: Center(child: Text("스탬프 이벤트 참여하기", style: TextStyle(color: Colors.white, fontSize: 16.sp),)),
      ),
    );
  }
}
