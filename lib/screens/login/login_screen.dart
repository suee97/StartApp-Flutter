import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/screens/login/pwsetting_screen.dart';
import 'package:start_app/screens/login/signup_screen.dart';
import 'package:start_app/screens/login/stauthcheck_screen.dart';
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
                  Row(
                    children: [
                      Checkbox(value: autoLoginCheckBoxState, onChanged: (value) {
                        setState((){
                          autoLoginCheckBoxState = value!;
                        });
                      }),
                      Text("자동 로그인", style: TextStyle(fontSize: 10.sp)),
                      TextButton(onPressed: (){
                        studentIdController.text = "17101246";
                        pwController.text = "qwer1234";
                      }, child: Text("ID/PW입력"))
                    ],
                  ),
                  TestButton(
                      title: "로그인",
                      onPressed: () async {
                        Map bodyData = {
                          "studentNo": studentIdController.text,
                          "password": pwController.text
                        };

                        var resString = await http.post(
                            Uri.parse(
                                "${dotenv.get("DEV_API_BASE_URL")}/auth/login"),
                            headers: {"Content-Type": "application/json"},
                            body: json.encode(bodyData));
                        Map<String, dynamic> resData =
                            jsonDecode(utf8.decode(resString.bodyBytes));
                        print(resData);

                        if (resData["status"] == 200) {
                          List<dynamic> data = resData["data"];

                          var AT = data[0]["accessToken"];
                          var RT = data[0]["refreshToken"];

                          print("access Token : $AT");
                          print("refresh Token : $RT");

                          final secureStorage = FlutterSecureStorage();
                          await secureStorage.write(
                              key: "ACCESS_TOKEN", value: AT);
                          await secureStorage.write(
                              key: "REFRESH_TOKEN", value: RT);

                          var ACCESS_TOKEN =
                              await secureStorage.read(key: "ACCESS_TOKEN");

                          try {
                            var resString = await http.get(
                                Uri.parse(
                                    "${dotenv.get("DEV_API_BASE_URL")}/auth"),
                                headers: {
                                  "Authorization": "Bearer $ACCESS_TOKEN"
                                }).timeout(const Duration(seconds: 10));
                            Map<String, dynamic> resData =
                                jsonDecode(utf8.decode(resString.bodyBytes));
                            var status = resData["status"];
                            if (status == 200) {
                              if (mounted) {
                                if (autoLoginCheckBoxState) {
                                  Common.setAutoLogin(true);
                                }
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                    HomeScreen()), (route) => false);
                                return;
                              }
                            } else {
                              // status 200 아닐 때 (auth get)
                            }
                          } on TimeoutException catch (e) {
                            print(e);
                          } on SocketException catch (e) {
                            print(e);
                          } catch (e) {
                            print(e);
                          }
                        } else {
                          // 200 아닐 때 (id/pw post)
                        }

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
                              builder: (context) => STAuthCheckScreen()))
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
