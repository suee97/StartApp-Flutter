import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/widgets/test_button.dart';
import 'package:http/http.dart' as http;
import '../../../utils/common.dart';
import '../../splash/splash_screen.dart.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "profile Screen",
          style: Common.startAppBarTextStyle,
        ),
      ),
      body: Column(
        children: [
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
                /// 로그아웃

                var secureStorage = FlutterSecureStorage();
                var ACCESS_TOKEN =
                    await secureStorage.read(key: "ACCESS_TOKEN");
                var REFRESH_TOKEN =
                    await secureStorage.read(key: "REFRESH_TOKEN");

                Map<String, dynamic> resData91 = {};
                resData91["status"] = 400;
                try {
                  var resString = await http.get(
                      Uri.parse(
                          "${dotenv.get("DEV_API_BASE_URL")}/auth/logout"),
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
                secureStorage.write(key: "ACCESS_TOKEN", value: "");
                secureStorage.write(key: "REFRESH_TOKEN", value: "");
                Common.setAutoLogin(false);
                Common.setNonLogin(false);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                    (route) => false);
              })
        ],
      ),
    );
  }
}
