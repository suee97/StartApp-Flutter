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
        height: 80.w, // h 대신 w
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
                Container(
                  width: 200.w,
                  child: Text(
                    event.title,
                    style: TextStyle(fontSize: 19.5.sp, fontWeight: FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  Common.parseTime(event.startTime, event.endTime),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
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

  String checkExpiredAndReturn(String _eventStatus) {
    if (_eventStatus == "END") {
      return "assets/event_tile_end.svg";
    } else if(_eventStatus == "PROCEEDING") {
      return "assets/event_tile_proceeding.svg";
    } else {
      return "assets/event_tile_before.svg";
    }
  }
}
