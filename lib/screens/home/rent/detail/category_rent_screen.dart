import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:start_app/models/status_code.dart';
import 'package:start_app/screens/home/rent/detail/apply/rent_apply_screen.dart';
import 'package:start_app/screens/home/rent/detail/rent_detail_text.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../models/meeting.dart';
import '../../../../utils/common.dart';
import 'package:http/http.dart' as http;

class CategoryRentScreen extends StatefulWidget {
  CategoryRentScreen(
      {Key? key,
      required this.categoryKr,
      required this.categoryEng,
      required this.itemIcon,
      required this.itemImg,
      required this.itemPurpose,
      })
      : super(key: key);

  String categoryKr;
  String categoryEng;
  String itemIcon;
  String itemImg;
  String itemPurpose;

  @override
  State<CategoryRentScreen> createState() => _CategoryRentScreenState();
}

class _CategoryRentScreenState extends State<CategoryRentScreen> {
  List<Meeting> meetingList = [];
  final _calendarController = CalendarController();
  final DateTime today = DateTime.now();
  late String _headerText = today.month.toString();
  int totalAvailableCount = 0;
  int selectedDayAvailableCount = 0;
  List<Color> colorList = [
    HexColor("#F9A9A9"),
    HexColor("#A9D3F9"),
    HexColor("#F9E3A9"),
    HexColor("#D1A9F9"),
    HexColor("#55D6C2"),
    HexColor("#9BEAEF"),
    HexColor("#D4989A"),
    HexColor("#5E879D"),
    HexColor("#E6C8E0"),
    HexColor("#FFC4A6"),
  ];

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchSelectedItemRentState(
        widget.categoryEng, today.year.toString(), today.month.toString());
    fetchTotalAvailableCount(widget.categoryEng);
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
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 25.w,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                  width: 130.w,
                  height: 140.h,
                  color: HexColor("#F3F3F3"),
                  child: Image(
                    image: AssetImage(widget.itemImg),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  children: [
                    RentDetailText(
                      category: widget.categoryKr,
                      itemPurpose: widget.itemPurpose,
                      itemTotalCnt: totalAvailableCount,
                    ),
                    Common.getIsLogin()
                        ? GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RentApplyScreen(
                                  categoryKr: widget.categoryKr,
                                  categoryEng: widget.categoryEng,
                                  itemIcon: widget.itemIcon,
                                )))
                      },
                      child: Container(
                        width: 120.w,
                        height: 25.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: HexColor("#ffcea2"),
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          "대여하러 가기",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                        : GestureDetector(
                      onTap: () => {
                        Common.showSnackBar(context,
                            "로그인이 필요한 기능입니다. '설정 > 로그인 하기'에서 로그인해주세요.")
                      },
                      child: Container(
                        width: 120.w,
                        height: 25.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: HexColor("#ffcea2"),
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          "대여하러 가기",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              width: double.infinity,
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
                          await fetchSelectedItemRentState(
                              widget.categoryEng, _year, _month);
                        },
                        onSelectionChanged: (CalendarSelectionDetails
                        calendarSelectionDetails) {
                          final nowDate =
                          DateTime(today.year, today.month, today.day);
                          int selectedDayBookCount = 0;
                          if (totalAvailableCount == 0) {
                            return;
                          }

                          if (calendarSelectionDetails.date == null) {
                            return;
                          }

                          int? tmp0 = calendarSelectionDetails.date
                              ?.difference(nowDate)
                              .inHours;
                          if (tmp0 != null) {
                            if (tmp0 < 0) {
                              setState(() {
                                selectedDayAvailableCount = 0;
                              });
                              return;
                            }
                          }

                          int ac = totalAvailableCount;

                          for (var e in meetingList) {
                            int? tmp1 = calendarSelectionDetails.date
                                ?.difference(e.from)
                                .inHours;
                            int? tmp2 = calendarSelectionDetails.date
                                ?.difference(e.to)
                                .inHours;
                            if (tmp1 == null || tmp2 == null) {
                              return;
                            }
                            if (tmp1 >= 0 && tmp2 <= 0) {
                              selectedDayBookCount++;
                            }
                          }
                          ac = totalAvailableCount - selectedDayBookCount;
                          setState(() {
                            selectedDayAvailableCount = ac;
                          });
                        },
                        monthViewSettings: MonthViewSettings(
                          appointmentDisplayCount: widget.categoryKr == "의자"
                              ? 10 : 4,
                          appointmentDisplayMode: widget.categoryKr == "의자"
                              ? MonthAppointmentDisplayMode.indicator
                              : MonthAppointmentDisplayMode.appointment,
                          monthCellStyle: MonthCellStyle(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: HexColor("#425C5A")),
                            trailingDatesTextStyle: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                                color: Colors.transparent),
                            leadingDatesTextStyle: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                                color: Colors.transparent),
                            backgroundColor: HexColor("#f3f3f3"),
                            todayBackgroundColor: HexColor("#f3f3f3"),
                            leadingDatesBackgroundColor:
                            HexColor("#92AEAC").withOpacity(0.5),
                            trailingDatesBackgroundColor:
                            HexColor("#92AEAC").withOpacity(0.5),
                          ),
                        ),
                        dataSource: MeetingDataSource(meetingList),
                        todayHighlightColor: HexColor("#EE795F"),
                        todayTextStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                        selectionDecoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: HexColor("#EE795F"), width: 1.5),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(4)),
                          shape: BoxShape.rectangle,
                        ),
                        cellBorderColor: HexColor("#425c5a"),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10.h, left: 16.w),
                        margin: EdgeInsets.only(bottom: 100.h),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text("$selectedDayAvailableCount개 대여가능",
                                style: TextStyle(
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: 10.h,
                            )
                          ],
                        ))
                  ])),
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
        for (int i = 0; i < e["account"]; i++) {
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
              getRandomColor(),
              true));
        }
      }

      setState(() {
        meetingList = tempMeetingList;
      });

      return;
    } catch (e) {
      setState(() {
        meetingList = tempMeetingList;
      });
      debugPrint("fetchSelectedItemRentState() call : Error");
      debugPrint(e.toString());
    }
  }

  Future<StatusCode> fetchTotalAvailableCount(String itemCategory) async {
    try {
      final resString = await http
          .get(Uri.parse(
          "${dotenv.get("DEV_API_BASE_URL")}/rent/item/calendar?category=${itemCategory}"))
          .timeout(const Duration(seconds: 30));
      Map<String, dynamic> resData =
      jsonDecode(utf8.decode(resString.bodyBytes));
      debugPrint(resData.toString());

      if (resData["status"] != 200) {
        debugPrint("fetchTotalAvailableCount() call : Error. not 200");
        return StatusCode.UNCATCHED_ERROR;
      }

      debugPrint("fetchTotalAvailableCount() call : Success");

      setState(() {
        totalAvailableCount = resData["data"][0]["count"];
      });
      debugPrint("totalAvailableCount : ${totalAvailableCount.toString()}");
      return StatusCode.SUCCESS;
    } catch (e) {
      debugPrint(e.toString());
      return StatusCode.UNCATCHED_ERROR;
    }
  }

  Color getRandomColor() {
    int ranNum = Random().nextInt(10);
    return colorList[ranNum];
  }
}