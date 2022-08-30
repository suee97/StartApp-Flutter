import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/sign_up_notifier.dart';
import 'package:start_app/screens/login/login_option_screen.dart';
import 'package:start_app/screens/login/sign_up/sign_up_end_screen.dart';
import 'package:start_app/utils/common.dart';

class PostCertificateScreen extends StatefulWidget {
  const PostCertificateScreen({Key? key}) : super(key: key);

  @override
  State<PostCertificateScreen> createState() => _PostCertificateScreenState();
}

class _PostCertificateScreenState extends State<PostCertificateScreen> {
  File? imageFile;
  final ImagePicker imagePicker = ImagePicker();
  late bool isLoading;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (context, signUpNotifier, child) {
      return Scaffold(
        body: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 120.h,
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
                    "학생증을 촬영하여 업로드해주세요.",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 28.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 28.w,
                  ),
                  Text(
                    "주의사항",
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
                    "1. 카드 번호, 유효기간, 사진을 가리고 업로드 해주세요.\n2. 빛 반사에 주의해주세요.\n3. 학생증이 손상된 경우 문의해주세요.\n    (02-970-7012)",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.25),
                  ),
                ],
              ),
              SizedBox(
                height: 28.h,
              ),
              GestureDetector(
                onTap: () async {
                  final file = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      maxWidth: 1920,
                      maxHeight: 1080,
                      imageQuality: 100);

                  if (file?.path != null) {
                    setState(() {
                      imageFile = File(file!.path);
                    });
                  }
                },
                child: imageFile != null
                    ? Container(
                        width: 320.w,
                        height: 220.h,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(File(imageFile!.path)))),
                      )
                    : noCertificateContainer(),
              ),
              SizedBox(
                height: 64.h,
              ),
              SizedBox(
                height: 14.h,
              )
            ],
          ),
          GestureDetector(
            onTap: imageFile != null
                ? () async {
                    setState(() {
                      isLoading = true;
                    });
                    final studentNo = signUpNotifier.getStudentNo();
                    final appPassword = signUpNotifier.getAppPassword();
                    final name = signUpNotifier.getName();
                    final department = signUpNotifier.getDepartment();
                    final fcmToken = signUpNotifier.getFcmToken(); // 미구현, 미사용
                    final phoneNo = signUpNotifier.getPhoneNo();

                    final postCertificateResult = await postCertificate(
                        studentNo,
                        appPassword,
                        name,
                        department,
                        fcmToken,
                        phoneNo);

                    if (postCertificateResult ==
                        postSignUpCode.UNCATCHED_ERROR) {
                      if (!mounted) return;
                      Common.showSnackBar(context, "회원가입 요청 오류가 발생했습니다.");
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }

                    if (postCertificateResult == postSignUpCode.ST053) {
                      if (!mounted) return;
                      Common.showSnackBar(context, "이미 가입된 계정이 있습니다.");
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }
                    if (postCertificateResult == postSignUpCode.ST058) {
                      if (!mounted) return;
                      Common.showSnackBar(
                          context, "탈퇴한 계정입니다.\n재가입시 문의주세요. (02-970-7012)");
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }
                    if (postCertificateResult == postSignUpCode.ST066) {
                      if (!mounted) return;
                      Common.showSnackBar(
                          context, "휴대폰 인증 정보가 만료되었습니다. 다시 진행해주세요.");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginOptionScreen()),
                          (route) => false);
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }
                    if (postCertificateResult == postSignUpCode.TIMEOUT) {
                      if (!mounted) return;
                      Common.showSnackBar(
                          context, "네트워크 오류가 발생했습니다. 다시 시도해주세요.");
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }
                    if (postCertificateResult == postSignUpCode.SUCCESS) {
                      if (!mounted) return;
                      Common.showSnackBar(context, "회원가입 요청이 완료되었습니다.");
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpEndScreen()),
                          (route) => false);
                      return;
                    }
                    if (!mounted) return;
                    Common.showSnackBar(context, "오류가 발생했습니다..");
                    setState(() {
                      isLoading = false;
                    });
                  }
                : () {
                    Common.showSnackBar(context, "카메라로 사진을 찍어 업로드해주세요.");
                  },
            child: imageFile != null
                ? Container(
                    width: double.infinity,
                    height: 54.h,
                    margin:
                        EdgeInsets.only(left: 27.w, right: 27.w, top: 570.h),
                    decoration: BoxDecoration(
                        color: HexColor("#425C5A"),
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: isLoading == true
                        ? Center(
                            child: Platform.isIOS
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : CircularProgressIndicator(
                                    color: HexColor("#f3f3f3"),
                                  ),
                          )
                        : Text(
                            "다음",
                            style: TextStyle(
                                fontSize: 19.5.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ))
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
                          color: HexColor("#d9d9d9")),
                    )),
          ),
        ]),
        backgroundColor: HexColor("#f3f3f3"),
      );
    });
  }

  Future<postSignUpCode> postCertificate(String studentNo, String appPassword,
      String name, String department, String fcmToken, String phoneNo) async {
    Dio dio = Dio();
    dio.options.contentType = 'multipart/form-data';

    debugPrint(
        "post info : $studentNo $appPassword $name $department $fcmToken $phoneNo");

    final _file = await MultipartFile.fromFile(imageFile!.path,
            filename: "file_name", contentType: MediaType("image", "jpg"))
        .timeout(const Duration(seconds: 30));

    FormData formData = FormData.fromMap({
      "studentNo": studentNo,
      "appPassword": appPassword,
      "name": name,
      "department": department,
      "fcmToken": "none",
      "file": _file,
      "phoneNo": phoneNo
    });

    try {
      final resString = await dio
          .post("${dotenv.get("DEV_API_BASE_URL")}/member", data: formData);

      if (resString.data["status"] == 201) {
        print("postCertificate() call success");
        return postSignUpCode.SUCCESS;
      }

      return postSignUpCode.UNCATCHED_ERROR;
    } on TimeoutException catch (e) {
      return postSignUpCode.TIMEOUT;
    } catch (e) {
      if(e is DioError) {
        if (e.response?.data["errorCode"] == "ST066") {
          return postSignUpCode.ST066;
        }
        if (e.response?.data["errorCode"] == "ST058") {
          return postSignUpCode.ST058;
        }
        if (e.response?.data["errorCode"] == "ST053") {
          return postSignUpCode.ST053;
        }
        return postSignUpCode.UNCATCHED_ERROR;
      }
      debugPrint(e.toString());
      return postSignUpCode.UNCATCHED_ERROR;
    }
  }

  Widget noCertificateContainer() {
    return Container(
      width: 320.w,
      height: 220.h,
      decoration: BoxDecoration(
        color: HexColor("#b2bfb6"),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          "이곳을 누르면 카메라가 실행됩니다.",
          style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: HexColor("#f26464")),
        ),
      ),
    );
  }
}

enum postSignUpCode { SUCCESS, UNCATCHED_ERROR, ST053, ST058, ST066, TIMEOUT }
