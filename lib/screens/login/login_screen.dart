import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_app/screens/home/home_screen.dart';
import 'package:start_app/screens/login/sign_up/policy_agree_screen.dart';
import 'package:start_app/screens/login/reset_password/pw_reset_auth_screen.dart';
import 'package:start_app/utils/common.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../models/status_code.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool autoLoginCheckBoxState;
  late bool isLoading;
  final studentIdController = TextEditingController();
  final pwController = TextEditingController();
  final secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    autoLoginCheckBoxState = false;
    isLoading = false;
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
        appBar: Common.SignUpAppBar("학생증 인증"),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 21.h),
                width: double.infinity,
                height: 200.h,
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
                      obscureText: true,
                    ),
                  )),
              SizedBox(
                height: 12.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24.w,
                  ),
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                          shape: const CircleBorder(),
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                                width: 2.w,
                                color: autoLoginCheckBoxState == false
                                    ? HexColor("#929d9c")
                                    : HexColor("#425C5A")),
                          ),
                          value: autoLoginCheckBoxState,
                          checkColor: autoLoginCheckBoxState == false
                              ? Colors.white
                              : Colors.white,
                          activeColor: HexColor("#425C5A"),
                          onChanged: (value) {
                            setState(() {
                              autoLoginCheckBoxState = value!;
                            });
                          }),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        autoLoginCheckBoxState = !autoLoginCheckBoxState;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 8.w, right: 8.w, top: 4.h, bottom: 4.h),
                      child: Text("자동 로그인",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w300)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });

                  /// 유효성 검사
                  if (studentIdController.text.isEmpty ||
                      pwController.text.isEmpty) {
                    Common.showSnackBar(context, "비어있는 필드가 있는지 확인해주세요.");
                    setState(() {
                      isLoading = false;
                    });
                    return;
                  }

                  /// ID/PW 인증하고 토큰 받기
                  final loginAuthAndGetTokenResult = await loginAuthAndGetToken();

                  if(loginAuthAndGetTokenResult == LoginResCode.ST041) {
                    if(!mounted) return;
                    setState(() {
                      isLoading = false;
                    });
                    Common.showSnackBar(context, "일치하는 계정을 찾을 수 없습니다.");
                    return;
                  }

                  if(loginAuthAndGetTokenResult == LoginResCode.ST050) {
                    if(!mounted) return;
                    setState(() {
                      isLoading = false;
                    });
                    Common.showSnackBar(context, "비밀번호를 확인해주세요.");
                    return;
                  }

                  if(loginAuthAndGetTokenResult == LoginResCode.ST057) {
                    if(!mounted) return;
                    setState(() {
                      isLoading = false;
                    });
                    Common.showSnackBar(context, "인증 대기중인 계정입니다.");
                    return;
                  }

                  if(loginAuthAndGetTokenResult == LoginResCode.ST058) {
                    if(!mounted) return;
                    setState(() {
                      isLoading = false;
                    });
                    Common.showSnackBar(context, "탈퇴한 계정입니다. 재가입시 문의바랍니다. (02-970-7012)");
                    return;
                  }

                  if(loginAuthAndGetTokenResult == LoginResCode.UNCATCHED_ERROR) {
                    if(!mounted) return;
                    setState(() {
                      isLoading = false;
                    });
                    Common.showSnackBar(context, "오류가 발생했습니다.");
                    return;
                  }

                  /// Access Token 으로 로그인 인증
                  final authAccessTokenResult = await authAccessToken();
                  if (authAccessTokenResult != StatusCode.SUCCESS) {
                    print("authAccessToken() call error");
                    setState(() {
                      isLoading = false;
                    });
                    if (mounted) {
                      Common.showSnackBar(context, "인증에 실패했습니다.");
                    }
                    return;
                  }

                  /// 토큰으로 유저 정보 가져와서 pref에 저장
                  final getStudentInfoAndSaveResult =
                      await getStudentInfoAndSave();
                  if (getStudentInfoAndSaveResult != StatusCode.SUCCESS) {
                    if (getStudentInfoAndSaveResult == StatusCode.REQUEST_ERROR) {
                      setState(() {
                        isLoading = false;
                      });
                      if (mounted) {
                        Common.showSnackBar(context, "승인 대기중입니다.");
                      }
                      return;
                    }
                    setState(() {
                      isLoading = false;
                    });
                    if (mounted) {
                      Common.showSnackBar(context, "유저 정보를 불러오지 못했습니다.");
                    }
                    return;
                  }

                  if (autoLoginCheckBoxState) {
                    await Common.setAutoLogin(true);
                  }
                  await Common.setNonLogin(false);
                  Common.setIsLogin(true);

                  setState(() {
                    isLoading = false;
                  });

                  if (mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
                  }
                  return;
                },
                child: Container(
                  width: 320.w,
                  height: 54.h,
                  decoration: BoxDecoration(
                      color: HexColor("#425C5A"),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: isLoading == false
                      ? Text(
                          "로그인",
                          style: TextStyle(
                              fontSize: 19.5.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      : Center(
                          child: Platform.isIOS
                              ? const CupertinoActivityIndicator(
                                  color: Colors.white,
                                )
                              : CircularProgressIndicator(
                                  color: HexColor("#f3f3f3"),
                                ),
                        ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PwResetAuthScreen()));
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PwResetAuthScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20.w),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 8.h, bottom: 8.h, left: 8.w, right: 8.w),
                          child: Text(
                            "비밀번호 재설정",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#425C5A")),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PolicyAgreeScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20.w),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 8.h, bottom: 8.h, left: 8.w, right: 8.w),
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#425C5A")),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: HexColor("#f3f3f3"),
      ),
    );
  }

  /// ########################################################
  /// ##################### 인증 후 토큰발급 #####################
  /// ########################################################
  Future<LoginResCode> loginAuthAndGetToken() async {
    Map bodyData = {
      "studentNo": studentIdController.text,
      "password": pwController.text
    };

    try {
      final resString = await http
          .post(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth/login"),
              headers: {"Content-Type": "application/json"},
              body: json.encode(bodyData))
          .timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 200) {
        print("loginAuthAndGetToken() call success");

        List<dynamic> data = resData["data"];
        final AT = data[0]["accessToken"];
        final RT = data[0]["refreshToken"];
        await secureStorage.write(key: "ACCESS_TOKEN", value: AT);
        await secureStorage.write(key: "REFRESH_TOKEN", value: RT);

        print("#################### 로그인 성공 ####################");
        print("access Token : $AT");
        print("refresh Token : $RT");

        return LoginResCode.SUCCESS;
      }

      if (resData["errorCode"] == "ST041") {
        return LoginResCode.ST041;
      }
      if (resData["errorCode"] == "ST050") {
        return LoginResCode.ST050;
      }
      if (resData["errorCode"] == "ST057") {
        return LoginResCode.ST057;
      }
      if (resData["errorCode"] == "ST058") {
        return LoginResCode.ST058;
      }

      return LoginResCode.UNCATCHED_ERROR;
    } catch (e) {
      print(e);
      return LoginResCode.UNCATCHED_ERROR;
    }
  }

  /// #######################################################
  /// ##################### 토큰으로 로그인 #####################
  /// #######################################################
  Future<StatusCode> authAccessToken() async {
    final AT = await secureStorage.read(key: "ACCESS_TOKEN");

    try {
      final resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth"), headers: {
        "Authorization": "Bearer $AT"
      }).timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));
      print("authAccessToken() call : ${resData["data"]}");

      if (resData["status"] == 200) {
        print("authAccessToken() call success");
        return StatusCode.SUCCESS;
      }

      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      print(e);
      return StatusCode.UNCATCHED_ERROR;
    }
  }

  /// #############################################################
  /// ##################### 유저 정보 가져와서 저장 #####################
  /// #############################################################
  Future<StatusCode> getStudentInfoAndSave() async {
    try {
      final resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/member"), headers: {
        "Authorization":
            "Bearer ${await secureStorage.read(key: "ACCESS_TOKEN")}"
      }).timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));

      print(resData);
      if (resData["status"] == 200) {
        print("getStudentInfoAndSave() call success");
        final pref = await SharedPreferences.getInstance();

        debugPrint("유저 정보 : ${resData["data"].toString()}");
        List<dynamic> data = resData["data"];

        if (data[0]["memberStatus"] == "PRE_CARD_AUTH") {
          return StatusCode.REQUEST_ERROR;
        }

        await pref.setInt("appMemberId", data[0]["memberId"]);
        await pref.setString("appStudentNo", data[0]["studentNo"]);
        await pref.setString("appName", data[0]["name"]);
        await pref.setString("department", data[0]["department"]);
        await pref.setBool("appMemberShip", data[0]["memberShip"]);
        await pref.setString("appCreatedAt", data[0]["createdAt"]);
        await pref.setString("appUpdatedAt", data[0]["updatedAt"]);
        await pref.setString("appMemberStatus", data[0]["memberStatus"]);
        await pref.setString("appPhoneNo", data[0]["phoneNo"]);

        return StatusCode.SUCCESS;
      }

      print("getStudentInfoAndSave() call error");
      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      print(e);
      return StatusCode.UNCATCHED_ERROR;
    }
  }
}

enum LoginResCode {
  ST041,
  ST050,
  SUCCESS,
  ST057,
  ST058,
  UNCATCHED_ERROR
}