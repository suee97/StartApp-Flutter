import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_app/screens/login/sign_up/post_certificate_screen.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/test_button.dart';

class PwSettingScreen extends StatelessWidget {
  const PwSettingScreen({Key? key}) : super(key: key);

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
                  Text("회원가입", style: TextStyle(fontSize: 25.5.sp, fontWeight: FontWeight.w600),),
                  Text("ST’art 어플에서 사용할 비밀번호를 설정해주세요.", style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600),),
                  Text("최소8글자 & 영어 대소문자, 숫자, 특수문자를 각 1개 이상 사용", style: TextStyle(color: Colors.grey, fontSize: 10.5.sp, fontWeight: FontWeight.w600),),
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
                  TestButton(title: "확인", onPressed: () => {
                    // Common.setNonLogin(true),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostCertificateScreen()))
                  })]
            )));
  }
}
