import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/utils/common.dart';

class UpdateInfoScreen extends StatelessWidget {
  const UpdateInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UpdateHistoryWidget(
              "1.0.0", DateTime(2022, 8, 23), ["ST'art 총학생회 어플리케이션 출시"]),
        ],
      ),
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
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Text(
                "업데이트 내역",
                style:
                    TextStyle(fontSize: 15.5.sp, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: historyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text("    - ${historyList[index]}");
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
