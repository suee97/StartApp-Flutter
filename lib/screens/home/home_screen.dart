import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
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
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double pageIndex = 0.0;

  List<String> bannerLinkList = [];

  Future<StatusCode> fetchBannerLinkList() async {
    Map<String, dynamic> resData = {};
    try {
      var resString = await http
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

      return StatusCode.DEFAULT;
    } on TimeoutException catch (e) {
      print("TimeoutException : $e");
      return StatusCode.TIMEOUT_ERROR;
    } on SocketException catch (e) {
      print("SocketException : $e");
      return StatusCode.CONNECTION_ERROR;
    } catch (e) {
      print("UnCatchedError : $e");
      return StatusCode.UNCATCHED_ERROR;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBannerLinkList();
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()))
            },
            icon: const Icon(Icons.settings_outlined),
            iconSize: 24.w,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
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
              FutureBuilder(
                future: fetchBannerLinkList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == StatusCode.SUCCESS) {
                    return Column(
                      children: [
                        Container(
                            width: 280.w,
                            height: 280.h,
                            child: PageView.builder(
                              controller: PageController(
                                initialPage: 0,
                              ),
                              itemCount: bannerLinkList.length,
                              itemBuilder: (BuildContext context, int index) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    pageIndex = index.toDouble();
                                  });
                                });
                                return AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: CachedNetworkImage(
                                    imageUrl: bannerLinkList[index],
                                    placeholder: (context, url) => Center(
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
                            )),
                        SizedBox(
                          height: 4.h,
                        ),
                        DotsIndicator(
                          dotsCount: bannerLinkList.length,
                          position: pageIndex.toDouble(),
                          decorator: DotsDecorator(
                            activeColor: HexColor("#EE795F"),
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
                        BannerContainer("네트워크 연결상태를 확인해주세요."),
                        SizedBox(
                          height: 24.h,
                        )
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                            width: 280.w,
                            height: 280.h,
                            child: Platform.isIOS
                                ? CupertinoActivityIndicator()
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

  Widget BannerContainer(String title) {
    return Container(
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
}
