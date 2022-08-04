import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/screens/login/pwsetting_screen.dart';
import 'package:start_app/screens/login/signup_screen.dart';
import 'package:start_app/utils/common.dart';
import 'package:start_app/widgets/test_button.dart';
import '../../widgets/custom_text_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool autoLoginCheckBoxState = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final studentIdController = TextEditingController();
    final pwController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  CustomTextField(
                    label: "Student ID",
                    controller: studentIdController,
                    isObscure: false,
                  ),
                  CustomTextField(
                    label: "Password",
                    controller: pwController,
                    isObscure: false,
                  ),
                  TestButton(
                      title: "로그인",
                      onPressed: () async {
                        Map bodyData = {
                          "studentNo": studentIdController.text,
                          "password": pwController.text
                        };

                        print(bodyData);

                        var resString = await http.post(
                            Uri.parse(
                                "${dotenv.get("DEV_API_BASE_URL")}/auth/login"),
                            headers: {"Content-Type": "application/json"},
                            body: json.encode(bodyData)
                        );
                        Map<String, dynamic> resData =
                            jsonDecode(utf8.decode(resString.bodyBytes));
                        print(resData);

                        
                      })
                ],
              ),
            ),
            TestButton(
                title: "비밀번호 찾기",
                onPressed: () => {
                      // Common.setNonLogin(true),
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PWSettingScreen()))
                    }),
            TestButton(
                title: "회원가입",
                onPressed: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()))
                    })
          ],
        ),
      ),
    );
  }
}
