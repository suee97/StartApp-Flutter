import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/plan/plan_tile.dart';

class DummyContent extends StatelessWidget{
  final bool reverse;
  final ScrollController? controller;

  const DummyContent({Key? key, this.reverse = false, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.h, top: 1.h),
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text("화요일", style: TextStyle(color: HexColor("#425C5A")),),
                Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HexColor("#FFCEA2"),
                      shape: BoxShape.circle
                  ),
                child: Text("17", style: TextStyle(fontSize: 17.5.sp, color: HexColor("#425C5A")),)
                )],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.h, left: 70.w, right: 20.w),
            child: ListView(
              children: [
                PlanTile(),
                SizedBox(
                  height: 10.h,
                ),
                PlanTile(),
              ],
          ),),
        ],
      ),
    );
  }
}