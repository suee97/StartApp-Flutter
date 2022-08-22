import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/utils/common.dart';

class SuggestFeatureScreen extends StatelessWidget {
  const SuggestFeatureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "기능 개선 제안",
          style: Common.startAppBarTextStyle,
        ),
        foregroundColor: HexColor("#425C5A"),
        backgroundColor: HexColor("#f3f3f3"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

        ],
      ),
      backgroundColor: HexColor("f3f3f3"),
    );
  }
}
