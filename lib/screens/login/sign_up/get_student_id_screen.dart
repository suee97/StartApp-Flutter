import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/test_button.dart';

class GetStudentIdScreen extends StatefulWidget {
  const GetStudentIdScreen({Key? key}) : super(key: key);

  @override
  State<GetStudentIdScreen> createState() => _GetStudentIdScreenState();
}

class _GetStudentIdScreenState extends State<GetStudentIdScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final studentIdController = TextEditingController();

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
            "재학생 확인을 위해 서울과학기술대학교 통합정보시스템 에서 사용하는 ID/PW를 입력해주세요.",
            style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600),
          ),
          CustomTextField(
            label: "학번",
            controller: studentIdController,
            isObscure: false,
          ),
          TestButton(
              title: "확인",
              onPressed: () {
                // Common.setNonLogin(true),
              })
        ])));
  }


}
