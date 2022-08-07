import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/setting/setting_semi_title.dart';
import 'package:start_app/widgets/test_button.dart';
import 'package:http/http.dart' as http;
import '../../../utils/common.dart';
import '../../splash/splash_screen.dart.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "설정",
          style: Common.startAppBarTextStyle,
        ),
        foregroundColor: Colors.white,
        backgroundColor: HexColor("#425c5a"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Container(
                  width: 80.w,
                  height: 80.w,
                  margin: EdgeInsets.only(left: 24.w),
                  decoration: BoxDecoration(
                    color: HexColor("#425c5a"),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: HexColor("#f3f3f3"), shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        "assets/icon_rent_person.svg",
                        color: HexColor("#425C5A"),
                        fit: BoxFit.fill,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "오승언",
                        style: TextStyle(
                            fontSize: 15.5.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "19101686",
                        style: TextStyle(
                            fontSize: 13.5.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text("에너지바이오대학",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      Text("식품공학과",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                  color: HexColor("#f3f3f3"),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "계정관리",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#425c5a")),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  SettingSemiTitle(title: "로그아웃", onPressed: () {},),
                  SettingSemiTitle(title: "비밀번호 변경", onPressed: () {},),
                  SettingSemiTitle(title: "회원탈퇴", onPressed: () {},),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h,),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                  color: HexColor("#f3f3f3"),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "총학생회 SNS 바로가기",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#425c5a")),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset("assets/icon_insta.svg", width: 30.w,),
                      SvgPicture.asset("assets/icon_youtube.svg", width: 35.w),
                      SvgPicture.asset("assets/icon_kakao.svg", width: 32.w),
                      SvgPicture.asset("assets/icon_web.svg", width: 30.w)
                    ],
                  ),
                  SizedBox(height: 18.h,),
                ],
              ),
            ),
            SizedBox(height: 8.h,),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                  color: HexColor("#f3f3f3"),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "약관 및 정책",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#425c5a")),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  SettingSemiTitle(title: "서비스 이용약관", onPressed: () {},),
                  SettingSemiTitle(title: "위치기반서비스 이용약관", onPressed: () {},),
                  SettingSemiTitle(title: "개인정보 처리방침", onPressed: () {},),
                  SettingSemiTitle(title: "정보제공처", onPressed: () {},),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                  color: HexColor("#f3f3f3"),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "정보",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#425c5a")),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  SettingSemiTitle(title: "업데이트", onPressed: () {},),
                  SettingSemiTitle(title: "개발 관련 정보", onPressed: () {},),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            TestButton(
              onPressed: () {
                Common.setNonLogin(false);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                    (route) => false);
              },
              title: "set nonlogin false",
            ),
            TestButton(
                title: "logout",
                onPressed: () async {
                  // 로그인 되어있는지부터 확인해야 함
                  _logout(navigator);
                })
          ],
        ),
      ),
      backgroundColor: HexColor("#425c5a"),
    );
  }

  /// ################################################
  /// #################### 로그아웃 ####################
  /// ################################################
  Future<void> _logout(NavigatorState navigator) async {
    final secureStorage = FlutterSecureStorage();
    final ACCESS_TOKEN = await secureStorage.read(key: "ACCESS_TOKEN");
    final REFRESH_TOKEN = await secureStorage.read(key: "REFRESH_TOKEN");

    Map<String, dynamic> resData91 = {};
    resData91["status"] = 400;

    try {
      var resString = await http.get(
          Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth/logout"),
          headers: {
            "Authorization": "Bearer $ACCESS_TOKEN",
            "Refresh": "Bearer $REFRESH_TOKEN"
          }).timeout(const Duration(seconds: 10));
      resData91 = jsonDecode(utf8.decode(resString.bodyBytes));
    } on TimeoutException catch (e) {
      print(e);
    } on SocketException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }

    await secureStorage.write(key: "ACCESS_TOKEN", value: "");
    await secureStorage.write(key: "REFRESH_TOKEN", value: "");

    await Common.setNonLogin(false);
    await Common.setAutoLogin(false);

    print("#################### 로그아웃 ####################");
    print("ACCESS_TOKEN & REFRESH_TOKEN");
    print("ACCESS_TOKEN : $ACCESS_TOKEN");
    print("REFRESH_TOKEN : $REFRESH_TOKEN");

    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false);
  }
}
