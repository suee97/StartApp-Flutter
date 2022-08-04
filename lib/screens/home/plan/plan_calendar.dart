import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../models/meeting.dart';

class PlanCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#425C5A"),
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(children: [
        SfCalendar(
          view: CalendarView.month,
          cellEndPadding: 5,
          headerStyle: CalendarHeaderStyle(
              textStyle: TextStyle(
                  fontSize: 23,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                  fontWeight: FontWeight.w300)),
          headerDateFormat: 'MMM',
          viewHeaderStyle: ViewHeaderStyle(
            dayTextStyle: TextStyle(
                fontSize: 14.5,
                color: Color(0xFFff5eaea),
                fontWeight: FontWeight.w500),
          ),
          backgroundColor: HexColor("#425C5A"),
          cellBorderColor: Colors.white,
          todayTextStyle: TextStyle(color: Colors.white),
          //선택 날짜 border. 기본 파랑색.
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.redAccent, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            shape: BoxShape.rectangle,
          ),
          dataSource: MeetingDataSource(_getDataSource()),
          todayHighlightColor: HexColor("#EE795F"),
          monthViewSettings: const MonthViewSettings(
            showAgenda: false,
            appointmentDisplayCount: 4,
            dayFormat: 'EEE',
            navigationDirection: MonthNavigationDirection.horizontal,
            monthCellStyle: MonthCellStyle(
                textStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 12,
                    color: Colors.white),
                trailingDatesTextStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 15,
                    color: Colors.grey),
                leadingDatesTextStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 15,
                    color: Colors.grey),
                backgroundColor: Colors.transparent,
                todayBackgroundColor: Colors.transparent,
                leadingDatesBackgroundColor: Colors.transparent,
                trailingDatesBackgroundColor: Colors.transparent),
          ),
        ),
      ]),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();

    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    final DateTime startTime1 =
        DateTime(today.year, today.month, today.day, 10);
    final DateTime endTime1 = startTime.add(const Duration(hours: 3));

    final DateTime startTime2 =
        DateTime(today.year, today.month, today.day - 2);

    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(
        Meeting('ST', startTime1, endTime1, const Color(0xFF0F3344), false));
    meetings.add(
        Meeting('GO', startTime2, endTime, const Color(0xFF0F3374), false));
    meetings.add(
        Meeting('HLO', startTime, endTime, const Color(0xFF0C1784), false));
    meetings.add(
        Meeting('HLO', startTime, endTime, const Color(0xFF0C1784), false));
    meetings.add(
        Meeting('HLO', startTime, endTime, const Color(0xFF0C1784), false));
    meetings.add(
        Meeting('HLO', startTime, endTime, const Color(0xFF0C1784), false));
    meetings.add(
        Meeting('HLO', startTime, endTime, const Color(0xFF0C1784), false));
    meetings.add(
        Meeting('HLO', startTime, endTime, const Color(0xFF0C1784), false));

    return meetings;
  }
}
