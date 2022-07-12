import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/event_notifier.dart';
import 'package:start_app/utils/common.dart';
import 'screens/home/home_screen.dart';
import 'dart:io' show Platform;

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
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EventNotifier())],
      child: MaterialApp(
        title: '서울과학기술대학교 총학생회',
        theme: ThemeData(
          primaryColor: Colors.transparent,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}




/// Splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: Common.SPLASH_DURATION), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
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
            const SizedBox(
              height: 12,
            ),
            if (Platform.isIOS)
              const CupertinoActivityIndicator(
                radius: 28,
              )
            else
              const CircularProgressIndicator(
                color: Colors.white,
              )
          ],
        ),
      ),
    );
  }
}
