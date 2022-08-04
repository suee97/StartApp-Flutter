import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class YellowLine extends StatelessWidget {
  const YellowLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      height: 10.h,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: HexColor("#ffcea2"),
                  shape: BoxShape.circle
                ),
              ),
              Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                    color: HexColor("#ffcea2"),
                    shape: BoxShape.circle
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 10.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 310.w,
                  height: 2.h,
                  color: HexColor("#ffcea2"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
