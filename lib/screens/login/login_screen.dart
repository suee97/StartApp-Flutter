import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/screens/login/login_widgets.dart';
import 'package:start_app/screens/login/sign_up/get_info_screen.dart';
import 'package:start_app/utils/common.dart';
import 'package:start_app/widgets/test_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool autoLoginCheckBoxState = false;
  final studentIdController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    studentIdController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 21.h),
              width: double.infinity,
              height: 260.h,
              child: const Center(
                child: Image(
                  image: AssetImage("images/logo_app.png"),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 28.w,
                ),
                Text(
                  "학번",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300,
                      color: HexColor("#425c5a")),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 28.w, right: 28.w),
                child: SizedBox(
                  height: 30.h,
                  child: TextField(
                    controller: studentIdController,
                    keyboardType: TextInputType.number,
                    cursorColor: HexColor("#425C5A"),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLines: 1,
                    enableSuggestions: false,
                    style: TextStyle(
                        fontSize: 17.5.sp, fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#425c5a")),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#425c5a")),
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 24.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 28.w,
                ),
                Text(
                  "비밀번호",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300,
                      color: HexColor("#425c5a")),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 28.w, right: 28.w),
                child: SizedBox(
                  height: 30.h,
                  child: TextField(
                    controller: pwController,
                    cursorColor: HexColor("#425C5A"),
                    maxLines: 1,
                    enableSuggestions: false,
                    style: TextStyle(
                        fontSize: 17.5.sp, fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#425c5a")),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#425c5a")),
                      ),
                    ),
                  ),
                )),
            Row(
              children: [
                Checkbox(
                    value: autoLoginCheckBoxState,
                    onChanged: (value) {
                      setState(() {
                        autoLoginCheckBoxState = value!;
                      });
                    }),
                Text("자동 로그인", style: TextStyle(fontSize: 10.sp)),
                TextButton(
                    onPressed: () {
                      studentIdController.text = "17101246";
                      pwController.text = "qwer1234";
                    },
                    child: Text("ID/PW입력"))
              ],
            ),
            LoginNavButton(
              onPressed: () async {
                Map bodyData = {
                  "studentNo": studentIdController.text,
                  "password": pwController.text
                };

                Map<String, dynamic> resData1 = {};
                resData1["status"] = 400;

                Map<String, dynamic> resData2 = {};
                resData2["status"] = 400;

                try {
                  var resString = await http
                      .post(
                      Uri.parse(
                          "${dotenv.get("DEV_API_BASE_URL")}/auth/login"),
                      headers: {"Content-Type": "application/json"},
                      body: json.encode(bodyData))
                      .timeout(const Duration(seconds: 10));
                  resData1 = jsonDecode(utf8.decode(resString.bodyBytes));
                } on TimeoutException catch (e) {
                  print(e);
                } on SocketException catch (e) {
                  print(e);
                } catch (e) {
                  print(e);
                }

                if (resData1["status"] == 200) {
                  List<dynamic> data = resData1["data"];

                  var AT = data[0]["accessToken"];
                  var RT = data[0]["refreshToken"];

                  print("access Token : $AT");
                  print("refresh Token : $RT");

                  final secureStorage = FlutterSecureStorage();
                  await secureStorage.write(key: "ACCESS_TOKEN", value: AT);
                  await secureStorage.write(key: "REFRESH_TOKEN", value: RT);

                  var ACCESS_TOKEN =
                  await secureStorage.read(key: "ACCESS_TOKEN");

                  try {
                    var resString = await http.get(
                        Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth"),
                        headers: {
                          "Authorization": "Bearer $ACCESS_TOKEN"
                        }).timeout(const Duration(seconds: 10));
                    resData2 = jsonDecode(utf8.decode(resString.bodyBytes));
                  } on TimeoutException catch (e) {
                    print(e);
                  } on SocketException catch (e) {
                    print(e);
                  } catch (e) {
                    print(e);
                  }

                  if (resData2["status"] == 200) {
                    if (!mounted) return;
                    if (autoLoginCheckBoxState) {
                      Common.setAutoLogin(true);
                    }

                    Map<String, dynamic> resData = {};
                    resData["status"] = 400;
                    try {
                      var resString = await http.get(
                          Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/member"),
                          headers: {
                            "Authorization": "Bearer $ACCESS_TOKEN"
                          }).timeout(const Duration(seconds: 10));
                      resData = jsonDecode(utf8.decode(resString.bodyBytes));

                      print(resData);
                    } on TimeoutException catch (e) {
                      print(e);
                    } on SocketException catch (e) {
                      print(e);
                    } catch (e) {
                      print(e);
                    }

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (route) => false);
                    return;
                  }
                }
                return;
              },
              title: "로그인",
              colorHex: "#425c5a",
              width: 330.w,
            ),
            SizedBox(
              height: 12.h,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Text("비밀번호 재설정"),
                Container(
                  width: 2.w,
                  height: 22.h,
                  color: HexColor("#425c5a"),
                ),
                Text("회원가입"),
              ],
            ),
            TestButton(
                title: "회원가입",
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GetInfoScreen()))
                }),
          ],
        ),
        backgroundColor: HexColor("#f3f3f3"),
      ),
    );
  }
}