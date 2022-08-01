import 'package:dots_indicator/dots_indicator.dart';
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

import '../../utils/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Image> _logos;
  double pageIndex = 0.0;

  void getMainLogos() {
    var a = Image.network(
      "http://cdn.shopify.com/s/files/1/0151/0741/products/ad1fa8fb3ebf60288317c53c17d5880d_1024x1024.jpg?v=1578648923",
    );
    var b = Image.network(
        "http://competitions.teamtalk.com/image-library/square/1000/7/7bb04cbb0265-teamtalk-com.jpg");
    var c = Image.network(
        "https://cdn.givemesport.com/wp-content/uploads/2022/04/GettyImages-499043422-1200x1200-c-default.jpg");
    setState(() {
      _logos = [b, a, c];
    });
  }

  @override
  void initState() {
    getMainLogos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "서울과학기술대학교 총학생회",
          style: Common.startAppBarTextStyle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: HexColor("#425C5A"),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 3.0.w),
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
        // leading: IconButton(
        //   onPressed: () => {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => NotificationScreen()))
        //   },
        //   icon: SvgPicture.asset(
        //     "assets/icon_notification.svg",
        //   ),
        //   iconSize: 24,
        //   hoverColor: Colors.transparent,
        //   highlightColor: Colors.transparent,
        //   splashColor: Colors.transparent,
        // )
      ),
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
                height: 25.h,
              ),
              Container(
                width: 280.w,
                height: 280.h,
                child: PageView.builder(
                  controller: PageController(
                    initialPage: 0,
                  ),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        pageIndex = index.toDouble();
                      });
                    });
                    return AspectRatio(
                      aspectRatio: 1 / 1,
                      child: _logos.isNotEmpty
                          ? _logos[index]
                          : const Center(child: Text("loading...")),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              DotsIndicator(
                dotsCount: _logos.length,
                position: pageIndex.toDouble(),
                decorator: DotsDecorator(
                  activeColor: HexColor("#EE795F"),
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
                  height: 12.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
