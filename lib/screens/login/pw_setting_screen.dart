import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_app/utils/common.dart';
import '../../widgets/custom_text_field.dart';
import 'package:start_app/widgets/test_button.dart';

import 'login_screen.dart';

class PWSettingScreen extends StatelessWidget {
  const PWSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentIdController = TextEditingController();
    final pwController = TextEditingController();

    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Text(
            "비밀번호 재설정",
            style: TextStyle(fontSize: 25.5.sp, fontWeight: FontWeight.w600),
          ),
          Text(
            "ST’art 어플에서 사용할 비밀번호를 재설정해주세요.",
            style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600),
          ),
          Text(
            "최소8글자 & 영어 대소문자, 숫자, 특수문자를 각 1개 이상 사용",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w600),
          ),
          CustomTextField(
            label: "비밀번호",
            controller: studentIdController,
            isObscure: false,
          ),
          CustomTextField(
            label: "비밀번호 확인",
            controller: pwController,
            isObscure: true,
          ),
          TestButton(
              title: "확인",
              onPressed: () {
                // Common.setNonLogin(true),
                Common.showSnackBar(context, '비밀번호가 재설정되었습니다.\n다시 로그인해주세요!');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              })
        ])));
  }
}
