import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        margin: EdgeInsets.fromLTRB(18.w, 0.h, 17.w, 16.h),
        child: Stack(alignment: Alignment.centerLeft, children: [
          SvgPicture.asset(
            checkExpiredAndReturn(event.isExpired!),
            fit: BoxFit.fitWidth,
            width: 377.w,
          ),
          Container(
            // color: Colors.red,
            margin: EdgeInsets.only(left: 16.w),
            child: Text(
              event.title!,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
          )
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
