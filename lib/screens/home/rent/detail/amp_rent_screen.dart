import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../models/metting.dart';

class AmpRentScreen extends StatelessWidget {
  const AmpRentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("상시사업 현황(앰프)"),
      ),
      body: Container(
        width: double.infinity,
        height: 400.h,
        child: SfCalendar(
          view: CalendarView.month,
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayCount: 4,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          dataSource: MeetingDataSource(_getDataSource()),
          todayHighlightColor: Colors.transparent,
          todayTextStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          selectionDecoration: const BoxDecoration(),
          cellBorderColor: Colors.black,
        ),
      ),
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime startTime = DateTime(2022, 7, 15);
  final DateTime endTime = DateTime(2022, 7, 17);

  meetings.add(Meeting('', startTime, endTime, const Color(0xFF0F8644), true));
  meetings.add(Meeting(
      '', DateTime(2022, 7, 21), DateTime(2022, 7, 23), Colors.red, true));
  meetings.add(Meeting(
      '', DateTime(2022, 7, 22), DateTime(2022, 7, 24), Colors.orange, true));
  meetings.add(Meeting('', DateTime(2022, 7, 22), DateTime(2022, 7, 24),
      Colors.pinkAccent, true));
  return meetings;
}
