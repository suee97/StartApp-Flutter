import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/screens/login/login_option_screen.dart';
import 'package:start_app/utils/common.dart';
import 'dart:io' show Platform;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../models/status_code.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final secureStorage = const FlutterSecureStorage();
  var notifyText = "";

  @override
  void initState() {
    super.initState();
    final navigator = Navigator.of(context); // Future 안에서 생성 불가
    _initializing(navigator);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.h,
            ),
            SizedBox(
              width: 250.w,
              height: 250.h,
              child: Lottie.asset(
                "assets/lottie_splash.json",
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            if (Platform.isIOS)
              const CupertinoActivityIndicator(radius: 12, color: Colors.white)
            else
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            SizedBox(
              height: 50.h,
            ),
            Text(
              notifyText,
              style: const TextStyle(fontSize: 28, color: Colors.white),
            ),
            SizedBox(
              height: 70.h,
            ),
            SizedBox(
                width: 100.w,
                height: 40.h,
                child: SvgPicture.asset(
                  "assets/logo_start.svg",
                  color: Colors.white,
                )),
          ],
        ),
      ),
      backgroundColor: HexColor("#035338"),
    );
  }

  Future<void> _initializing(NavigatorState navigator) async {
    /// start
    setState(() {
      notifyText = "0.5초 후 로직이 시작됩니다.";
    });
    await Future.delayed(const Duration(milliseconds: 500));

    /// load env
    setState(() {
      notifyText = "env 파일을 로드중입니다.";
    });
    try {
      await dotenv.load(fileName: ".env"); // load .env data
    } catch (e) {
      notifyText = "환경변수 파일을 찾지 못했습니다.";
    }

    /// 비로그인 pref 체크
    setState(() {
      notifyText = "비로그인 정보 확인중입니다.";
    });
    await Future.delayed(const Duration(seconds: 1));
    if (await Common.isNonLogin() && !await Common.isAutoLogin()) {
      await Common.clearStudentInfoPref();
      Common.setIsLogin(false);
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
      return;
    }

    /// 일반 로그인
    setState(() {
      notifyText = "일반 로그인 정보 확인중입니다.";
    });
    await Future.delayed(const Duration(seconds: 1));
    if (!await Common.isNonLogin() && !await Common.isAutoLogin()) {
      await Common.clearStudentInfoPref();
      Common.setIsLogin(false);
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginOptionScreen()),
          (route) => false);
      return;
    }

    /// T-T 일때 옵션 스크린으로 이동
    setState(() {
      notifyText = "TT case check.";
    });
    if (await Common.isNonLogin() && await Common.isAutoLogin()) {
      await Common.setNonLogin(false);
      await Common.setAutoLogin(false);
      Common.setIsLogin(false);
      await Common.clearStudentInfoPref();
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginOptionScreen()),
          (route) => false);
      return;
    }

    /// 다른 케이스는 자동로그인(F-T case)
    /// 자동로그인

    /// access 토큰 로드
    setState(() {
      notifyText = "access token 로드 중";
    });
    await Future.delayed(const Duration(seconds: 1));
    final ACCESS_TOKEN =
        await secureStorage.read(key: "ACCESS_TOKEN"); // 엑세스 토큰 로드

    /// access 토큰 없을 때
    if (ACCESS_TOKEN == null || ACCESS_TOKEN.isEmpty) {
      setState(() {
        notifyText = "access token이 존재하지 않습니다. \n1초 후 로그인 선택 화면으로 이동합니다.";
      });
      await Future.delayed(const Duration(seconds: 1));
      await Common.setNonLogin(false);
      await Common.setAutoLogin(false);
      Common.setIsLogin(false);
      await Common.clearStudentInfoPref();
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginOptionScreen()),
          (route) => false);
      return;
    }

    /// access 토큰 있을 때 -> 유효한지 확인 -> 인증되면 유저정보 저장 -> 저장되면 홈화면 이동
    final authAccessTokenFromAutoLoginResult =
        await authAccessTokenFromAutoLogin();
    if (authAccessTokenFromAutoLoginResult == StatusCode.SUCCESS) {
      StatusCode getStudentInfoAndSaveFromAutoLoginResult =
          await getStudentInfoAndSaveFromAutoLogin();
      if (getStudentInfoAndSaveFromAutoLoginResult == StatusCode.SUCCESS) {
        Common.setIsLogin(true);
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
        return;
      }
    }

    /// 만료
    if (authAccessTokenFromAutoLoginResult == StatusCode.REQUEST_ERROR) {
      final REFRESH_TOKEN = await secureStorage.read(key: "REFRESH_TOKEN");
      if (REFRESH_TOKEN == null || REFRESH_TOKEN.isEmpty) {
        Common.setNonLogin(false);
        Common.setAutoLogin(false);
        Common.setIsLogin(false);
        await Common.clearStudentInfoPref();
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginOptionScreen()),
            (route) => false);
        return;
      }

      final getAccessTokenFromRefreshTokenResult =
          await getAccessTokenFromRefreshToken();
      if (getAccessTokenFromRefreshTokenResult == StatusCode.SUCCESS) {
        final authAccessTokenFromAutoLoginResult =
            await authAccessTokenFromAutoLogin();
        if (authAccessTokenFromAutoLoginResult == StatusCode.SUCCESS) {
          final getStudentInfoAndSaveFromAutoLoginResult =
              await getStudentInfoAndSaveFromAutoLogin();
          if (getStudentInfoAndSaveFromAutoLoginResult == StatusCode.SUCCESS) {
            Common.setIsLogin(true);
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
            return;
          }
        }
      }
    }

    Common.setNonLogin(false);
    Common.setAutoLogin(false);
    Common.setIsLogin(false);
    await Common.clearStudentInfoPref();
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginOptionScreen()),
        (route) => false);
    return;
  }

  /// ######################################################
  /// ##################### 토큰으로 인증 #####################
  /// ######################################################
  Future<StatusCode> authAccessTokenFromAutoLogin() async {
    final AT = await secureStorage.read(key: "ACCESS_TOKEN");

    try {
      final resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth"), headers: {
        "Authorization": "Bearer $AT"
      }).timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));
      print("authAccessTokenFromAutoLogin() call : ${resData["data"]}");

      if (resData["status"] == 200) {
        print("authAccessTokenFromAutoLogin() call success");
        return StatusCode.SUCCESS;
      }

      if (resData["status"] == 401) {
        print("authAccessTokenFromAutoLogin() call error / access token 만료");
        return StatusCode.REQUEST_ERROR;
      }

      print("authAccessTokenFromAutoLogin() call error");
      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      print("authAccessTokenFromAutoLogin() call error");
      print(e);
      return StatusCode.UNCATCHED_ERROR;
    }
  }

  /// #############################################################
  /// ##################### 유저 정보 가져와서 저장 #####################
  /// #############################################################
  Future<StatusCode> getStudentInfoAndSaveFromAutoLogin() async {
    try {
      final resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/member"), headers: {
        "Authorization":
            "Bearer ${await secureStorage.read(key: "ACCESS_TOKEN")}"
      }).timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 200) {
        print("getStudentInfoAndSaveFromAutoLogin() call success");
        final pref = await SharedPreferences.getInstance();

        print(resData["data"]);
        List<dynamic> data = resData["data"];

        await pref.setInt("appMemberId", data[0]["memberId"]);
        await pref.setString("appStudentNo", data[0]["studentNo"]);
        await pref.setString("appName", data[0]["name"]);
        await pref.setString("department", data[0]["department"]);
        await pref.setBool("appMemberShip", data[0]["memberShip"]);
        await pref.setString("appCreatedAt", data[0]["createdAt"]);
        await pref.setString("appUpdatedAt", data[0]["updatedAt"]);
        await pref.setString("appMemberStatus", data[0]["memberStatus"]);
        await pref.setString("appPhoneNo", data[0]["phoneNo"]);

        return StatusCode.SUCCESS;
      }

      print("getStudentInfoAndSaveFromAutoLogin() call error");
      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      print("getStudentInfoAndSaveFromAutoLogin() call error");
      print(e);
      return StatusCode.UNCATCHED_ERROR;
    }
  }

  /// #############################################################
  /// ##################### access token 재발급 #####################
  /// #############################################################
  Future<StatusCode> getAccessTokenFromRefreshToken() async {
    try {
      final resString = await http.get(
          Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth/refresh"),
          headers: {
            "Authorization":
                "Bearer ${await secureStorage.read(key: "ACCESS_TOKEN")}",
            "Refresh":
                "Bearer ${await secureStorage.read(key: "REFRESH_TOKEN")}"
          }).timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 200) {
        print("getAccessTokenFromRefreshToken() call 토큰 재발급 성공");
        List<dynamic> data = resData["data"];
        await secureStorage.write(
            key: "ACCESS_TOKEN", value: data[0]["accessToken"]);
        return StatusCode.SUCCESS;
      }

      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      print("getAccessTokenFromRefreshToken() call error 토큰 재발급 실패");
      print(e);
      return StatusCode.UNCATCHED_ERROR;
    }
  }
}
