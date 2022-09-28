import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/utils/common.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({Key? key}) : super(key: key);

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final historyList = [
      UpdateHistoryWidget(
          "1.0.1", DateTime(2022, 9, 7), ["ST'art 총학생회 어플리케이션 출시"]),
      UpdateHistoryWidget(
          "1.0.2", DateTime(2022, 9, 20), ["오타 및 버그 수정", "UI/UX 개선"]),
      UpdateHistoryWidget(
          "1.0.3", DateTime(2022, 9, 20), ["상시사업 현황이 제대로 보이지 않는 문제 수정"]),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "업데이트 내역",
          style: Common.startAppBarTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
        foregroundColor: HexColor("#425c5a"),
        backgroundColor: HexColor("#f3f3f3"),
      ),
      body: ListView.builder(
          itemCount: historyList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: historyList.reversed.toList()[index],
            );
          }),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  Widget UpdateHistoryWidget(
      String version, DateTime date, List<String> historyList) {
    return Container(
      width: 320.w,
      decoration: BoxDecoration(
          color: HexColor("#92AEAC").withOpacity(0.5),
          border: Border.all(
            width: 2,
            color: HexColor("#425C5A"),
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.only(left: 28.w, top: 20.h, bottom: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "앱 버전 : $version",
              style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              "업데이트 내역",
              style:
                  TextStyle(fontSize: 15.5.sp, fontWeight: FontWeight.w600, color: HexColor("#425c5a")),
            ),
            SizedBox(
              height: 8.h,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: historyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(historyList[index]);
                }),
            SizedBox(
              height: 16.h,
            ),
            Text(
              "업데이트 날짜 : ${date.year}/${date.month}/${date.day}",
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
