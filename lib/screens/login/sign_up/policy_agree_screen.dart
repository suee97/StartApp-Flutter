import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/setting/policy/privacy_policy_screen.dart';
import 'package:start_app/screens/login/login_widgets.dart';
import 'package:start_app/screens/login/sign_up/check_info_screen.dart';
import 'package:start_app/utils/common.dart';

import '../../home/setting/policy/service_policy_screen.dart';

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
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              height: 120.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                  width: 12.w,
                ),
                Text(
                  "서비스 이용약관",
                  style: TextStyle(
                      fontSize: 17.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServicePolicyScreen()));
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
              crossAxisAlignment: CrossAxisAlignment.end,
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
                  width: 12.w,
                ),
                Text(
                  "개인정보처리방침",
                  style: TextStyle(
                      fontSize: 17.5.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicyScreen()));
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
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 16.h),
          child: isAllAgree == true
              ? LoginNavButton(
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
