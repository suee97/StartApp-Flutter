import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/event/event_screen.dart';
import 'package:start_app/screens/home/festival/festival_screen.dart';
import 'package:start_app/screens/home/info/info_screen.dart';
import 'package:start_app/screens/home/plan/plan_screen.dart';
import 'package:start_app/screens/home/setting/setting_screen.dart';
import 'package:start_app/screens/home/rent/rent_screen.dart';
import 'package:start_app/screens/home/status/status_screen.dart';
import 'package:start_app/widgets/main_widget.dart';
import '../../utils/common.dart';
import '../../widgets/yellow_line.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double pageIndex = 0.0;

  @override
  void initState() {
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
          // Padding(
          // padding: EdgeInsets.only(top: 3.0.w),
          // child: IconButton(
          IconButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()))
            },
            icon: const Icon(Icons.settings_outlined),
            // icon: SvgPicture.asset("assets/icon_person.svg"),
            iconSize: 24.w,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          // )
        ],
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
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://cdn.givemesport.com/wp-content/uploads/2022/04/GettyImages-499043422-1200x1200-c-default.jpg",
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          color: HexColor("#425c5a"),
                        )),
                        errorWidget: (context, url, error) => Center(
                          child: AspectRatio(
                            aspectRatio: 1/1,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: HexColor("#c4c4c4"),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Image(
                                      image: AssetImage(
                                          "images/logo_crying_ready.png")),
                                  Text(
                                    "이미지를 불러오지 못했습니다.",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: HexColor("#6c6c6c")),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              DotsIndicator(
                dotsCount: 3,
                position: pageIndex.toDouble(),
                decorator: DotsDecorator(
                  activeColor: HexColor("#EE795F"),
                ),
              ),
              Column(children: [
                const YellowLine(),
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
                const YellowLine(),
              ]),
            ],
          ),
        ),
      ),
      backgroundColor: HexColor("#425c5a"),
    );
  }
}
