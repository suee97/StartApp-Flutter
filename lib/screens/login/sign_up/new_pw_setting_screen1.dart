import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/sign_up_notifier.dart';
import 'package:start_app/screens/login/login_widgets.dart';
import 'package:start_app/screens/login/sign_up/phone_certificate_screen.dart';
import 'package:start_app/utils/common.dart';

class NewPwSettingScreen1 extends StatefulWidget {
  const NewPwSettingScreen1({Key? key}) : super(key: key);

  @override
  State<NewPwSettingScreen1> createState() => _NewPwSettingScreenState1();
}

class _NewPwSettingScreenState1 extends State<NewPwSettingScreen1> {
  // final appPwController_1 = TextEditingController();
  // final appPwController_2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String appPw1 = "";
  String appPw2 = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
              child: Form(
                key: this._formKey,
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
                              padding: EdgeInsets.only(top: 15.h, left: 28.w, right: 28.w),
                              child: SizedBox(
                                  height: 30.h,
                                  child:
                                  TextFormField(
                                    //   controller: appPwController_1,
                                      obscureText: true,
                                      cursorColor: HexColor("#425C5A"),
                                      maxLines: 1,
                                      enableSuggestions: false,
                                      autovalidateMode: AutovalidateMode.always,
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
                                      onSaved: (value){
                                        setState((){
                                          appPw1 = value as String;
                                        });
                                      },
                                      validator: (value){
                                        if(value == null || value.isEmpty){
                                          return '비어있는 필드가 있는지 확인해주세요.';
                                        }
                                        if (value.toString().length < 8) {
                                          return '8자 이상로 입력해주세요.';
                                        }
                                        if (value.toString().length > 16){
                                          return '16자 이하로 입력해주세요.';
                                        }
                                        if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,16}$').hasMatch(value!)) {
                                          return '특수문자, 대소문자, 숫자를 포함해주세요.';
                                        }
                                        return null;
                                      }
                                  )
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
                              padding: EdgeInsets.only(top: 15.h, left: 28.w, right: 28.w),
                              child: SizedBox(
                                height: 30.h,
                                child: TextFormField(
                                  // controller: appPwController_2,
                                    autovalidateMode: AutovalidateMode.always,
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
                                    onSaved: (value){
                                      setState((){
                                        appPw2 = value as String;
                                      });
                                    },
                                    validator: (value){
                                      if(value.toString().length < 1){
                                        return '비어있는 필드가 있는지 확인해주세요.';
                                      }
                                      if (value.toString().length < 8) {
                                        return '8자 이상로 입력해주세요.';
                                      }
                                      if (value.toString().length > 16){
                                        return '16자 이하로 입력해주세요.';
                                      }
                                      if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,16}$').hasMatch(value!)) {
                                        return '특수문자, 대소문자, 숫자를 포함해주세요.';
                                      }
                                      return null;
                                    }
                                ),
                              )),
                          SizedBox(
                            height: 28.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LoginNavButton(
                width: 304.w,
                margin: EdgeInsets.only(bottom: 16.h),
                onPressed: () {
                  String pw1 = appPw1;
                  String pw2 = appPw2;

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
                  final validationResult = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,16}$')
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

class CorrectWordParameter {
  bool is8Characters;
  bool is1Symbol;
  bool is1Letter;
  bool is1Number;
  CorrectWordParameter({this.is8Characters = false, this.is1Symbol = false, this.is1Letter = false, this.is1Number = false});
  bool get isCorrectWord => (is8Characters && is1Symbol && is1Letter && is1Number);
}

CorrectWordParameter checkPossiblePasswordText(String value) {
  var correctWordParameter = CorrectWordParameter();
  final  validNumbers = RegExp(r'(\d+)');
  final  validAlphabet = RegExp(r'[a-zA-Z]');
  final  validSpecial = RegExp(r'^[a-zA-Z0-9 ]+$');

  //문자가 비었는지 확인
  if(value.isEmpty) {
    // 문자가 비었다면 모드 false로 리턴
    return CorrectWordParameter();
  }

  //8자 이상인지 확인
  if(value.length >= 8) {
    correctWordParameter.is8Characters = true;
  }
  else {
    correctWordParameter.is8Characters = false;
  }

  //특수기호가 있는지 확인
  if(!validSpecial.hasMatch(value)) {
    correctWordParameter.is1Symbol = true;
  }
  else {
    correctWordParameter.is1Symbol = false;
  }

  //문자가 있는지 확인
  if(!validAlphabet.hasMatch(value)) {
    correctWordParameter.is1Letter = false;
  }
  else {
    correctWordParameter.is1Letter = true;
  }

  //숫자가 있는지 확인
  if(validNumbers.hasMatch(value)) {
    correctWordParameter.is1Number = true;
  }
  else {
    correctWordParameter.is1Number = false;
  }
  return correctWordParameter;
}

/////////// 테스트 코드 ///////////////////////
void main(List<String> arguments) async {
  var text = 'abcd@122';
  var correct = checkPossiblePasswordText(text);
  print('input text: $text');
  print('is correct word  : ${correct.isCorrectWord }');
  print('more than 8 vharacters : ${correct.is8Characters}');
  print('speicail vharacters : ${correct.is1Symbol}');
  print('letter : ${correct.is1Letter}');
  print('number : ${correct.is1Number}');
}



