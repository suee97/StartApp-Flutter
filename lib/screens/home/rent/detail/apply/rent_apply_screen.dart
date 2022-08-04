import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../utils/common.dart';
import 'dotted_line_widget.dart';

class RentApplyScreen extends StatelessWidget {
  const RentApplyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "상시사업 예약",
          style: Common.startAppBarTextStyle,
        ),
        foregroundColor: Colors.white,
        backgroundColor: HexColor("#425C5A"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
              child: SvgPicture.asset(
                "assets/background_rent_apply.svg",
                fit: BoxFit.fill,
              )),
          Column(
            children: [
              SizedBox(height: 100.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  DottedLineWidget(),
                ],
              )
            ],
          )
        ],
      ),
      backgroundColor: HexColor("#425c5a"),
    );
  }
}
