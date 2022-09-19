import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/sign_up_notifier.dart';
import 'package:start_app/screens/login/login_widgets.dart';
import 'package:start_app/screens/login/sign_up/post_certificate_screen.dart';
import 'package:start_app/utils/common.dart';

class PhoneCertificateScreen extends StatefulWidget {
  const PhoneCertificateScreen({Key? key}) : super(key: key);

  @override
  State<PhoneCertificateScreen> createState() => _PhoneCertificateScreenState();
}

class _PhoneCertificateScreenState extends State<PhoneCertificateScreen> {
  final phoneNoController = TextEditingController();
  final codeNoController = TextEditingController();
  bool authRequestActive = true;
  bool codeRequestActive = false;
  bool authRequestLoading = false;
  bool codeRequestLoading = false;
  bool nextButtonActive = false;

  late int _counter;
  late Timer _timer;

  @override
  void dispose() {
    phoneNoController.dispose();
    codeNoController.dispose();
    super.dispose();
    _cancelTimer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (builder, signUpNotifier, child) {
      return Scaffold(
        appBar: Common.SignUpAppBar("휴대폰 인증"),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: Stack(children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 102.h),
              reverse: true,
              child: Column(
                children: [
                  SizedBox(
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
                        "회원가입",
                        style: TextStyle(
                            fontSize: 21.5.sp,
                            fontWeight: FontWeight.w600,
                            color: HexColor("#425c5a")),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                      height: 100.h,
                      margin: EdgeInsets.only(left: 28.w, right: 28.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "휴대폰 인증을 진행해주세요.",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "휴대폰 번호는 가입 승인 알림, 비밀번호 재설정, 이벤트 상품수령 및 상시사업 신청 알림에 사용됩니다.\n인증번호는 3분간 유효합니다.",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                height: 1.25),
                          ),
                        ],
                      )),
                  textFiledTitleRowWidget("휴대폰 번호"),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 28.w, right: 28.w),
                      child: SizedBox(
                        height: 30.h,
                        child: TextField(
                          controller: phoneNoController,
                          keyboardType: TextInputType.number,
                          cursorColor: HexColor("#425C5A"),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLines: 1,
                          enabled: authRequestActive,
                          enableSuggestions: false,
                          style: TextStyle(
                              fontSize: 17.5.sp,
                              fontWeight: FontWeight.w300,
                              color: authRequestActive == true
                                  ? Colors.black
                                  : HexColor("#929D9C")),
                          decoration: InputDecoration(
                            hintText: "\"-\" 없이 입력해주세요",
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: authRequestActive == true
                                  ? phoneAuthButton("인증요청", () async {
                                      setState(() {
                                        authRequestLoading = true;
                                      });
                                      if (phoneNoController.text.isEmpty) {
                                        setState(() {
                                          authRequestLoading = false;
                                        });
                                        Common.showSnackBar(
                                            context, "휴대폰 번호를 입력해주세요.");
                                        return;
                                      }
                                      final checkPhoneNoValidationResult =
                                          checkPhoneNoValidation();
                                      if (!checkPhoneNoValidationResult) {
                                        setState(() {
                                          authRequestLoading = false;
                                        });
                                        Common.showSnackBar(
                                            context, "잘못된 휴대폰 번호 형식입니다.");
                                        return;
                                      }

                                      final postSmsResult = await postSms(
                                          withoutHyphenToWithHyphen(
                                              phoneNoController.text));
                                      if (postSmsResult ==
                                          SmsAuthStatusCode.ST064) {
                                        setState(() {
                                          authRequestLoading = false;
                                        });
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "이미 인증을 완료한 휴대폰 번호입니다.");
                                        return;
                                      }
                                      if (postSmsResult ==
                                          SmsAuthStatusCode.ST065) {
                                        setState(() {
                                          authRequestLoading = false;
                                        });
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "너무 많은 인증요청을 보낸 휴대폰 번호입니다.\n잠시 후 다시 시도해주세요.");
                                        return;
                                      }
                                      if (postSmsResult ==
                                          SmsAuthStatusCode.UNCATCHED_ERROR) {
                                        setState(() {
                                          authRequestLoading = false;
                                        });
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "오류가 발생했습니다.");
                                        return;
                                      }
                                      if (postSmsResult ==
                                          SmsAuthStatusCode.SUCCESS) {
                                        setState(() {
                                          authRequestActive = false;
                                          codeRequestActive = true;
                                          authRequestLoading = false;
                                        });
                                        var now = DateTime.now();
                                        var threeHours = now.add(Duration(minutes: 3)).difference(now);
                                        _counter = threeHours.inSeconds;
                                        _startTimer();
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "인증번호가 발송되었습니다. 3분 안에 입력해주세요.");
                                        return;
                                      }
                                      setState(() {
                                        authRequestLoading = false;
                                      });
                                      if (!mounted) return;
                                      Common.showSnackBar(
                                          context, "오류가 발생했습니다.");
                                      return;
                                    }, HexColor("#EE795F"), authRequestLoading)
                                  : phoneAuthButton(setTime(_counter), () {},
                                      HexColor("#F9B7A9"), false),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#425c5a")),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#425c5a")),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 16.h,
                  ),
                  textFiledTitleRowWidget("인증번호"),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 28.w, right: 28.w),
                      child: SizedBox(
                        height: 30.h,
                        child: TextField(
                          controller: codeNoController,
                          keyboardType: TextInputType.number,
                          cursorColor: HexColor("#425C5A"),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLines: 1,
                          enabled: codeRequestActive,
                          enableSuggestions: false,
                          style: TextStyle(
                              fontSize: 17.5.sp,
                              fontWeight: FontWeight.w300,
                              color: codeRequestActive == true
                                  ? Colors.black
                                  : HexColor("#929d9c")),
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: codeRequestActive == false
                                  ? phoneAuthButton(
                                      "확인", () {}, HexColor("#F9B7A9"), false)
                                  : phoneAuthButton("확인", () async {
                                      setState(() {
                                        codeRequestLoading = true;
                                      });
                                      if (codeNoController.text.length != 6) {
                                        setState(() {
                                          codeRequestLoading = false;
                                        });
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "올바른 인증번호를 입력해주세요.");
                                        return;
                                      }

                                      final checkAuthCodeResult =
                                          await checkAuthCode();
                                      if (checkAuthCodeResult ==
                                          SmsAuthStatusCode.ST066) {
                                        setState(() {
                                          codeRequestLoading = false;
                                        });
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "유효한 인증번호가 아닙니다.");
                                        return;
                                      }
                                      if (checkAuthCodeResult ==
                                          SmsAuthStatusCode.ST067) {
                                        setState(() {
                                          codeRequestLoading = false;
                                          codeRequestActive = false;
                                          authRequestActive = true;
                                        });
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "인증번호 기간이 만료되었습니다. 다시 요청해주세요.");
                                        codeNoController.text = "";
                                        return;
                                      }
                                      if (checkAuthCodeResult ==
                                          SmsAuthStatusCode.UNCATCHED_ERROR) {
                                        setState(() {
                                          codeRequestLoading = false;
                                        });
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "오류가 발생했습니다.");
                                        return;
                                      }
                                      if (checkAuthCodeResult ==
                                          SmsAuthStatusCode.SUCCESS) {
                                        setState(() {
                                          codeRequestLoading = false;
                                          codeRequestActive = false;
                                          nextButtonActive = true;
                                        });
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "인증에 성공하였습니다!\n다음 버튼을 눌러 추가인증을 진행해주세요.");
                                        return;
                                      }
                                      setState(() {
                                        codeRequestLoading = false;
                                      });
                                      if (!mounted) return;
                                      Common.showSnackBar(
                                          context, "오류가 발생했습니다.");
                                    }, HexColor("#EE795F"), codeRequestLoading),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#425c5a")),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#425c5a")),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: nextButtonActive == true
                  ? LoginNavButton(
                      onPressed: () {
                        signUpNotifier.setPhoneNo(
                            withoutHyphenToWithHyphen(phoneNoController.text));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PostCertificateScreen()));
                      },
                      title: "다음",
                      colorHex: "#425C5A",
                      margin: EdgeInsets.only(bottom: 16.h),
                      width: 304.w)
                  : LoginNavButton(
                      onPressed: () {},
                      title: "다음",
                      colorHex: "#929D9C",
                      margin: EdgeInsets.only(bottom: 16.h),
                      width: 304.w),
            )
          ]),
        ),
        backgroundColor: HexColor("#f3f3f3"),
      );
    });
  }

  Future<SmsAuthStatusCode> checkAuthCode() async {
    Map bodyData = {
      "phoneNo": withoutHyphenToWithHyphen(phoneNoController.text),
      "code": codeNoController.text
    };

    try {
      final resString = await http
          .post(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth/sms/check"),
              headers: {"Content-Type": "application/json"},
              body: json.encode(bodyData))
          .timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));
      print(resData);
      if (resData["status"] == 200) {
        return SmsAuthStatusCode.SUCCESS;
      }
      if (resData["errorCode"] == "ST066") {
        return SmsAuthStatusCode.ST066;
      }
      if (resData["errorCode"] == "ST067") {
        return SmsAuthStatusCode.ST067;
      }
      return SmsAuthStatusCode.UNCATCHED_ERROR;
    } catch (e) {
      return SmsAuthStatusCode.UNCATCHED_ERROR;
    }
  }

  String withoutHyphenToWithHyphen(String phoneNo) {
    if (phoneNo.length == 11) {
      final tempA = phoneNo.substring(0, 3);
      final tempB = phoneNo.substring(3, 7);
      final tempC = phoneNo.substring(7, 11);
      return "$tempA-$tempB-$tempC";
    }
    final tempA = phoneNo.substring(0, 3);
    final tempB = phoneNo.substring(3, 6);
    final tempC = phoneNo.substring(6, 10);
    return "$tempA-$tempB-$tempC";
  }

  bool checkPhoneNoValidation() {
    final phoneNo = phoneNoController.text;
    final validationResult =
        RegExp(r'^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$').hasMatch(phoneNo);
    if (!validationResult) {
      return false;
    }
    return true;
  }

  Future<SmsAuthStatusCode> postSms(String phoneNo) async {
    Map bodyData = {"phoneNo": phoneNo};

    try {
      final resString = await http
          .post(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/auth/sms"),
              headers: {"Content-Type": "application/json"},
              body: json.encode(bodyData))
          .timeout(const Duration(seconds: 10));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));
      print(resData);
      if (resData["status"] == 200) {
        return SmsAuthStatusCode.SUCCESS;
      }
      if (resData["errorCode"] == "ST064") {
        return SmsAuthStatusCode.ST064;
      }
      if (resData["errorCode"] == "ST065") {
        return SmsAuthStatusCode.ST065;
      }
      return SmsAuthStatusCode.UNCATCHED_ERROR;
    } catch (e) {
      return SmsAuthStatusCode.UNCATCHED_ERROR;
    }
  }

  Widget textFiledTitleRowWidget(String title) {
    return Row(
      children: [
        SizedBox(
          width: 28.w,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w300,
              color: HexColor("#425c5a")),
        ),
      ],
    );
  }

  Widget phoneAuthButton(
      String title, VoidCallback onPressed, Color color, bool isLoading) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80.w,
        height: 30.h,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: isLoading == false
            ? Text(
                title,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )
            : Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator(
                        color: HexColor("#f3f3f3"),
                      )
                    : CircularProgressIndicator(
                        color: HexColor("#f3f3f3"),
                      ),
              ),
      ),
    );
  }

  void _startTimer() {
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        _counter--;
      });
      if (_counter == 0) {
        _cancelTimer();
      }
    });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      // _timer = null;
    }
  }
}

String setTime(int seconds) {
  int minute = seconds % 3600 ~/ 60;
  int second = seconds % 60;

  String min = "0", sec = "0";

  if(minute < 10){
    min = "0" + minute.toString();
  }else{
    min = minute.toString();
  }

  if(second < 10){
    sec = "0" + second.toString();
  }else{
    sec = second.toString();
  }
  return "$min:$sec";
}

enum SmsAuthStatusCode { SUCCESS, ST064, ST065, UNCATCHED_ERROR, ST066, ST067 }
