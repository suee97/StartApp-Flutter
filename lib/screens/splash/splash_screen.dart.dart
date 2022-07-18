import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:start_app/widgets/test_button.dart';
import 'dart:io' show Platform;
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

    /// load access token
    setState(() {
      notifyText = "access token 확인중입니다.";
    });
    final storage = FlutterSecureStorage();
    var ACCESS_TOKEN = await storage.read(key: "ACCESS_TOKEN");
    if (ACCESS_TOKEN == null) {
      setState(() {
        notifyText = "access token이 존재하지 않습니다. \n2초 후 로그인화면으로 이동합니다.";
      });
      await Future.delayed(const Duration(seconds: 2));
      navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
      return;
    }

    /// check access token
    final baseUrl = dotenv.get("DEV_API_BASE_URL");
    try {
      Map<String, String> param01 = { "ACCESS_TOKEN" : ACCESS_TOKEN };
      var res01String = http.post(Uri.parse(baseUrl), headers: param01);
    } catch(e) {
      print("error : $e");
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
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()))),
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
