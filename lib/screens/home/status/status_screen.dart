import 'package:flutter/material.dart';

import '../../../utils/common.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("status screen", style: Common.startAppBarTextStyle,),),
      body: Center(
        child: Text("status screen"),
      ),
    );
  }
}
