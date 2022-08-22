import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/utils/common.dart';
import '../../../../models/rent.dart';

class RentTile extends StatelessWidget {
  RentTile({Key? key, required this.rent, required this.onPressed})
      : super(key: key);

  Rent rent;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 60.h,
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
            color: HexColor("ffcea2"),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2.w, color: HexColor("#ee795f"))),
      ),
      Row(
        children: [
          SizedBox(
            width: 16.w,
          ),
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
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          getKrStringFromCategory(rent.itemCategory),
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
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
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          rent.account.toString(),
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
                Text(
                  "대여기간 :${Common.dateRange(rent.startTime, rent.endTime)}",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 14.w,
          ),
          Container(
            width: 6.w,
            height: 36.h,
            decoration: BoxDecoration(
                color: HexColor("#f3f3f3"),
                borderRadius: BorderRadius.circular(3)),
          ),
          SizedBox(
            width: 12.w,
          ),
          Text(
            getKrStringFromStatus(rent.rentStatus),
            style: TextStyle(
                fontSize: 14.sp,
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

  String getKrStringFromCategory(String _itemCategory) {
    if (_itemCategory == "CANOPY") {
      return "캐노피";
    }
    if (_itemCategory == "TABLE") {
      return "듀라테이블";
    }
    if (_itemCategory == "AMP") {
      return "앰프&마이크";
    }
    if (_itemCategory == "WIRE") {
      return "리드선";
    }
    if (_itemCategory == "CART") {
      return "엘카";
    }
    return "의자";
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
