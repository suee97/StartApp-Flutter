import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/screens/login/login_option_screen.dart';
import 'package:start_app/utils/common.dart';
import 'dart:io' show Platform, SocketException;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var notifyText = "";

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
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
      return;
    }

    /// 일반 로그인
    setState(() {
      notifyText = "일반 로그인 정보 확인중입니다.";
    });
    await Future.delayed(const Duration(seconds: 1));
    if (!await Common.isAutoLogin() && !await Common.isAutoLogin()) {
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginOptionScreen()),
          (route) => false);
      return;
    }

    /// 자동로그인
    if (!await Common.isNonLogin() && await Common.isAutoLogin()) {
      setState(() {
        notifyText = "자동로그인 정보 확인중입니다.";
      });

      /// access 토큰 로드
      await Future.delayed(const Duration(seconds: 1));
      final secureStorage = FlutterSecureStorage();
      var ACCESS_TOKEN =
          await secureStorage.read(key: "ACCESS_TOKEN"); // 엑세스 토큰 로드

      // access 토큰 없을 때
      if (ACCESS_TOKEN == null) {
        setState(() {
          notifyText = "access token이 존재하지 않습니다. \n1초 후 로그인화면으로 이동합니다.";
        });
        await Future.delayed(const Duration(seconds: 1));
        Common.setNonLogin(false);
        Common.setAutoLogin(false);
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginOptionScreen()),
            (route) => false);
        return;
      }

      // access 토큰 있을 때 -> 유효한지 확인
      Map<String, dynamic> resData10 = {};
      resData10["status"] = 400;
      try {
        var resString = await http
            .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth"), headers: {
          "Authorization": "Bearer $ACCESS_TOKEN"
        }).timeout(const Duration(seconds: 10));
        resData10 = jsonDecode(utf8.decode(resString.bodyBytes));
      } on TimeoutException catch (e) {
        print(e);
      } on SocketException catch (e) {
        print(e);
      } catch (e) {
        print(e);
      }

      if (resData10["status"] == 200) {
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        /// TODO 정보 불러와서 pref 에 저장
        return;
      }

      /// 만료
      if (resData10["status"] == 401) {
        var REFRESH_TOKEN = await secureStorage.read(key: "REFRESH_TOKEN");
        if (REFRESH_TOKEN == null) {
          Common.setNonLogin(false);
          Common.setAutoLogin(false);
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginOptionScreen()),
              (route) => false);
          return;
        }

        Map<String, dynamic> resData11 = {};
        resData11["status"] = 400;
        try {
          var resString = await http.get(
              Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth/refresh"),
              headers: {
                "Authorization": "Bearer $ACCESS_TOKEN",
                "Refresh": "Bearer $REFRESH_TOKEN"
              }).timeout(const Duration(seconds: 10));
          resData11 = jsonDecode(utf8.decode(resString.bodyBytes));
        } on TimeoutException catch (e) {
          print(e);
        } on SocketException catch (e) {
          print(e);
        } catch (e) {
          print(e);
        }

        if (resData11["status"] == 200) {
          final secureStorage = FlutterSecureStorage();
          secureStorage.write(
              key: "ACCESS_TOKEN", value: resData11["data"][0]["accessToken"]);

          Map<String, dynamic> resData12 = {};
          resData12["status"] = 400;
          try {
            var resString = await http.get(
                Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth"),
                headers: {
                  "Authorization": "Bearer $ACCESS_TOKEN"
                }).timeout(const Duration(seconds: 10));
            resData12 = jsonDecode(utf8.decode(resString.bodyBytes));
          } on TimeoutException catch (e) {
            print(e);
          } on SocketException catch (e) {
            print(e);
          } catch (e) {
            print(e);
          }

          if (resData12["status"] == 200) {
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
            return;
          }
          if (resData12["status"] == 401) {
            Common.setNonLogin(false);
            Common.setAutoLogin(false);
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginOptionScreen()),
                (route) => false);
            return;
          }
        }
      }

      Common.setNonLogin(false);
      Common.setAutoLogin(false);
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginOptionScreen()),
          (route) => false);
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    final navigator = Navigator.of(context); // Future 안에서 생성 불가
    _initializing(navigator);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150.h,),
            Container(
              width: 250.w,
              height: 250.h,
              child: Lottie.asset(
                "assets/lottie_splash.json",
              ),
            ),
            SizedBox(height: 30.h,),
            if (Platform.isIOS)
              const CupertinoActivityIndicator(
                radius: 12,
                color: Colors.white
              )
            else
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            SizedBox(height: 50.h,),
            Text(
              notifyText,
              style: const TextStyle(fontSize: 28, color: Colors.white),
            ),
            SizedBox(height: 10.h,),
            SizedBox(
                width: 100.w,
                height: 40.h,
                child: SvgPicture.asset("assets/logo_start.svg", color: Colors.white,)),
          ],
        ),
      ),
      backgroundColor: HexColor("#035338"),
    );
  }
}
