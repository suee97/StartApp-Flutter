import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:start_app/utils/common.dart';
import '../../../models/event_list.dart';
import 'package:hexcolor/hexcolor.dart';

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
        width: 340,
        height: 80,
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 16),
        color: HexColor(event.color!),
        child: SvgPicture.asset(
          checkExpiredAndReturn(event.isExpired!),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  String checkExpiredAndReturn(bool _isExpired) {
    return _isExpired == true
        ? "assets/event_tile_expired.svg"
        : "assets/event_tile.svg";
  }
}
