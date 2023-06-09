import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/plan_notifier.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../models/meeting.dart';

class PlanCalendar extends StatefulWidget {
  @override
  State<PlanCalendar> createState() => _PlanCalendarState();
}

class _PlanCalendarState extends State<PlanCalendar> {

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanNotifier>(builder: (context, planNotifier, child) {
      final source = planNotifier.getMeetingList();

      return Container(
        color: planNotifier.getIsLoading()
            ? HexColor("#929d9c")
            : HexColor("#425C5A"),
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        height: 330.h,
        child: SfCalendar(
          view: CalendarView.month,
          onViewChanged: (ViewChangedDetails viewChangedDetails) {
            SchedulerBinding.instance
                .addPostFrameCallback((Duration duration) async {
              final _year = DateFormat('yyyy').format(viewChangedDetails
                  .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]);
              final _month = DateFormat('M').format(viewChangedDetails
                  .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]);
              await planNotifier.fetchMeetingList(
                  int.parse(_year), int.parse(_month));
            });
          },
          onSelectionChanged: (_) {
            final tmp1 = _.date?.day;
            final tmp2 = _.date?.weekday;
            planNotifier.setCurDay(tmp1!);
            planNotifier.setCurWeekDay(tmp2!);
            planNotifier.setSelectedDayMeetingList(
                _.date?.year, _.date?.month, _.date?.day);
          },
          cellEndPadding: 5,
          headerStyle: const CalendarHeaderStyle(
              textStyle: TextStyle(
                  fontSize: 23,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                  fontWeight: FontWeight.w300)),
          headerDateFormat: 'MMM',
          viewHeaderStyle: ViewHeaderStyle(
            dayTextStyle: TextStyle(
                fontSize: 14.5.sp,
                color: Color(0xffff5eaea),
                fontWeight: FontWeight.w500),
          ),
          backgroundColor: planNotifier.getIsLoading()
              ? HexColor("#929d9c")
              : HexColor("#425c5a"),
          cellBorderColor: Colors.white,
          todayTextStyle: const TextStyle(color: Colors.white),
          //선택 날짜 border. 기본 파랑색.
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.redAccent, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            shape: BoxShape.rectangle,
          ),
          dataSource: MeetingDataSource(source),
          todayHighlightColor: HexColor("#EE795F"),
          monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
            showAgenda: false,
            numberOfWeeksInView: 6,
            appointmentDisplayCount: 4,
            dayFormat: 'EEE',
            navigationDirection: MonthNavigationDirection.horizontal,
            showTrailingAndLeadingDates: false,
            monthCellStyle: MonthCellStyle(
                textStyle: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 12,
                    color: Colors.white),
                backgroundColor: HexColor("#425C5A"),
                todayBackgroundColor: Colors.transparent,
                leadingDatesBackgroundColor:
                    HexColor("92AEAC").withOpacity(0.5),
                trailingDatesBackgroundColor:
                    HexColor("92AEAC").withOpacity(0.5)),
          ),
        ),
      );
    });
  }
}
