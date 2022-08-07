import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_app/screens/login/pw_setting_screen.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/test_button.dart';

class STAuthCheckScreen extends StatelessWidget {
  const STAuthCheckScreen({Key? key}) : super(key: key);

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
                  Text("비밀번호 재설정", style: TextStyle(fontSize: 25.5.sp, fontWeight: FontWeight.w600),),
                  Text("비밀번호 찾기를 위해 서울과학기술대학교 통합정보시스템에서 사용하는 ID/PW를 입력해주세요.", style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600),),
                  CustomTextField(
                    label: "학번",
                    controller: studentIdController,
                    isObscure: false,
                  ),
                  CustomTextField(
                    label: "비밀번호",
                    controller: pwController,
                    isObscure: true,
                  ),
                  TestButton(title: "확인", onPressed: () => {
                    // Common.setNonLogin(true),
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PWSettingScreen()))
                  })]
            )));
  }
}