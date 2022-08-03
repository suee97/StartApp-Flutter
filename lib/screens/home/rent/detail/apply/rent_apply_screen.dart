import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../utils/common.dart';

class RentApplyScreen extends StatelessWidget {
  const RentApplyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "상시사업 예약",
          style: Common.startAppBarTextStyle,
        ),
        foregroundColor: Colors.white,
        backgroundColor: HexColor("#425C5A"),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
