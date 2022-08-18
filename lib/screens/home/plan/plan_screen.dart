import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/plan_notifier.dart';
import 'package:start_app/screens/home/plan/plan_calendar.dart';
import '../../../utils/common.dart';
import 'package:hexcolor/hexcolor.dart';
import 'stack_line.dart';
import 'dart:io' show Platform;

class PlanScreen extends StatefulWidget {

  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlanNotifier>(
      builder: (context, planNotifier, child) {
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
          body: planNotifier.getIsLoading() == false
              ? Stack(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            top: 5.h, bottom: 5.h, right: 5.h, left: 5.w),
                        child: Stack(children: [
                          PlanCalendar(),
                          StackLine(colorHex: "#425c5a"),
                        ])),
                    DraggableScrollableSheet(
                      initialChildSize: 0.40,
                      minChildSize: 0.40,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return SingleChildScrollView(
                          controller: scrollController,
                          child: PlanBottomSheet(),
                        );
                      },
                    ),
                  ],
                )
              : Stack(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            top: 5.h, bottom: 5.h, right: 5.h, left: 5.w),
                        child: Stack(children: [
                          PlanCalendar(),
                          StackLine(colorHex: "#929d9c"),
                        ])),
                    DraggableScrollableSheet(
                      initialChildSize: 0.40,
                      minChildSize: 0.40,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return SingleChildScrollView(
                          controller: scrollController,
                          child: PlanBottomSheet(),
                        );
                      },
                    ),
                    Container(
                        child: Platform.isIOS
                            ? const Center(
                                child: CupertinoActivityIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                color: Colors.black,
                              ))),
                  ],
                ),
          backgroundColor: planNotifier.getIsLoading()
              ? HexColor("#929d9c")
              : HexColor("#425C5a"),
        );
      },
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
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            color: Colors.white),
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
        color: HexColor("#92AEAC"),
      ),
    );
  }
}

class PlanDayInfo extends StatelessWidget {
  const PlanDayInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanNotifier>(builder: (context, planNotifier, child) {
      return Container(
        padding: EdgeInsets.only(left: 16.h, top: 1.h),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Text(
              planNotifier.getCurWeekDay().toString(),
              style: TextStyle(color: HexColor("#425C5A")),
            ),
            Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: HexColor("#FFCEA2"), shape: BoxShape.circle),
                child: Text(
                  planNotifier.getCurDay().toString(),
                  style:
                      TextStyle(fontSize: 17.5.sp, color: HexColor("#425C5A")),
                ))
          ],
        ),
      );
    });
  }
}

class PlanAgenda extends StatelessWidget {
  const PlanAgenda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanNotifier>(builder: (context, planNotifier, child) {
      return Padding(
          padding: EdgeInsets.only(top: 15.h, left: 16.w),
          child: Column(
            children: [
              for (var item in planNotifier.getSelectedDayMeetingList())
                PlanTile(
                  title: item.eventName,
                  color: item.background,
                )
            ],
          ));
    });
  }
}

class PlanTile extends StatelessWidget {
  PlanTile({Key? key, required this.title, required this.color})
      : super(key: key);

  String title;
  Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          width: 270.w,
          height: 40.h,
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10.w),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 12.5.sp, fontWeight: FontWeight.w400))),
          )),
    );
  }
}
