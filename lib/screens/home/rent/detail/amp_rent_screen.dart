import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_app/widgets/test_button.dart';
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
        height: double.infinity,
        child: Column(
          children: [
            Container(
              child: Text("예약 및 대여 현황", style: TextStyle(fontSize: 32),),
            ),
            SizedBox(height: 30,),
            Container(
              width: double.infinity,
              height: 200.w,
              child: SfCalendar(
                view: CalendarView.timelineMonth,
                dataSource: MeetingDataSource(_getDataSource()),
                todayHighlightColor: Colors.transparent,
                todayTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700
                ),
                selectionDecoration: const BoxDecoration(),
                cellBorderColor: Colors.black,
              ),
            ),
            SizedBox(height: 30,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TestButton(title: "대여하기", onPressed: () => {}),
                  TestButton(title: "사진보기", onPressed: () => {}),
                ],
              ),
            )
          ],
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
  meetings.add(Meeting('', DateTime(2022, 7, 21), DateTime(2022, 7, 23), Colors.red, true));
  meetings.add(Meeting('', DateTime(2022, 7, 22), DateTime(2022, 7, 24), Colors.orange, true));
  return meetings;
}