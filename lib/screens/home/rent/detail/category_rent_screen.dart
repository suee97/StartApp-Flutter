import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/rent/detail/apply/rent_apply_screen.dart';
import 'package:start_app/screens/home/rent/detail/rent_calendar.dart';
import 'package:start_app/screens/home/rent/detail/rent_detail_text.dart';
import '../../../../utils/common.dart';

class CategoryRentScreen extends StatelessWidget {
  CategoryRentScreen(
      {Key? key,
      required this.category,
      required this.itemIcon,
      required this.itemImg,
      required this.itemPurpose,
      required this.itemWarning})
      : super(key: key);

  String category;
  String itemIcon;
  String itemImg;
  String itemPurpose;
  String itemWarning;

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
                    image: AssetImage(itemImg),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                RentDetailText(
                    category: category,
                    itemPurpose: itemPurpose,
                    itemWarning: itemWarning)
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
                  padding: EdgeInsets.only(top: 4.h), child: RentCalendar()),
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
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RentApplyScreen(
                                    category: category,
                                    itemIcon: itemIcon,
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
                            fontSize: 21.5.sp, fontWeight: FontWeight.w600),
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
}
