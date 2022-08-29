import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/models/status_code.dart';
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
import 'package:http/http.dart' as http;

import 'festival/new_festival/new_festival_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double pageIndex = 0.0;
  List<String> bannerLinkList = [];

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
          IconButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingScreen()))
            },
            icon: const Icon(Icons.settings_outlined),
            iconSize: 24.w,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
        ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: const Text(
            "한번 더 누르면 앱이 종료됩니다.",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              width: 0,
            ),
          ),
        ),
        child: Container(
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
                FutureBuilder(
                  future: fetchBannerLinkList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == StatusCode.SUCCESS) {
                      return Column(
                        children: [
                          SizedBox(
                              width: 260.w,
                              height: 260.h,
                              child: PageView.builder(
                                controller: PageController(
                                  initialPage: 0,
                                ),
                                onPageChanged: (page) {
                                  setState(() {
                                    pageIndex = page.toDouble();
                                  });
                                },
                                itemCount: bannerLinkList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: CachedNetworkImage(
                                      imageUrl: bannerLinkList[index],
                                      placeholder: (context, url) => Platform
                                              .isIOS
                                          ? const CupertinoActivityIndicator()
                                          : Center(
                                              child: CircularProgressIndicator(
                                              color: HexColor("#425c5a"),
                                            )),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: AspectRatio(
                                          aspectRatio: 1 / 1,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: HexColor("#c4c4c4"),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Image(
                                                    image: AssetImage(
                                                        "images/logo_crying_ready.png")),
                                                Text(
                                                  "이미지를 불러오지 못했습니다.",
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          HexColor("#6c6c6c")),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),
                          SizedBox(
                            height: 4.h,
                          ),
                          SizedBox(
                            height: 20.h,
                            child: DotsIndicator(
                              dotsCount: bannerLinkList.length,
                              position: pageIndex.toDouble(),
                              decorator: DotsDecorator(
                                activeColor: HexColor("#EE795F"),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.data == StatusCode.SERVER_ERROR) {
                      return Column(
                        children: [
                          BannerContainer("이미지를 불러오지 못했습니다."),
                          SizedBox(
                            height: 24.h,
                          )
                        ],
                      );
                    } else if (snapshot.data == StatusCode.UNCATCHED_ERROR) {
                      return Column(
                        children: [
                          BannerContainer("이미지를 불러오지 못했습니다."),
                          SizedBox(
                            height: 24.h,
                          )
                        ],
                      );
                    } else if (snapshot.data == StatusCode.TIMEOUT_ERROR) {
                      return Column(
                        children: [
                          BannerContainer("이미지를 불러오지 못했습니다."),
                          SizedBox(
                            height: 24.h,
                          )
                        ],
                      );
                    } else if (snapshot.data == StatusCode.CONNECTION_ERROR) {
                      return Column(
                        children: [
                          BannerContainer("오류가 발생했습니다."),
                          SizedBox(
                            height: 24.h,
                          )
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                              width: 280.w,
                              height: 280.h,
                              child: Platform.isIOS
                                  ? const CupertinoActivityIndicator(
                                      radius: 12,
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: HexColor("#425c5a"),
                                      ),
                                    )),
                          SizedBox(
                            height: 24.h,
                          )
                        ],
                      );
                    }
                  },
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
                                          builder: (context) =>
                                              const InfoScreen()))
                                }),
                        MainWidget(
                            title: "학사일정",
                            svgPath: "assets/icon_plan.svg",
                            isUnderRow: false,
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PlanScreen()))
                                }),
                        MainWidget(
                            title: "자치회비 납부 확인",
                            svgPath: "assets/icon_status.svg",
                            isUnderRow: false,
                            onPressed: () {
                              if (Common.getIsLogin()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StatusScreen()));
                                return;
                              }
                              Common.showSnackBar(context,
                                  "로그인이 필요한 기능입니다. '설정 > 로그인 하기'에서 로그인해주세요.");
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
                                          builder: (context) =>
                                              const RentScreen()))
                                }),
                        MainWidget(
                            title: "축제 이벤트",
                            svgPath: "assets/icon_festival.svg",
                            isUnderRow: true,
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NewFestivalScreen()))
                                }),
                        MainWidget(
                            title: "이벤트 참여",
                            svgPath: "assets/icon_event.svg",
                            isUnderRow: true,
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EventScreen()))
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
      ),
      backgroundColor: HexColor("#425c5a"),
    );
  }

  Widget BannerContainer(String title) {
    return SizedBox(
      width: 280.w,
      height: 280.h,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: HexColor("#c4c4c4"),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("images/logo_crying_ready.png")),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#6c6c6c")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<StatusCode> fetchBannerLinkList() async {
    print("배너 이미지를 호출합니다.");

    Map<String, dynamic> resData = {};

    try {
      final resString = await http
          .get(
            Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/banner"),
          )
          .timeout(const Duration(seconds: 10));
      resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 200) {
        List<String> tempBannerLinkList = [];

        for (var e in resData["data"]) {
          tempBannerLinkList.add(e["imageUrl"]);
        }

        bannerLinkList = tempBannerLinkList;
        return StatusCode.SUCCESS;
      }

      if (resData["status"] == 500) {
        return StatusCode.SERVER_ERROR;
      }

      if (resData["status"] != 200) {
        return StatusCode.UNCATCHED_ERROR;
      }

      return StatusCode.UNCATCHED_ERROR;
    } on TimeoutException catch (e) {
      return StatusCode.TIMEOUT_ERROR;
    } on SocketException catch (e) {
      return StatusCode.CONNECTION_ERROR;
    } catch (e) {
      return StatusCode.UNCATCHED_ERROR;
    }
  }
}
