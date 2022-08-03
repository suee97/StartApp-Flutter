import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:start_app/screens/home/plan/snapping_grabbing.dart';
import 'package:start_app/screens/home/plan/plan_content.dart';
import 'package:start_app/screens/home/plan/plan_calendar.dart';
import 'package:hexcolor/hexcolor.dart';

class PlanScreen extends StatelessWidget {

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "학사 일정",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: HexColor("#425C5A")
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
