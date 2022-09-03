import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/sign_up_notifier.dart';
import 'package:start_app/screens/login/login_widgets.dart';
import 'package:start_app/screens/login/sign_up/phone_certificate_screen.dart';
import 'package:start_app/utils/common.dart';

class PwSettingScreen extends StatefulWidget {
  const PwSettingScreen({Key? key}) : super(key: key);

  @override
  State<PwSettingScreen> createState() => _PwSettingScreenState();
}

class _PwSettingScreenState extends State<PwSettingScreen> {
  final appPwController_1 = TextEditingController();
  final appPwController_2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    appPwController_1.dispose();
    appPwController_2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (context, signUpNotifier, child) {
      return Scaffold(
        appBar: Common.SignUpAppBar("비밀번호 설정"),
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
              reverse: true,
              padding: EdgeInsets.only(bottom: 72.h),
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
                  Row(
                    children: [
                      SizedBox(
                        width: 28.w,
                      ),
                      Text(
                        "ST'art 어플에서 사용할 비밀번호를 설정해주세요.",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 28.w,
                      ),
                      Text(
                        "특수문자, 대소문자, 숫자 포함\n8자 이상 15자 이내로 입력해주세요.",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 216.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                                controller: appPwController_1,
                                cursorColor: HexColor("#425C5A"),
                                maxLines: 1,
                                enableSuggestions: false,
                                obscureText: true,
                                style: TextStyle(
                                    fontSize: 17.5.sp,
                                    fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
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
                        Row(
                          children: [
                            SizedBox(
                              width: 28.w,
                            ),
                            Text(
                              "비밀번호 확인",
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
                                controller: appPwController_2,
                                cursorColor: HexColor("#425C5A"),
                                maxLines: 1,
                                enableSuggestions: false,
                                obscureText: true,
                                style: TextStyle(
                                    fontSize: 17.5.sp,
                                    fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
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
                          height: 28.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LoginNavButton(
                width: 304.w,
                margin: EdgeInsets.only(bottom: 16.h),
                onPressed: () {
                  String pw1 = appPwController_1.text;
                  String pw2 = appPwController_2.text;

                  /// 비어있는지 확인
                  if (pw1.isEmpty || pw2.isEmpty) {
                    Common.showSnackBar(context, "비어있는 필드가 있는지 확인해주세요.");
                    return;
                  }

                  /// 같은지 확인
                  if (pw1 != pw2) {
                    Common.showSnackBar(context, "비밀번호 입력이 동일한지 확인해주세요.");
                    return;
                  }

                  /// 유효성 검사 (특수문자, 대소문자, 숫자 포함 8자 이상 16자 이내)
                  final validationResult = RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,16}$')
                      .hasMatch(pw1);
                  if (!validationResult) {
                    Common.showSnackBar(context,
                        "비밀번호를 다음과 같이 맞춰주세요.\n특수문자, 대소문자, 숫자 포함 8자 이상 16자 이내");
                    return;
                  }

                  signUpNotifier.setAppPassword(pw1);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const PhoneCertificateScreen()));
                },
                title: "다음",
                colorHex: '#425C5A',
              ),
            ),
          ]),
        ),
        backgroundColor: HexColor("#f3f3f3"),
      );
    });
  }
}
