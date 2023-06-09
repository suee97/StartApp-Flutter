import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/plan_notifier.dart';
import 'package:start_app/notifiers/sign_up_notifier.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'screens/splash/splash_screen.dart.dart';

void main() async {
  /// for async logic
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// 일단 모든 provider 이쪽에 넣고 나중에 리팩토링
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); // 세로 고정

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PlanNotifier()),
            ChangeNotifierProvider(create: (_) => SignUpNotifier()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '서울과학기술대학교 총학생회',
            theme: ThemeData(
              fontFamily: "SCDream",
              primaryColor: Colors.transparent,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              SfGlobalLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('ko'),
              Locale('en'),
            ],
            locale: const Locale('ko'),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
