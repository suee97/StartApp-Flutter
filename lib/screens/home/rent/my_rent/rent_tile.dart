import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/utils/common.dart';
import '../../../../models/rent_list.dart';

/// 단일 내 예약 타일 위젯

class RentTile2 extends StatelessWidget {
  RentTile2({Key? key, required this.rent, required this.onPressed})
      : super(key: key);

  Rent rent;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
            color: HexColor("ffcea2"),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2.w, color: HexColor("#ee795f"))),
      ),
      Row(
        children: [
          SizedBox(width: 16.w,),
          Container(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            height: 60.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "이름 : ",
                          style: TextStyle(
                              fontSize: 15.5.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          rent.itemCategory,
                          style: TextStyle(
                              fontSize: 13.5.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Row(
                      children: [
                        Text(
                          "수량 : ",
                          style: TextStyle(
                              fontSize: 15.5.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          rent.amount.toString(),
                          style: TextStyle(
                              fontSize: 13.5.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
                Text(
                  "대여기간 :${Common.dateRange(rent.startTime, rent.endTime)}",
                  style:
                      TextStyle(fontSize: 15.5.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(width: 14.w,),
          Container(
            width: 6.w,
            height: 36.h,
            decoration: BoxDecoration(
                color: HexColor("#f3f3f3"),
                borderRadius: BorderRadius.circular(3)),
          ),
          SizedBox(width: 12.w,),
          Text(
            getKrStringFromStatus(rent.rentStatus),
            style: TextStyle(
                fontSize: 15.5.sp,
                fontWeight: FontWeight.w500,
                color: getRentColorFromStatus(rent.rentStatus)),
          )
        ],
      ),
    ]);
  }

  Color getRentColorFromStatus(String _rentStatus) {
    if (_rentStatus == "DENY") {
      return const Color.fromRGBO(227, 33, 38, 1);
    } else if (_rentStatus == "WAIT") {
      return const Color.fromRGBO(154, 166, 149, 1);
    } else if (_rentStatus == "CONFIRM") {
      return const Color.fromRGBO(0, 96, 10, 1);
    } else if (_rentStatus == "RENT") {
      return const Color.fromRGBO(10, 31, 98, 1);
    } else {
      return const Color.fromRGBO(70, 70, 70, 0.8);
    }
  }

  String getKrStringFromStatus(String _rentStatus) {
    if (_rentStatus == "DENY") {
      return "거절";
    } else if (_rentStatus == "WAIT") {
      return "승인대기";
    } else if (_rentStatus == "CONFIRM") {
      return "승인";
    } else if (_rentStatus == "RENT") {
      return "대여중";
    } else {
      return "반납완료"; // Done
    }
  }
}

/// 아래 인영이꺼

class RentTile extends StatelessWidget {
  RentTile({Key? key, required this.rent, required this.onPressed})
      : super(key: key);

  Rent rent;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // height: 80.w, // h 대신 w
        // margin: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 7.h),
        child: Stack(alignment: Alignment.centerLeft, children: [
          SvgPicture.asset(
            "assets/rent_tile.svg",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 17.w),
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                height: 60.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "이름 : ",
                              style: TextStyle(
                                  fontSize: 15.5.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(rent.itemCategory)
                          ],
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Row(
                          children: [
                            Text(
                              "수량 : ",
                              style: TextStyle(
                                  fontSize: 15.5.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(rent.amount.toString())
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "대여기간 : ",
                          style: TextStyle(
                              fontSize: 15.5.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(Common.dateRange(rent.startTime, rent.endTime),
                            style: TextStyle(fontSize: 16.sp))
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "승인",
                style: TextStyle(
                    fontSize: 15.5.sp,
                    fontWeight: FontWeight.w500,
                    color: getRentColorFromStatus(rent.rentStatus)),
              )
            ],
          ),
        ]),
      ),
    );
  }

  Color getRentColorFromStatus(String _rentStatus) {
    if (_rentStatus == "DENY") {
      return const Color.fromRGBO(227, 33, 38, 1);
    } else if (_rentStatus == "WAIT") {
      return const Color.fromRGBO(154, 166, 149, 1);
    } else if (_rentStatus == "CONFIRM") {
      return HexColor("#00600f");
    } else if (_rentStatus == "RENT") {
      return const Color.fromRGBO(10, 31, 98, 1);
    } else {
      return const Color.fromRGBO(70, 70, 70, 0.8);
    }
  }
}
