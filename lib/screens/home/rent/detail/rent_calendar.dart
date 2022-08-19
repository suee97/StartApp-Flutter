import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../models/meeting.dart';

class RentCalendar extends StatefulWidget {
  const RentCalendar({Key? key}) : super(key: key);

  @override
  State<RentCalendar> createState() => _RentCalendarState();
}

class _RentCalendarState extends State<RentCalendar> {
  CalendarController _calendarController = CalendarController();
  final DateTime today = DateTime.now();
  late String _headerText = today.month.toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 180.w,
        height: 20.h,
        decoration: BoxDecoration(
            color: HexColor("#FFCEA2"),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _calendarController.backward!();
              },
              child: Container(
                  width: 20.w,
                  height: 18.h,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 6.w, right: 6.w, top: 4.h, bottom: 4.h),
                    child: SvgPicture.asset(
                      'assets/back_btn.svg',
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
            // IconButton(icon: Icon(Icons.arrow_back),
            //   onPressed: () {
            //   _calendarController.backward!();
            //   },),
            Text(_headerText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.5.sp)),
            GestureDetector(
              onTap: () {
                _calendarController.forward!();
              },
              child: Container(
                  width: 20.w,
                  height: 18.h,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 6.w, right: 6.w, top: 4.h, bottom: 4.h),
                    child: SvgPicture.asset(
                      'assets/forward_btn.svg',
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
            // IconButton(icon: Icon(Icons.arrow_forward),
            //   onPressed: () {
            //   _calendarController.forward!();
            //   },)
          ],
        ),
      ),
      Container(
        height: 330.h,
        child: SfCalendar(
          view: CalendarView.month,
          controller: _calendarController,
          headerHeight: 0,
          onViewChanged: (ViewChangedDetails viewChangedDetails) {
            if (_calendarController.view == CalendarView.month) {
              _headerText = DateFormat('MMMM')
                  .format(viewChangedDetails.visibleDates[
                      viewChangedDetails.visibleDates.length ~/ 2])
                  .toString();
            }
            if (_headerText == 'January') {
              _headerText = "1월 예약 현황";
            } else if (_headerText == 'February') {
              _headerText = "2월 예약 현황";
            } else if (_headerText == 'March') {
              _headerText = "3월 예약 현황";
            } else if (_headerText == 'April') {
              _headerText = "4월 예약 현황";
            } else if (_headerText == 'May') {
              _headerText = "5월 예약 현황";
            } else if (_headerText == 'June') {
              _headerText = "6월 예약 현황";
            } else if (_headerText == 'July') {
              _headerText = "7월 예약 현황";
            } else if (_headerText == 'August') {
              _headerText = "8월 예약 현황";
            } else if (_headerText == 'September') {
              _headerText = "9월 예약 현황";
            } else if (_headerText == 'October') {
              _headerText = "10월 예약 현황";
            } else if (_headerText == 'November') {
              _headerText = "11월 예약 현황";
            } else if (_headerText == 'December') {
              _headerText = "12월 예약 현황";
            }

            SchedulerBinding.instance.addPostFrameCallback((duration) {
              setState(() {});
            });
          },
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayCount: 4,
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            monthCellStyle: MonthCellStyle(
                textStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 12,
                    color: Colors.black),
                trailingDatesTextStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 15,
                    color: Colors.transparent),
                leadingDatesTextStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 15,
                    color: Colors.transparent),
                backgroundColor: Colors.transparent,
                todayBackgroundColor: Colors.transparent,
                leadingDatesBackgroundColor: Colors.transparent,
                trailingDatesBackgroundColor: Colors.transparent),
          ),
          dataSource: MeetingDataSource(_getDataSource()),
          todayHighlightColor: HexColor("#EE795F"),
          todayTextStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.redAccent, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            shape: BoxShape.rectangle,
          ),
          cellBorderColor: HexColor("#425c5a"),
        ),
      )
    ]);
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime startTime = DateTime(2022, 8, 15);
  final DateTime endTime = DateTime(2022, 8, 17);

  meetings.add(Meeting('', startTime, endTime, const Color(0xFF0F8644), true));
  meetings.add(Meeting(
      '', DateTime(2022, 8, 21), DateTime(2022, 8, 23), Colors.red, true));
  meetings.add(Meeting(
      '', DateTime(2022, 8, 22), DateTime(2022, 8, 24), Colors.orange, true));
  meetings.add(Meeting('', DateTime(2022, 8, 22), DateTime(2022, 8, 24),
      Colors.pinkAccent, true));
  return meetings;
}
