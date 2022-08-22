import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:start_app/screens/home/rent/detail/apply/rent_apply_screen.dart';
import 'package:start_app/screens/home/rent/detail/rent_detail_text.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../models/meeting.dart';
import '../../../../utils/common.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class CategoryRentScreen extends StatefulWidget {
  CategoryRentScreen(
      {Key? key,
      required this.categoryKr,
      required this.categoryEng,
      required this.itemIcon,
      required this.itemImg,
      required this.itemPurpose,
      required this.itemWarning})
      : super(key: key);

  String categoryKr;
  String categoryEng;
  String itemIcon;
  String itemImg;
  String itemPurpose;
  String itemWarning;

  @override
  State<CategoryRentScreen> createState() => _CategoryRentScreenState();
}

class _CategoryRentScreenState extends State<CategoryRentScreen> {
  List<Meeting> meetingList = [];
  final _calendarController = CalendarController();
  final DateTime today = DateTime.now();
  late String _headerText = today.month.toString();

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchSelectedItemRentState(widget.categoryEng, "2022", "8");
    super.initState();
  }

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
                  color: HexColor("#F3F3F3"),
                  child: Image(
                    image: AssetImage(widget.itemImg),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                RentDetailText(
                    category: widget.categoryKr,
                    itemPurpose: widget.itemPurpose,
                    itemWarning: widget.itemWarning)
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
                  child: Column(children: [
                    Container(
                      width: 180.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                          color: HexColor("#FFCEA2"),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _calendarController.backward!();
                            },
                            child: SizedBox(
                                width: 20.w,
                                height: 18.h,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 6.w,
                                      right: 6.w,
                                      top: 4.h,
                                      bottom: 4.h),
                                  child: SvgPicture.asset(
                                    'assets/back_btn.svg',
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ),
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
                                      left: 6.w,
                                      right: 6.w,
                                      top: 4.h,
                                      bottom: 4.h),
                                  child: SvgPicture.asset(
                                    'assets/forward_btn.svg',
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 330.h,
                      child: SfCalendar(
                        view: CalendarView.month,
                        controller: _calendarController,
                        headerHeight: 0,
                        onViewChanged:
                            (ViewChangedDetails viewChangedDetails) async {
                          if (_calendarController.view == CalendarView.month) {
                            _headerText = DateFormat('MMMM')
                                .format(viewChangedDetails.visibleDates[
                                    viewChangedDetails.visibleDates.length ~/
                                        2])
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

                          SchedulerBinding.instance
                              .addPostFrameCallback((duration) {
                            setState(() {});
                          });

                          final _year = DateFormat('yyyy').format(
                              viewChangedDetails.visibleDates[
                                  viewChangedDetails.visibleDates.length ~/ 2]);
                          final _month = DateFormat('M').format(
                              viewChangedDetails.visibleDates[
                                  viewChangedDetails.visibleDates.length ~/ 2]);
                          fetchSelectedItemRentState(
                              widget.categoryEng, _year, _month);
                        },
                        monthViewSettings: const MonthViewSettings(
                          appointmentDisplayCount: 4,
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.appointment,
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
                            trailingDatesBackgroundColor: Colors.transparent,
                          ),
                        ),
                        dataSource: MeetingDataSource(meetingList),
                        todayHighlightColor: HexColor("#EE795F"),
                        todayTextStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                        selectionDecoration: BoxDecoration(
                          color: Colors.transparent,
                          border:
                              Border.all(color: Colors.redAccent, width: 1.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          shape: BoxShape.rectangle,
                        ),
                        cellBorderColor: HexColor("#425c5a"),
                      ),
                    )
                  ])),
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
                                  fontSize: 11.5.sp,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                  Common.getIsLogin()
                      ? GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RentApplyScreen(
                                          category: widget.categoryKr,
                                          itemIcon: widget.itemIcon,
                                        )))
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
                                  fontSize: 21.5.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () =>
                              {Common.showSnackBar(context, "로그인이 필요한 기능입니다.")},
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
                                  fontSize: 21.5.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: HexColor("#425C5A"),
    );
  }

  Future<void> fetchSelectedItemRentState(
      String itemCategory, String year, String month) async {
    List<Meeting> tempMeetingList = [];

    try {
      final resString = await http
          .get(Uri.parse(
              "${dotenv.get("DEV_API_BASE_URL")}/rent/calendar?month=${month}&year=${year}&category=${itemCategory}"))
          .timeout(const Duration(seconds: 30));
      Map<String, dynamic> resData =
          jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] != 200) {
        return;
      }

      List<dynamic> data = resData["data"];
      for (var e in data) {
        tempMeetingList.add(Meeting(
            "",
            DateTime(
                int.parse(e["startTime"].substring(0, 4)),
                int.parse(e["startTime"].substring(5, 7)),
                int.parse(e["startTime"].substring(8, 10))),
            DateTime(
                int.parse(e["endTime"].substring(0, 4)),
                int.parse(e["endTime"].substring(5, 7)),
                int.parse(e["endTime"].substring(8, 10))),
            Colors.purpleAccent,
            true));
      }

      setState(() {
        meetingList = tempMeetingList;
      });
    } catch (e) {
      print("fetchSelectedItemRentState() call : Error");
      print(e);
    }
  }
}
