import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_app/screens/login/sign_up/signup_screen.dart';
import '../../../models/status_code.dart';
import '../../../widgets/test_button.dart';

class CheckInfoScreen extends StatefulWidget {
  const CheckInfoScreen({Key? key}) : super(key: key);

  @override
  State<CheckInfoScreen> createState() => _CheckInfoScreenState();
}

class _CheckInfoScreenState extends State<CheckInfoScreen> {
  bool isPolicyAgree = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Text(
            "회원가입",
            style: TextStyle(fontSize: 25.5.sp, fontWeight: FontWeight.w600),
          ),
          Text(
            "본인의 정보를 확인해주세요.",
            style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600),
          ),
          Container(
            width: 300.w,
            height: 200.h,
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("이름: 홍길동",
                    style: TextStyle(
                        fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 10.h),
                Text("학과: ITM전공",
                    style: TextStyle(
                        fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 10.h),
                Text("학번: 19102020",
                    style: TextStyle(
                        fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 10.h),
                Text("휴대전화: 010-1234-1234",
                    style: TextStyle(
                        fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 10.h),
                Text("이메일: hong1004@naver.com",
                    style: TextStyle(
                        fontSize: 16.5.sp, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(children: [
                  Text(
                    "개인정보 동의 약관",
                    style: TextStyle(
                        fontSize: 12.5.sp, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "자세히 보기 >",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 10.5.sp,
                            fontWeight: FontWeight.w400),
                      ))
                ]),
                Row(children: [
                  Checkbox(
                      value: isPolicyAgree,
                      onChanged: (value) {
                        setState(() {
                          isPolicyAgree = value!;
                        });
                      }),
                  Text("위 정보를 ST’art 어플에서 사용하는 것에 동의",
                      style: TextStyle(fontSize: 10.sp)),
                ])
              ],
            ),
          ),
          TestButton(
              title: "확인",
              onPressed: () => {
                    // Common.setNonLogin(true),
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignupScreen()))
                  })
        ])));
  }

  // Future<StatusCode> checkInfo(String key) async{
  //
  // }

}
