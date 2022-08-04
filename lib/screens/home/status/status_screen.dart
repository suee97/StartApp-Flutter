import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/common.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("status screen", style: Common.startAppBarTextStyle,),),
      body: Center(
        child: Lottie.asset("assets/lottie_test.json"),
      ),
    );
  }
}
