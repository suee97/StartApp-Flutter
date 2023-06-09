import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/sign_up_notifier.dart';
import 'package:start_app/screens/login/login_option_screen.dart';
import 'package:start_app/screens/login/login_widgets.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (context, signUpNotifier, child) {
      return Scaffold(
        appBar: Common.SignUpAppBar("학생증 인증"),
        body: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
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
                    "실물 학생증을 직접 촬영하거나\n모바일 학생증 캡쳐 사진을 업로드해 주세요.",
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
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: HexColor("#F8EAE1"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          title:

                          Text(
                            "학생증 사진 업로드",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.w500),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "실물 학생증 사진을 촬영하거나 모바일 학생증 사진을 업로드할 수 있습니다.",
                                style: TextStyle(
                                    fontSize: 15.5.sp,
                                    fontWeight: FontWeight.w300,height: 1.5),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
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
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Container(
                                      width: 114.w,
                                      height: 76.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: HexColor("#425c5a"),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      child: Text(
                                        "학생증\n촬영",
                                        style: TextStyle(
                                            fontSize: 19.5.sp,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  GestureDetector(
                                    onTap: () async {

                                        final file = await ImagePicker().pickImage(
                                            source: ImageSource.gallery,
                                            maxWidth: 1920,
                                            maxHeight: 1080,
                                            imageQuality: 100 //0-100
                                        );

                                        if (file?.path != null) {
                                          setState(() {
                                            imageFile = File(file!.path);
                                          });
                                          Navigator.pop(context);
                                        }
                                    },
                                    child: Container(
                                      width: 114.w,
                                      height: 76.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: HexColor("#425c5a"),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      child: Text(
                                        "모바일\n학생증\n업로드",
                                        style: TextStyle(
                                            fontSize: 19.5.sp,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
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
                height: 14.h,
              ),
              SizedBox(
                height: 64.h,
              ),
              SizedBox(
                height: 14.h,
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: imageFile != null
                ? LoginNavButton(
                    onPressed: imageFile != null
                        ? () async {
                            setState(() {
                              isLoading = true;
                            });

                            final studentNo = signUpNotifier.getStudentNo();
                            final appPassword = signUpNotifier.getAppPassword();
                            final name = signUpNotifier.getName();
                            final department = signUpNotifier.getDepartment();
                            final fcmToken =
                                signUpNotifier.getFcmToken(); // 미구현, 미사용
                            final phoneNo = signUpNotifier.getPhoneNo();

                            final postCertificateResult = await postCertificate(
                                studentNo,
                                appPassword,
                                name,
                                department,
                                fcmToken,
                                phoneNo);

                            if (postCertificateResult ==
                                PostSignUpCode.UNCATCHED_ERROR) {
                              if (!mounted) return;
                              Common.showSnackBar(
                                  context, "회원가입 요청 오류가 발생했습니다.");
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }

                            if (postCertificateResult == PostSignUpCode.ST053) {
                              if (!mounted) return;
                              Common.showSnackBar(context, "이미 가입된 계정이 있습니다.");
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                            if (postCertificateResult == PostSignUpCode.ST058) {
                              if (!mounted) return;
                              Common.showSnackBar(context,
                                  "탈퇴한 계정입니다.\n재가입시 문의주세요. (02-970-7012)");
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                            if (postCertificateResult == PostSignUpCode.ST066) {
                              if (!mounted) return;
                              Common.showSnackBar(
                                  context, "휴대폰 인증 정보가 만료되었습니다. 다시 진행해주세요.");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginOptionScreen()),
                                  (route) => false);
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                            if (postCertificateResult ==
                                PostSignUpCode.TIMEOUT) {
                              if (!mounted) return;
                              Common.showSnackBar(
                                  context, "네트워크 오류가 발생했습니다. 다시 시도해주세요.");
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                            if (postCertificateResult ==
                                PostSignUpCode.SUCCESS) {
                              if (!mounted) return;
                              Common.showSnackBar(context, "회원가입 요청이 완료되었습니다.");
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpEndScreen()),
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
                            Common.showSnackBar(
                                context, "카메라로 사진을 찍어 업로드해주세요.");
                          },
                    title: "다음",
                    colorHex: "#425C5A",
                    margin: EdgeInsets.only(bottom: 16.h),
                    isLoading: isLoading,
                    width: 304.w)
                : LoginNavButton(
                    onPressed: () {},
                    title: "다음",
                    colorHex: "#929D9C",
                    margin: EdgeInsets.only(bottom: 16.h),
                    width: 304.w),
          ),
        ]),
        backgroundColor: HexColor("#f3f3f3"),
      );
    });
  }

  Future<PostSignUpCode> postCertificate(String studentNo, String appPassword,
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
        return PostSignUpCode.SUCCESS;
      }

      return PostSignUpCode.UNCATCHED_ERROR;
    } on TimeoutException catch (e) {
      return PostSignUpCode.TIMEOUT;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data["errorCode"] == "ST066") {
          return PostSignUpCode.ST066;
        }
        if (e.response?.data["errorCode"] == "ST058") {
          return PostSignUpCode.ST058;
        }
        if (e.response?.data["errorCode"] == "ST053") {
          return PostSignUpCode.ST053;
        }
        return PostSignUpCode.UNCATCHED_ERROR;
      }
      debugPrint(e.toString());
      return PostSignUpCode.UNCATCHED_ERROR;
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
          "이곳을 눌러서 사진을 업로드해주세요.",
          style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: HexColor("#f26464")),
        ),
      ),
    );
  }
}

enum PostSignUpCode { SUCCESS, UNCATCHED_ERROR, ST053, ST058, ST066, TIMEOUT }
