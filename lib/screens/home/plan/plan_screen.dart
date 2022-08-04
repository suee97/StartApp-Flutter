import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_app/screens/home/plan/plan_calendar.dart';
import '../../../utils/common.dart';
import 'package:hexcolor/hexcolor.dart';
import 'stack_line.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

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
      body: Stack(
        children: <Widget>[
          PlanCalendar(),
          const StackLine(),
          DraggableScrollableSheet(
            initialChildSize: 0.58,
            minChildSize: 0.58,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: PlanBottomSheet(),
              );
            },
          ),
        ],
      ),
      backgroundColor: HexColor("#425c5a"),
    );
  }
}

class PlanBottomSheet extends StatelessWidget {
  const PlanBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.all(0),
      child: Container(
        height: 590.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white
        ),
        child: PlanBottomSheetContent(),
      ),
    );
  }
}

class PlanBottomSheetContent extends StatelessWidget {
  const PlanBottomSheetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 12),
        CustomDraggingHandle(),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlanDayInfo(),
            PlanAgenda(),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class CustomDraggingHandle extends StatelessWidget {
  const CustomDraggingHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 100,
      padding: EdgeInsets.only(bottom: 5), //적용X
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: HexColor("#92AEAC"),),
    );
  }
}

class PlanDayInfo extends StatelessWidget {
  const PlanDayInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.h, top: 1.h),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Text("화요일", style: TextStyle(color: HexColor("#425C5A")),),
          Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: HexColor("#FFCEA2"),
                  shape: BoxShape.circle
              ),
              child: Text("17", style: TextStyle(fontSize: 17.5.sp, color: HexColor("#425C5A")),)
          )],
      ),
    );
  }
}

class PlanAgenda extends StatelessWidget {
  const PlanAgenda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h, left: 16.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlanTile(),
            const SizedBox(height: 12),
            PlanTile(),
            const SizedBox(height: 12),
            PlanTile(),
            const SizedBox(height: 12),
            PlanTile(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class PlanTile extends StatelessWidget {
  const PlanTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child : Container(
          width: 270.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: HexColor("#7999FF"),
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10.w),
            child: Align(
                alignment : Alignment.centerLeft,
                child : Text("이벤트", textAlign: TextAlign.left, style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400))),
          )),
    );
  }
}