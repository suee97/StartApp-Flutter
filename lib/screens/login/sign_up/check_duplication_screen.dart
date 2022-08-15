import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_app/screens/login/sign_up/auth_webview_screen.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/test_button.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CheckDuplication extends StatefulWidget {
  const CheckDuplication({Key? key}) : super(key: key);

  @override
  State<CheckDuplication> createState() => _CheckDuplicationState();
}

class _CheckDuplicationState extends State<CheckDuplication> {
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
              onPressed: () async {
                String studentNo = studentIdController.text;
                var uuid = Uuid();
                var key = uuid.v4();
                String path =
                    "https://for-a.seoultech.ac.kr/STECH/API/VIEW/login.jsp?orgnCd=${dotenv.env["COMPUTERIZATION_BUSINESS_KEY"]}&returnUrl=";
                String authUrl =
                    "$path${dotenv.env["DEV_API_BASE_URL"]}/seoultech?studentNo=$studentNo&key=$key";
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthWebviewScreen(url: authUrl)),
                );
              })
        ])));
  }
}
