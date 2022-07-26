import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../models/metting.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("학사 일정"),),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource()),
        monthViewSettings: MonthViewSettings(showAgenda: true, appointmentDisplayCount: 5),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();

    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    final DateTime startTime1 = DateTime(today.year, today.month, today.day, 10);
    final DateTime endTime1 = startTime.add(const Duration(hours: 3));

    final DateTime startTime2 = DateTime(today.year, today.month, today.day-2);

    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting(
        'ST', startTime1, endTime1, const Color(0xFF0F3344), false));
    meetings.add(Meeting(
        'GO', startTime2, endTime, const Color(0xFF0F3374), false));
    meetings.add(Meeting(
        'HLO', startTime, endTime, const Color(0xFF0C1784), false));
    meetings.add(Meeting(
        'HLO', startTime, endTime, const Color(0xFF0C1784), false));
    meetings.add(Meeting(
        'HLO', startTime, endTime, const Color(0xFF0C1784), false));
    meetings.add(Meeting(
        'HLO', startTime, endTime, const Color(0xFF0C1784), false));
    meetings.add(Meeting(
        'HLO', startTime, endTime, const Color(0xFF0C1784), false));
    meetings.add(Meeting(
        'HLO', startTime, endTime, const Color(0xFF0C1784), false));

    return meetings;
  }
}
