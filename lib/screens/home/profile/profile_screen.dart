import 'package:flutter/material.dart';
import 'package:start_app/widgets/test_button.dart';

import '../../../utils/common.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("profile Screen", style: Common.startAppBarTextStyle,),),
      body: Center(
        child: TestButton(onPressed: () => {
          Common.setNonLogin(false)
        }, title: "set nonlogin false",)
      ),
    );
  }
}
