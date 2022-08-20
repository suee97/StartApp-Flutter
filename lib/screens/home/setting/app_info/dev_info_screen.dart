import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/utils/common.dart';

class DevInfoScreen extends StatelessWidget {
  const DevInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "개발 관련 정보 및 문의하기",
          style: Common.startAppBarTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: HexColor("#425C5A"),
        foregroundColor: HexColor("#f3f3f3"),
      ),
      body: Column(
        children: [
          Text("어플리케이션 버전"),
          Text("1.0.0"),
          Text("대표 관리자"),
          Text("dev.suee97@gmail.com"),

        ],
      ),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }
}
