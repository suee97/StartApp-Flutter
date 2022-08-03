import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/rent/detail/apply/rent_apply_screen.dart';
import 'package:start_app/screens/home/rent/detail/rent_detail_text.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../models/meeting.dart';
import '../../../../utils/common.dart';

class AmpRentScreen extends StatelessWidget {
  const AmpRentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "상시사업 예약",
          style: Common.startAppBarTextStyle,
        ),
        foregroundColor: Colors.white,
        backgroundColor: HexColor("#425C5A"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 13.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  width: 144.w,
                  height: 192.h,
                  color: Colors.grey,
                  child: Image(
                    image: AssetImage("images/logo_crying_ready.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                const RentDetailText()
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              width: double.infinity,
              height: 370.h,
              decoration: BoxDecoration(
                  color: HexColor("#f3f3f3"),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: SfCalendar(
                  view: CalendarView.month,
                  headerDateFormat: "MMMM",
                  headerStyle: CalendarHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(fontSize: 11.5.sp)),
                  monthViewSettings: const MonthViewSettings(
                      appointmentDisplayCount: 4,
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment,
                      monthCellStyle: MonthCellStyle(
                          textStyle: TextStyle(color: Colors.black))),
                  dataSource: MeetingDataSource(_getDataSource()),
                  todayHighlightColor: Colors.orange,
                  todayTextStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                  selectionDecoration: const BoxDecoration(),
                  cellBorderColor: HexColor("#425c5a"),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: HexColor("#f3f3f3"),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6.h, bottom: 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16.w),
                          child: Text(
                            "1개 사용가능",
                            style: TextStyle(
                                fontSize: 11.5.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16.w),
                          child: Text("1개 대여중",
                              style: TextStyle(
                                  fontSize: 11.5.sp, fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RentApplyScreen()))
                    },
                    child: Container(
                      width: 320.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: HexColor("#ffcea2"),
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        "대여하러 가기",
                        style: TextStyle(
                            fontSize: 21.5.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,)
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: HexColor("#425C5A"),
    );
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
