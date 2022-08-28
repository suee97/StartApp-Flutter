import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentDetailText extends StatelessWidget {
  var category, itemPurpose;

  RentDetailText(
      {Key? key,
      required this.category,
      required this.itemPurpose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172.w,
      height: 190.h,
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
            "수량 : 2개",
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
          Text("사용 목적 : ${itemPurpose}",
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
