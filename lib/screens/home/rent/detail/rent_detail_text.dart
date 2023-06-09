import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentDetailText extends StatelessWidget {
  var category, itemPurpose, itemTotalCnt;

  RentDetailText(
      {Key? key,
        required this.category,
        required this.itemPurpose,
        required this.itemTotalCnt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 172.w,
      height: 100.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.toString(),
            style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "수량 : $itemTotalCnt개",
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
          Text("사용 목적 : $itemPurpose",
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
        ],
      ),
    );
  }
}