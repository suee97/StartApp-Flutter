import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/event_notifier.dart';
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); /// 비동기 처리
  await dotenv.load(fileName: ".env"); /// .env 파일 로딩
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// 일단 모든 provider 이쪽에 넣고 나중에 리팩토링
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventNotifier()) /// 이벤트 notifier
      ],
      child: MaterialApp(
        title: '서울과학기술대학교 총학생회',
        theme: ThemeData(
          primaryColor: Colors.transparent,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
