import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/event/event_screen.dart';
import 'package:start_app/screens/home/festival/festival_screen.dart';
import 'package:start_app/screens/home/info/info_screen.dart';
import 'package:start_app/screens/home/plan/plan_screen.dart';
import 'package:start_app/screens/home/profile/profile_screen.dart';
import 'package:start_app/screens/home/rent/rent_screen.dart';
import 'package:start_app/screens/home/status/status_screen.dart';
import 'package:start_app/widgets/main_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "서울과학기술대학교 총학생회",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: HexColor("#425C5A"),
          foregroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: IconButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()))
                },
                icon: SvgPicture.asset("assets/icon_person.svg"),
                iconSize: 24.w,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
            )
          ],
          leading: IconButton(
            onPressed: () => {},
            icon: SvgPicture.asset(
              "assets/icon_notification.svg",
            ),
            iconSize: 24,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          )),
      body: Container(
        color: HexColor("#425C5A"),
        height: double.infinity,
        width: double.infinity,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: HexColor("#f3f3f3"),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 300.w,
                height: 300.h,
                child: Image.network(
                  "http://cdn.shopify.com/s/files/1/0151/0741/products/ad1fa8fb3ebf60288317c53c17d5880d_1024x1024.jpg?v=1578648923",
                  fit: BoxFit.fill,
                ),
              ),
              Column(children: [
                Container(
                  width: double.infinity,
                  height: 12.h,
                  child: SvgPicture.asset(
                    "assets/yellow_line.svg",
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MainWidget(
                          title: "총학생회 설명",
                          svgPath: "assets/icon_info.svg",
                          isUnderRow: false,
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoScreen()))
                              }),
                      MainWidget(
                          title: "학사일정",
                          svgPath: "assets/icon_plan.svg",
                          isUnderRow: false,
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlanScreen()))
                              }),
                      MainWidget(
                          title: "재학생 확인 및\n자치회비 납부 확인",
                          svgPath: "assets/icon_status.svg",
                          isUnderRow: false,
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StatusScreen()))
                              }),
                    ]),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MainWidget(
                          title: "상시사업",
                          svgPath: "assets/icon_rent.svg",
                          isUnderRow: true,
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RentScreen()))
                              }),
                      MainWidget(
                          title: "주 사업",
                          svgPath: "assets/icon_festival.svg",
                          isUnderRow: true,
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FestivalScreen()))
                              }),
                      MainWidget(
                          title: "이벤트 참여",
                          svgPath: "assets/icon_event.svg",
                          isUnderRow: true,
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EventScreen()))
                              }),
                    ]),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  width: double.infinity,
                  height: 12.h,
                  child: SvgPicture.asset(
                    "assets/yellow_line.svg",
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
