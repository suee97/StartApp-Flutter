import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../utils/common.dart';

class MyRentScreen extends StatefulWidget {
  const MyRentScreen({Key? key}) : super(key: key);

  @override
  State<MyRentScreen> createState() => _MyRentScreenState();
}

class _MyRentScreenState extends State<MyRentScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("내 예약",
          style: Common.startAppBarTextStyle,),
        backgroundColor: HexColor("#425C5A"),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: 55.h),
          decoration: BoxDecoration(
              color: HexColor("#f3f3f3"),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Column(
            children: [

            ],
          ),
        ),
        Container(
          width: 110.w,
          height: 110.w,
          margin: EdgeInsets.only(left: 38.w),
          decoration: BoxDecoration(
              color: HexColor("#f3f3f3"),
              shape: BoxShape.circle,
              border: Border.all(width: 9.w, color: HexColor("#f3f3f3"))),
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: HexColor("#425C5A"), shape: BoxShape.circle),
              child: SvgPicture.asset(
                "assets/icon_rent_person.svg",
                color: HexColor("#f3f3f3"),
                fit: BoxFit.fill,
              )),
        ),
        Container(
          width: 170.w,
          height: 90.h,
          margin: EdgeInsets.only(left: 160.w, top: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "오승언",
                    style: TextStyle(
                        fontSize: 17.5.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              myUserInfoText("19101686"),
              myUserInfoText("에너지바이오대학"),
              myUserInfoText("식품공학과"),
            ],
          ),
        )
      ]),
      backgroundColor: HexColor("#425C5A"),
    );
  }

  Widget myUserInfoText(String title) {
    return Text(
      title,
      style: TextStyle(
          color: HexColor("#5C7775"), fontSize: 13.5.sp, fontWeight: FontWeight.w500),
    );
  }
}
