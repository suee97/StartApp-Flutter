import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/sign_up_notifier.dart';
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
  bool nextButtonActive = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (builder, signUpNotifier, child) {
      return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                children: [
                  SizedBox(
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
                    height: 120.h,
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
                          "휴대폰 번호는 가입 승인 알림, 비밀번호 재설정 및 상시사업 신청 알림에 사용됩니다.\n인증번호는 3분간 유효합니다.",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w300, height: 1.25),
                        ),
                      ],
                    )
                  ),
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
                                      if (phoneNoController.text.isEmpty) {
                                        Common.showSnackBar(
                                            context, "휴대폰 번호를 입력해주세요.");
                                        return;
                                      }
                                      final checkPhoneNoValidationResult =
                                          checkPhoneNoValidation();
                                      if (!checkPhoneNoValidationResult) {
                                        Common.showSnackBar(
                                            context, "잘못된 휴대폰 번호 형식입니다.");
                                        return;
                                      }

                                      final postSmsResult = await postSms(
                                          withoutHyphenToWithHyphen(
                                              phoneNoController.text));
                                      if (postSmsResult ==
                                          SmsAuthStatusCode.ST064) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "이미 인증을 완료한 휴대폰 번호입니다.");
                                        return;
                                      }
                                      if (postSmsResult ==
                                          SmsAuthStatusCode.ST065) {
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "너무 많은 인증요청을 보낸 휴대폰 번호입니다.\n잠시 후 다시 시도해주세요.");
                                        return;
                                      }
                                      if (postSmsResult ==
                                          SmsAuthStatusCode.UNCATCHED_ERROR) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "오류가 발생했습니다.");
                                        return;
                                      }
                                      if (postSmsResult ==
                                          SmsAuthStatusCode.SUCCESS) {
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "인증번호가 발송되었습니다. 3분 안에 입력해주세요.");
                                        setState(() {
                                          authRequestActive = false;
                                          codeRequestActive = true;
                                        });
                                        return;
                                      }
                                      if (!mounted) return;
                                      Common.showSnackBar(
                                          context, "오류가 발생했습니다.");
                                      return;
                                    }, HexColor("#EE795F"))
                                  : phoneAuthButton(
                                      "인증요청", () {}, HexColor("#F9B7A9")),
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
                                      "확인", () {}, HexColor("#F9B7A9"))
                                  : phoneAuthButton("확인", () async {
                                      if (codeNoController.text.length != 6) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "올바른 인증번호를 입력해주세요.");
                                        return;
                                      }

                                      final checkAuthCodeResult =
                                          await checkAuthCode();
                                      if (checkAuthCodeResult ==
                                          SmsAuthStatusCode.ST066) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "유효한 인증번호가 아닙니다.");
                                        return;
                                      }
                                      if (checkAuthCodeResult ==
                                          SmsAuthStatusCode.ST067) {
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "인증번호 기간이 만료되었습니다. 다시 요청해주세요.");
                                        return;
                                      }
                                      if (checkAuthCodeResult ==
                                          SmsAuthStatusCode.UNCATCHED_ERROR) {
                                        if (!mounted) return;
                                        Common.showSnackBar(
                                            context, "오류가 발생했습니다.");
                                        return;
                                      }
                                      if (checkAuthCodeResult ==
                                          SmsAuthStatusCode.SUCCESS) {
                                        if (!mounted) return;
                                        Common.showSnackBar(context,
                                            "인증에 성공하였습니다!\n다음 버튼을 눌러 추가인증을 진행해주세요.");
                                        setState(() {
                                          codeRequestActive = false;
                                          nextButtonActive = true;
                                        });
                                        return;
                                      }
                                      if (!mounted) return;
                                      Common.showSnackBar(
                                          context, "오류가 발생했습니다.");
                                    }, HexColor("#EE795F")),
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
              nextButtonActive == true
                  ? GestureDetector(
                      onTap: () {
                        signUpNotifier.setPhoneNo(
                            withoutHyphenToWithHyphen(phoneNoController.text));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PostCertificateScreen()));
                      },
                      child: Container(
                          width: double.infinity,
                          height: 54.h,
                          margin: EdgeInsets.only(
                              left: 27.w, right: 27.w, top: 570.h),
                          decoration: BoxDecoration(
                              color: HexColor("#425C5A"),
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text(
                            "다음",
                            style: TextStyle(
                                fontSize: 19.5.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                    )
                  : Container(
                      width: double.infinity,
                      height: 54.h,
                      margin:
                          EdgeInsets.only(left: 27.w, right: 27.w, top: 570.h),
                      decoration: BoxDecoration(
                          color: HexColor("#929d9c"),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: Text(
                        "다음",
                        style: TextStyle(
                            fontSize: 19.5.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
            ]),
          ),
        ),
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

  Widget phoneAuthButton(String title, VoidCallback onPressed, Color color) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80.w,
        height: 30.h,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ),
    );
  }
}

enum SmsAuthStatusCode { SUCCESS, ST064, ST065, UNCATCHED_ERROR, ST066, ST067 }
