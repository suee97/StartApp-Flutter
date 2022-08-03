import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:start_app/screens/home/plan/snapping_grabbing.dart';
import 'package:start_app/screens/home/plan/plan_content.dart';
import 'package:start_app/screens/home/plan/plan_calendar.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../models/meeting.dart';
import 'package:flutter/rendering.dart';
import '../../../utils/common.dart';

class PlanScreen extends StatelessWidget {

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "학사 일정",
          style: Common.startAppBarTextStyle,
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: HexColor("#425C5A"),
        elevation: 0,
      ),
      body: SnappingSheet(
        lockOverflowDrag: true,
        snappingPositions: [
          SnappingPosition.factor(positionFactor: 0,grabbingContentOffset: GrabbingContentOffset.top),
          SnappingPosition.factor(positionFactor: 0.5,
              snappingCurve: Curves.elasticOut,
              snappingDuration: Duration(milliseconds: 1750)
          ),
          SnappingPosition.factor(positionFactor: 0.9)
        ],
        child: PlanCalendar(),
        grabbingHeight:70, //손잡이 높이
        grabbing: DefaultGrabbing(),
        sheetBelow: SnappingSheetContent(
            childScrollController: _scrollController,
            draggable: true,
            child: DummyContent(controller: _scrollController)
        ),
      ),
    );
  }
}
