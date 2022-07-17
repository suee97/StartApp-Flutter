import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'screens/splash/splash_screen.dart.dart';

void main() async {
  /// for async logic
  WidgetsFlutterBinding.ensureInitialized();

  /// load .env data
  await dotenv.load(fileName: ".env");

  /// load access token & refresh token
  ///
  ///
  ///

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// 일단 모든 provider 이쪽에 넣고 나중에 리팩토링
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //세로 고정
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MaterialApp(
          title: '서울과학기술대학교 총학생회',
          theme: ThemeData(
            primaryColor: Colors.transparent,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
