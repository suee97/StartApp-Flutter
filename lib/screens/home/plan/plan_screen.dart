import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../models/metting.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:intl/intl.dart';


class PlanScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        SfGlobalLocalizations.delegate
      ],
      //ignore: always_specify_types
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
        // ... other locales the app supports
      ],
      locale: const Locale('ko'),
      home: PlanDetailScreen(),
    );
  }
}

class PlanDetailScreen extends StatelessWidget {
  // const PlanDetailScreen({Key? key}) : super(key: key);

  late String _month;
  late String _year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "학사 일정",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: HexColor("#425C5A"),
        elevation: 0,
      ),
      body: SfCalendar(
        view: CalendarView.month,
        headerStyle: CalendarHeaderStyle(
            textStyle: TextStyle(
                fontSize: 23,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w300)),
        headerDateFormat: 'MMM',
        backgroundColor: HexColor("#425C5A"),
        cellBorderColor: Colors.white,
        todayTextStyle: TextStyle(
            color: Colors.white),
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border:
          Border.all(color: Colors.redAccent,
              width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
        ),
        dataSource: MeetingDataSource(_getDataSource()),
        todayHighlightColor: HexColor("#EE795F"),
        // todayTextStyle: TextStyle(),
        monthViewSettings: MonthViewSettings(showAgenda: true, appointmentDisplayCount: 4, dayFormat: 'EEE',
          agendaStyle: AgendaStyle(
          backgroundColor: Colors.white,
          appointmentTextStyle: TextStyle(
          color: HexColor("#425C5A"),
          fontSize: 13,
          ),
          //동그라미 윗 첨자 글씨
          dayTextStyle: TextStyle(color: HexColor("#425C5A"),
          fontSize: 13, fontWeight: FontWeight.w200),
          //동그라미 숫자
          dateTextStyle: TextStyle(color: HexColor("#425C5A"),
          fontSize: 17.5.sp,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal),
          ),
            navigationDirection: MonthNavigationDirection.horizontal,
            monthCellStyle
                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
            normal, fontSize: 12, color: Colors.white),
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
    scheduleViewSettings: ScheduleViewSettings(
    dayHeaderSettings: DayHeaderSettings(
    dayFormat: 'EEEE',
    width: 70,
    dayTextStyle: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: Colors.amber,
    ),
    dateTextStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: Colors.amber,
    ))),
      )
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

  void setState(Null Function() param0) {

  }
  void viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance!
        .addPostFrameCallback((Duration duration) {
      setState(() {
        _month = DateFormat('MMMM').format(viewChangedDetails
            .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]).toString();
        _year = DateFormat('yyyy').format(viewChangedDetails
            .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]).toString();
      });
    });
  }



}

