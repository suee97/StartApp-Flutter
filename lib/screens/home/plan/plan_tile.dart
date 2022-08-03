import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class PlanTile extends StatelessWidget {

  PlanTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child : Container(
          width: 270.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: HexColor("#7999FF"),
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10.w),
            child: Align(
                alignment : Alignment.centerLeft,
                child : Text("이벤트", textAlign: TextAlign.left, style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400))),
          )),
          )
    );
  }
}