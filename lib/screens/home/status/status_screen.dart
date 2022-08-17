import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/utils/common.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "재학생 확인 및 자치회비 납부 확인",
          style: Common.startAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: HexColor("#f3f3f3"),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: statusCard("학생회비 납부자","조인혁","16161616","공과대학","컴퓨터공학과"),
      ),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  Widget statusCard(String paid, String name, String studentNo, String group, String dep) {
    return Container(
      width: 320.w,
      height: 550.h,
      color: Colors.transparent,
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/card_payer.svg",
            color: Colors.transparent,
            fit: BoxFit.fill,
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 366.h,
                ),
                Container(
                  width: 320.w,
                  height: 184.h,
                  decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                    ),
                  padding: EdgeInsets.only(top: 27.h, left: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(paid, style: TextStyle(fontSize: 21.5.sp, fontWeight: FontWeight.w600),),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(name, style: TextStyle(fontSize: 15.5.sp, fontWeight: FontWeight.w600),),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(studentNo, style: TextStyle(fontSize: 13.5.sp),),
                      Text(group, style: TextStyle(fontSize: 13.5.sp),),
                      Text(dep, style: TextStyle(fontSize: 13.5.sp),),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
