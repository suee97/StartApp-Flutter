import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/login/login_widgets.dart';
import 'package:start_app/screens/login/sign_up/check_info_screen.dart';
import 'package:start_app/utils/common.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PolicyAgreeScreen extends StatefulWidget {
  const PolicyAgreeScreen({Key? key}) : super(key: key);

  @override
  State<PolicyAgreeScreen> createState() => _PolicyAgreeScreenState();
}

class _PolicyAgreeScreenState extends State<PolicyAgreeScreen> {
  bool servicePolicyAgreeState = false;
  bool privacyPolicyAgreeState = false;
  bool isAllAgree = false;
  Color orangeColor = HexColor("EE795F");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.SignUpAppBar("약관동의"),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                "약관동의",
                style: TextStyle(
                    fontSize: 21.5.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#425C5A")),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                "ST'art 어플 사용을 위한 약관동의를 해주세요.",
                style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              width: double.infinity,
              height: 1.h,
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              color: HexColor("#425C5A"),
            ),
            SizedBox(
              height: 144.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 68.w,
                ),
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                        shape: const CircleBorder(),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) =>
                              BorderSide(width: 2.w, color: orangeColor),
                        ),
                        value: servicePolicyAgreeState,
                        checkColor: orangeColor,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            servicePolicyAgreeState = value!;
                          });
                          checkIsAllAgree();
                        }),
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      servicePolicyAgreeState = !servicePolicyAgreeState;
                    });
                    checkIsAllAgree();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 8.w, right: 8.w, top: 4.h, bottom: 4.h),
                    child: Text(
                      "서비스 이용약관",
                      style: TextStyle(
                          fontSize: 17.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    const url =
                        'https://suee97.notion.site/2022-09-04-f4d6b4b0db614adba75d4c619371aea9';
                    launchUrlString(url);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 8.h),
                    child: Text(
                      "자세히 보기 >",
                      style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w300,
                          color: orangeColor),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 68.w,
                ),
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                        shape: const CircleBorder(),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) =>
                              BorderSide(width: 2.w, color: orangeColor),
                        ),
                        value: privacyPolicyAgreeState,
                        checkColor: orangeColor,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            privacyPolicyAgreeState = value!;
                          });
                          checkIsAllAgree();
                        }),
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      privacyPolicyAgreeState = !privacyPolicyAgreeState;
                    });
                    checkIsAllAgree();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 8.w, right: 8.w, top: 4.h, bottom: 4.h),
                    child: Text(
                      "개인정보처리방침",
                      style: TextStyle(
                          fontSize: 17.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    const url =
                        'https://suee97.notion.site/2022-09-04-a48b73c5ed6a43068286d8f2d6adab05';
                    launchUrlString(url);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 8.h),
                    child: Text(
                      "자세히 보기 >",
                      style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w300,
                          color: orangeColor),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: isAllAgree == true
              ? LoginNavButton(
                  margin: EdgeInsets.only(bottom: 16.h),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckInfoScreen()));
                  },
                  title: "다음",
                  colorHex: "#425C5A",
                  width: 304.w)
              : LoginNavButton(
                  margin: EdgeInsets.only(bottom: 16.h),
                  onPressed: () {},
                  title: "다음",
                  colorHex: "#929d9c",
                  width: 304.w),
        )
      ]),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  void checkIsAllAgree() {
    if (servicePolicyAgreeState == true && privacyPolicyAgreeState == true) {
      setState(() {
        isAllAgree = true;
      });
    } else {
      setState(() {
        isAllAgree = false;
      });
    }
  }
}
