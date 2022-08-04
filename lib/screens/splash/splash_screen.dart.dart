import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/screens/login/loginoption_screen.dart';
import 'package:start_app/utils/common.dart';
import 'package:start_app/widgets/test_button.dart';
import 'dart:io' show Platform, SocketException;
import '../login/login_screen.dart';
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
      notifyText = "2초 후 로직이 시작됩니다.";
    });
    await Future.delayed(const Duration(seconds: 2));

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
      navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          HomeScreen()), (route) => false);
      return;
    }

    /// 일반 로그인
    setState(() {
      notifyText = "일반 로그인";
    });
    await Future.delayed(const Duration(seconds: 1));
    if (!await Common.isAutoLogin() && !await Common.isAutoLogin()) {
      navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          LoginOptionScreen()), (route) => false);
      return;
    }


    // /// 자동로그인
    // if (!await Common.isNonLogin() && await Common.isAutoLogin()) {
    //   setState(() {
    //     notifyText = "자동로그인 정보 확인중입니다.";
    //   });
    //
    //
    //   /// access 토큰 로드
    //   await Future.delayed(const Duration(seconds: 1));
    //   final secureStorage = FlutterSecureStorage();
    //   var ACCESS_TOKEN = await secureStorage.read(key: "ACCESS_TOKEN");
    //   if (ACCESS_TOKEN == null) {
    //     setState(() {
    //       notifyText = "access token이 존재하지 않습니다. \n1초 후 로그인화면으로 이동합니다.";
    //     });
    //     await Future.delayed(const Duration(seconds: 1));
    //     Common.setNonLogin(false);
    //     Common.setAutoLogin(false);
    //     navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    //         LoginOptionScreen()), (route) => false);
    //     return;
    //   } else {
    //     try {
    //       var resString = await http
    //           .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth"))
    //           .timeout(const Duration(seconds: 10));
    //       Map<String, dynamic> resData = jsonDecode(utf8.decode(resString.bodyBytes));
    //
    //     } on TimeoutException catch(e) {
    //       print(e);
    //     } on SocketException catch(e) {
    //       print(e);
    //     } catch(e) {
    //       print(e);
    //     }
    //   }
    // }
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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/STart_logo_light.png',
              height: 280,
            ),
            if (Platform.isIOS)
              const CupertinoActivityIndicator(
                radius: 12,
              )
            else
              const CircularProgressIndicator(
                color: Colors.black,
              ),
            TestButton(
                title: "next",
                onPressed: () =>
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(
                            builder: (context) => LoginOptionScreen()))),
            Text(
              notifyText,
              style: const TextStyle(fontSize: 28),
            )
          ],
        ),
      ),
    );
  }
}
