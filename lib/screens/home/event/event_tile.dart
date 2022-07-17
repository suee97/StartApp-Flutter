import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:start_app/utils/common.dart';
import '../../../models/event_list.dart';

/// 단일 이벤트 타일 위젯

class EventTile extends StatelessWidget {
  EventTile({Key? key, required this.event, required this.onPressed})
      : super(key: key);

  Event event;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: event.isExpired == true ? () => {} : onPressed,
      child: Container(
        height: 80.w, // h 대신 w
        margin: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 7.h),
        child: Stack(alignment: Alignment.centerLeft, children: [
          SvgPicture.asset(
            checkExpiredAndReturn(event.isExpired!),
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Container(
            // color: Colors.red,
            margin: EdgeInsets.only(left: 16.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.title!,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                Text(
                  Common.parseTime(event.startTime!, event.endTime!),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  String checkExpiredAndReturn(bool _isExpired) {
    return _isExpired == true
        ? "assets/event_tile_expired.svg"
        : "assets/event_tile_ongoing.svg";
  }
}
