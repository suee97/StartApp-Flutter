import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:start_app/screens/home/rent/rent_widget.dart';

class RentScreen extends StatefulWidget {
  const RentScreen({Key? key}) : super(key: key);

  @override
  State<RentScreen> createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  var logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("상시사업 예약"),
        backgroundColor: HexColor("#f3f3f3"),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: 55.w),
          decoration: BoxDecoration(
              color: HexColor("#425C5A"),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Column(
            children: [
              SizedBox(
                height: 76.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RentWidget(
                    onPressed: () {},
                    title: "캐노피",
                    svgPath: "assets/icon_canopy.svg",
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  RentWidget(
                    onPressed: () {},
                    title: "듀라테이블",
                    svgPath: "assets/icon_table.svg",
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  RentWidget(
                    onPressed: () {},
                    title: "앰프&마이크",
                    svgPath: "assets/icon_amp.svg",
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RentWidget(
                    onPressed: () {},
                    title: "리드선",
                    svgPath: "assets/icon_wire.svg",
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  RentWidget(
                    onPressed: () {},
                    title: "엘카",
                    svgPath: "assets/icon_cart.svg",
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  RentWidget(
                    onPressed: () {},
                    title: "의자",
                    svgPath: "assets/icon_chair.svg",
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "안내사항",
                      style: TextStyle(
                          fontSize: 17.5.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      "- 대여 물품이 파손되었을 시, 수리 비용의 80%를 대여인(또는 대여 기구) 측에서 비용하고 나머지 20%는 총학생회 자치회비에서 부담한다.",
                      style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7)),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "- 파손에 대해 수리가 불가하다고 판단될 시, 대여인(또는 대여 기구)에서 같은 제품 또는 그에 걸맞는 비용을 부담하여아 한다.",
                      style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7)),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: 110.w,
          height: 110.w,
          margin: EdgeInsets.only(left: 38.w),
          decoration: BoxDecoration(
              color: HexColor("#425c5a"),
              shape: BoxShape.circle,
              border: Border.all(width: 9.w, color: HexColor("#425C5A"))),
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: SvgPicture.asset(
                "assets/icon_rent_person.svg",
                color: HexColor("#425C5A"),
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
                        color: HexColor("#425C5A"),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Container(
                    width: 100.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                        color: HexColor("#FFCEA2"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "내 예약 확인하기",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: HexColor("#425C5A"),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              userInfoText("19101686"),
              userInfoText("에너지바이오대학"),
              userInfoText("식품공학과"),
            ],
          ),
        )
      ]),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  Widget userInfoText(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white, fontSize: 13.5.sp, fontWeight: FontWeight.w500),
    );
  }
}
