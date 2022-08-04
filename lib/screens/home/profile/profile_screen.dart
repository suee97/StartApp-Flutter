import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/widgets/test_button.dart';

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
          TestButton(title: "logout", onPressed: () async {
            /// 로그아웃
            final secureStorage = FlutterSecureStorage();
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
