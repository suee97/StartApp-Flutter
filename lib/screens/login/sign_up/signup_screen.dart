import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/test_button.dart';
import '../sign_in/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('회원가입이 완료되었습니다.\n로그인해주세요!', style: TextStyle(color: Colors.black)),
                        backgroundColor: Colors.lightGreen,
                        duration: Duration(milliseconds: 2000),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()))
                  })]
            )));
  }
}
