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
      onTap: onPressed,
      child: Container(
        height: 70.w, // h 대신 w
        margin: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 7.h),
        child: Stack(alignment: Alignment.centerLeft, children: [
          SvgPicture.asset(
            checkExpiredAndReturn(event.eventStatus),
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Container(
            // color: Colors.red,
            margin: EdgeInsets.only(left: 16.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200.w,
                  child: Text(
                    event.title,
                    style: TextStyle(
                        fontSize: 17.sp, fontWeight: FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                event.eventStatus == "BEFORE"
                    ? Container(
                        width: 54.w,
                        height: 30.h,
                        alignment: Alignment.center,
                        child: Text(
                          Common.calDday(event.startTime),
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      )
                    : Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: Text(
                          Common.parseTime(event.startTime, event.endTime),
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                    )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  String checkExpiredAndReturn(String eventStatus) {
    if (eventStatus == "END") {
      return "assets/event_tile_end.svg";
    } else if (eventStatus == "PROCEEDING") {
      return "assets/event_tile_proceeding.svg";
    } else {
      return "assets/event_tile_proceeding.svg";
    }
  }
}
