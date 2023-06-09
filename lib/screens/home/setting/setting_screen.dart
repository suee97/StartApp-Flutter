import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_app/models/status_code.dart';
import 'package:start_app/screens/home/setting/app_info/dev_info_screen.dart';
import 'package:start_app/screens/home/setting/app_info/update_info_screen.dart';
import 'package:start_app/screens/home/setting/pw_change_screen.dart';
import 'package:start_app/screens/home/setting/setting_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:start_app/screens/home/setting/suggest/suggest_error_screen.dart';
import 'package:start_app/screens/home/setting/suggest/suggest_etc_screen.dart';
import 'package:start_app/screens/home/setting/suggest/suggest_feature_screen.dart';
import 'package:start_app/screens/login/login_option_screen.dart';
import 'package:start_app/screens/login/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../utils/auth.dart';
import '../../../utils/common.dart';
import '../../../utils/department_match.dart';
import '../../../widgets/start_android_dialog.dart';
import '../../splash/splash_screen.dart.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _name = '';
  String _studentNo = '';
  String _studentGroup = '';
  String _department = '';
  String _phoneNo = '';
  final secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadStudentInfo();
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
                  child: Common.getIsLogin()
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _name,
                              style: TextStyle(
                                  fontSize: 15.5.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              _studentNo,
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(_studentGroup,
                                style: TextStyle(
                                    fontSize: 13.5.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                            Text(_department,
                                style: TextStyle(
                                    fontSize: 13.5.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                            Text(_phoneNo,
                                style: TextStyle(
                                    fontSize: 13.5.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "로그인이 필요합니다.",
                              style: TextStyle(
                                  fontSize: 15.5.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (Platform.isIOS) {
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          content: const Text(
                                              "확인을 누르면 로그인 화면으로 이동합니다."),
                                          actions: [
                                            CupertinoDialogAction(
                                                isDefaultAction: false,
                                                child: const Text("확인"),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const LoginOptionScreen()),
                                                          (route) => false);
                                                }),
                                            CupertinoDialogAction(
                                                isDefaultAction: false,
                                                child: const Text("취소"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        );
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StartAndroidDialog(
                                          title: "확인을 누르면 로그인 화면으로 이동합니다.",
                                          onOkPressed: () {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginOptionScreen()),
                                                    (route) => false);
                                          },
                                          onCancelPressed: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      });
                                }
                              },
                              child: Container(
                                width: 100.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                    color: HexColor("#FFCEA2"),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "로그인 하기",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: HexColor("#425C5A"),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
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
                  color: Common.getIsLogin() == true
                      ? HexColor("#f3f3f3")
                      : HexColor("f3f3f3").withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20)),
              child: Common.getIsLogin() == true
                  ? Column(
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
                        SettingSemiTitle(
                          title: "로그아웃",
                          onPressed: () {
                            if (Platform.isIOS) {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      content: const Text("로그아웃 하시겠습니까?"),
                                      actions: [
                                        CupertinoDialogAction(
                                            isDefaultAction: false,
                                            child: const Text("확인"),
                                            onPressed: () async {
                                              await _logout(navigator);
                                            }),
                                        CupertinoDialogAction(
                                            isDefaultAction: false,
                                            child: const Text("취소"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            })
                                      ],
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StartAndroidDialog(
                                      title: "로그아웃 하시겠습니까?",
                                      onOkPressed: () async {
                                        await _logout(navigator);
                                      },
                                      onCancelPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  });
                            }
                          },
                        ),
                        SettingSemiTitle(
                          title: "비밀번호 재설정",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PwChangeScreen()));
                          },
                        ),
                        SettingSemiTitle(
                          title: "회원탈퇴",
                          onPressed: () {
                            if (Platform.isIOS) {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: const Text("회원탈퇴"),
                                      content: const Text(
                                          "회원탈퇴 시 재가입이 어려울 수 있습니다. (문의 : 02-970-7012)\n탈퇴하시려면 \"탈퇴\"버튼을 눌러주세요."),
                                      actions: [
                                        CupertinoDialogAction(
                                            isDefaultAction: false,
                                            child: const Text("탈퇴"),
                                            onPressed: () async {
                                              final deleteUserResult =
                                                  await deleteUser();
                                              if (deleteUserResult ==
                                                  StatusCode.REFRESH_EXPIRED) {
                                                await secureStorage.write(
                                                    key: "ACCESS_TOKEN",
                                                    value: "");
                                                await secureStorage.write(
                                                    key: "REFRESH_TOKEN",
                                                    value: "");
                                                await Common.setNonLogin(false);
                                                await Common.setAutoLogin(
                                                    false);
                                                Common.setIsLogin(false);
                                                await Common
                                                    .clearStudentInfoPref();
                                                if (!mounted) return;
                                                Common.showSnackBar(
                                                    context, "다시 로그인해주세요.");
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginScreen()),
                                                    (route) => false);
                                                return;
                                              }
                                              if (deleteUserResult ==
                                                  StatusCode.SUCCESS) {
                                                if (!mounted) return;
                                                Common.showSnackBar(context,
                                                    "탈퇴가 완료되었습니다. 이용해주셔서 감사합니다.");
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginOptionScreen()),
                                                    (route) => false);
                                                return;
                                              }
                                              if (!mounted) return;
                                              Common.showSnackBar(
                                                  context, "오류가 발생했습니다.");
                                            }),
                                        CupertinoDialogAction(
                                            isDefaultAction: true,
                                            child: const Text("취소"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            })
                                      ],
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "회원탈퇴",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                            color: HexColor("#425C5A")),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                              "회원탈퇴 시 재가입이 어려울 수 있습니다. (문의 : 02-970-7012)"),
                                          const Text(
                                              "탈퇴하시려면 \"탈퇴\"버튼을 두번 탭해주세요."),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                behavior:
                                                    HitTestBehavior.translucent,
                                                onDoubleTap: () async {
                                                  final deleteUserResult =
                                                      await deleteUser();
                                                  if (deleteUserResult ==
                                                      StatusCode
                                                          .REFRESH_EXPIRED) {
                                                    await secureStorage.write(
                                                        key: "ACCESS_TOKEN",
                                                        value: "");
                                                    await secureStorage.write(
                                                        key: "REFRESH_TOKEN",
                                                        value: "");
                                                    await Common.setNonLogin(
                                                        false);
                                                    await Common.setAutoLogin(
                                                        false);
                                                    Common.setIsLogin(false);
                                                    await Common
                                                        .clearStudentInfoPref();
                                                    if (!mounted) return;
                                                    Common.showSnackBar(
                                                        context, "다시 로그인해주세요.");
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginScreen()),
                                                        (route) => false);
                                                    return;
                                                  }
                                                  if (deleteUserResult ==
                                                      StatusCode.SUCCESS) {
                                                    await secureStorage.write(
                                                        key: "ACCESS_TOKEN",
                                                        value: "");
                                                    await secureStorage.write(
                                                        key: "REFRESH_TOKEN",
                                                        value: "");
                                                    await Common.setNonLogin(
                                                        false);
                                                    await Common.setAutoLogin(
                                                        false);
                                                    Common.setIsLogin(false);
                                                    await Common
                                                        .clearStudentInfoPref();
                                                    if (!mounted) return;
                                                    Common.showSnackBar(context,
                                                        "탈퇴가 완료되었습니다. 이용해주셔서 감사합니다.");
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginOptionScreen()),
                                                        (route) => false);
                                                    return;
                                                  }
                                                  if (!mounted) return;
                                                  Common.showSnackBar(
                                                      context, "오류가 발생했습니다.");
                                                },
                                                child: Container(
                                                  width: 114.w,
                                                  height: 40.h,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#425c5a"),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10))),
                                                  child: Text(
                                                    "탈퇴",
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: 114.w,
                                                  height: 40.h,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: HexColor(
                                                          "#425c5a"),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  child: Text(
                                                    "취소",
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    );
                                  });
                            }
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    )
                  : Column(
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
                        SettingSemiTitleLoginFalse(
                          title: "로그아웃",
                        ),
                        SettingSemiTitleLoginFalse(
                          title: "비밀번호 재설정",
                        ),
                        SettingSemiTitleLoginFalse(
                          title: "회원탈퇴",
                        ),
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
                      GestureDetector(
                        onTap: () async {
                          _launchInstagram();
                        },
                        child: SvgPicture.asset(
                          "assets/icon_insta.svg",
                          width: 30.w,
                        ),
                      ),
                      GestureDetector(
                          onTap: () async {
                            _launchUrl(
                                "https://www.youtube.com/channel/UCLYljVZiYHeJxaHTbRpVauQ");
                          },
                          child: SvgPicture.asset("assets/icon_youtube.svg",
                              width: 35.w)),
                      GestureDetector(
                          onTap: () {
                            _launchUrl("https://pf.kakao.com/_yxatCV");
                          },
                          child: SvgPicture.asset("assets/icon_kakao.svg",
                              width: 32.w)),
                      GestureDetector(
                        onTap: () async {
                          _launchUrl("https://gwack2.seoultech.ac.kr/");
                        },
                        child: SvgPicture.asset("assets/icon_web.svg",
                            width: 30.w),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
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
                  SettingSemiTitle(
                    title: "업데이트 내역",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdateInfoScreen()));
                    },
                  ),
                  SettingSemiTitle(
                    title: "개발 관련 정보 및 문의",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DevInfoScreen()));
                    },
                  ),
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
                        "제안사항",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#425c5a")),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  SettingSemiTitle(
                    title: "기능개선 제안",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SuggestFeatureScreen()));
                    },
                  ),
                  SettingSemiTitle(
                    title: "오류 신고",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SuggestErrorScreen()));
                    },
                  ),
                  SettingSemiTitle(
                    title: "기타 제안",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SuggestEtcScreen()));
                    },
                  ),
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
                        "약관 및 정책",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#425c5a")),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  SettingSemiTitle(
                    title: "서비스 이용약관",
                    onPressed: () {
                      const url =
                          'https://suee97.notion.site/2022-09-04-f4d6b4b0db614adba75d4c619371aea9';
                      launchUrlString(url);
                    },
                  ),
                  SettingSemiTitle(
                    title: "개인정보 처리방침",
                    onPressed: () {
                      const url =
                          'https://suee97.notion.site/2022-09-04-a48b73c5ed6a43068286d8f2d6adab05';
                      launchUrlString(url);
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
            FooterWidgets()
          ],
        ),
      ),
      backgroundColor: HexColor("#425c5a"),
    );
  }

  Future<void> _launchUrl(String _uri) async {
    if (!await launchUrl(Uri.parse(_uri))) {
      throw 'Could not launch $_uri';
    }
  }

  /// ################################################
  /// #################### 로그아웃 ####################
  /// ################################################
  Future<void> _logout(NavigatorState navigator) async {
    var ACCESS_TOKEN = await secureStorage.read(key: "ACCESS_TOKEN");
    var REFRESH_TOKEN = await secureStorage.read(key: "REFRESH_TOKEN");

    Map<String, dynamic> resData = {};
    resData["status"] = 400;

    try {
      var resString = await http.get(
          Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth/logout"),
          headers: {
            "Authorization": "Bearer $ACCESS_TOKEN",
            "Refresh": "Bearer $REFRESH_TOKEN"
          }).timeout(const Duration(seconds: 5));
      resData = jsonDecode(utf8.decode(resString.bodyBytes));
    } catch (e) {
      print("_logout() call : Error");
      print(e);
    }

    await secureStorage.write(key: "ACCESS_TOKEN", value: "");
    await secureStorage.write(key: "REFRESH_TOKEN", value: "");
    ACCESS_TOKEN = await secureStorage.read(key: "ACCESS_TOKEN");
    REFRESH_TOKEN = await secureStorage.read(key: "REFRESH_TOKEN");

    await Common.setNonLogin(false);
    await Common.setAutoLogin(false);
    Common.setIsLogin(false);
    await Common.clearStudentInfoPref();

    print("#################### 로그아웃 ####################");
    print("ACCESS_TOKEN & RESFRESH_TOKEN 을 모두 지웠습니다.");
    print("ACCESS_TOKEN : $ACCESS_TOKEN");
    print("REFRESH_TOKEN : $REFRESH_TOKEN");

    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SplashScreen()),
        (route) => false);
  }

  Future<StatusCode> deleteUser() async {
    final authTokenAndReIssueResult = await Auth.authTokenAndReIssue();
    if (authTokenAndReIssueResult == StatusCode.REFRESH_EXPIRED) {
      return StatusCode.REFRESH_EXPIRED;
    }

    if (authTokenAndReIssueResult != StatusCode.SUCCESS) {
      return StatusCode.UNCATCHED_ERROR;
    }
    final AT = await Common.secureStorage.read(key: "ACCESS_TOKEN");

    try {
      final resString = await http.delete(
          Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/member"),
          headers: {
            "Authorization": "Bearer $AT",
            "Content-Type": "application/json"
          }).timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));
      debugPrint(resData.toString());
      if (resData["status"] == 200) {
        return StatusCode.SUCCESS;
      }

      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      debugPrint(e.toString());
      return StatusCode.UNCATCHED_ERROR;
    }
  }

  void _loadStudentInfo() async {
    if (!Common.getIsLogin()) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = (prefs.getString('appName') ?? '로그인이 필요합니다.');
      _studentNo = (prefs.getString('appStudentNo') ?? '');
      _department = (prefs.getString('department') ?? '');
      _studentGroup = DepartmentMatch.getGroup(_department);
      _phoneNo = (prefs.getString('appPhoneNo') ?? '');
    });
  }

  void _launchInstagram() async {
    const nativeUrl = "instagram://user?username=seoultech_38";
    const webUrl = "https://www.instagram.com/seoultech_38/";

    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(nativeUrl))) {
        await launchUrl(Uri.parse(nativeUrl));
      } else if (await canLaunchUrlString(webUrl)) {
        await launchUrlString(webUrl);
      } else {
        debugPrint("can't open Instagram (ios)");
      }
      return;
    }

    const _uri = 'https://www.instagram.com/seoultech_38';
    if (!await launchUrl(Uri.parse(_uri))) {
      throw 'Could not launch $_uri';
    }
  }

  Widget FooterWidgets() {
    return Column(
      children: [
        SizedBox(
          height: 16.h,
        ),
        Text(
          "Tel : 02-970-7012",
          style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w300,
              color: HexColor("#f3f3f3")),
        ),
        Text(
          "서울시 노원구 공릉로 232 제 1학생회관(37호관) 226호",
          style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w300,
              color: HexColor("#f3f3f3")),
        ),
        SizedBox(
          height: 4.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text("COPYRIGHT © SEOUL NATIONAL UNIVERSITY OF SCIENCE",
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w300,
                  color: HexColor("#f3f3f3"))),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text("AND TECHNOLOGY. All Rights Reserved.",
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w300,
                  color: HexColor("#f3f3f3"))),
        ),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }
}
