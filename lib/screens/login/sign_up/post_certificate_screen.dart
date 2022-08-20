import 'dart:convert';
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
import 'package:start_app/models/status_code.dart';
import 'package:start_app/notifiers/sign_up_notifier.dart';
import 'package:start_app/screens/home/home_screen.dart';
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
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                height: 16.h,
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
              Row(
                children: [
                  SizedBox(
                    width: 28.w,
                  ),
                  Text(
                    "1. 카드 번호, 유효기간, 사진을 가리고 업로드 해주세요.\n2. 빛 반사에 주의해주세요.\n3. 학생증이 손상된 경우 문의해주세요.",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 36.h,
              ),
              GestureDetector(
                onTap: () async {
                  final file = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      maxWidth: 640,
                      maxHeight: 280,
                      imageQuality: 50 //0-100
                      );

                  if (file?.path != null) {
                    setState(() {
                      imageFile = File(file!.path);
                      print(imageFile?.path);
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
                height: 8.h,
              ),
              SizedBox(
                height: 56.h,
              ),
              GestureDetector(
                onTap: imageFile != null
                    ? () async {
                        setState(() {
                          isLoading = true;
                        });
                        var studentNo = signUpNotifier.getStudentNo();
                        var appPassword = signUpNotifier.getAppPassword();
                        var name = signUpNotifier.getName();
                        var department = signUpNotifier.getDepartment();
                        var fcmToken = signUpNotifier.getFcmToken(); // 미구현, 미사용

                        var postCertificateResult = await postCertificate(
                            studentNo, appPassword, name, department, fcmToken);

                        if (postCertificateResult != StatusCode.SUCCESS) {
                          if (mounted) {
                            Common.showSnackBar(context, "회원가입 요청 오류가 발생했습니다.");
                          }
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        setState(() {
                          isLoading = false;
                        });

                        if (mounted) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpEndScreen()),
                              (route) => false);
                        }
                      }
                    : () {
                        Common.showSnackBar(context, "카메라로 사진을 찍어 업로드해주세요.");
                      },
                child: imageFile != null
                    ? Container(
                        width: 304.w,
                        height: 54.h,
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
                        width: 304.w,
                        height: 54.h,
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
              SizedBox(
                height: 14.h,
              )
            ],
          ),
        ),
        backgroundColor: HexColor("#f3f3f3"),
      );
    });
  }

  Future<StatusCode> postCertificate(String studentNo, String appPassword,
      String name, String department, String fcmToken) async {
    Dio dio = Dio();
    dio.options.contentType = 'multipart/form-data';

    final _file = await MultipartFile.fromFile(imageFile!.path,
        filename: "file_name", contentType: MediaType("image", "jpg"));

    FormData _formData = FormData.fromMap({
      "studentNo": studentNo,
      "appPassword": appPassword,
      "name": name,
      "department": department,
      "fcmToken": "none",
      "file": _file
    });

    try {
      final resString = await dio
          .post("${dotenv.get("DEV_API_BASE_URL")}/member", data: _formData);

      if (resString.data["status"] == 201) {
        print("postCertificate() call success");
        return StatusCode.SUCCESS;
      }

      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      print("error $e");
      return StatusCode.UNCATCHED_ERROR;
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
          "이곳을 누르면 카메라가 열립니다.",
          style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: HexColor("#f26464")),
        ),
      ),
    );
  }
}
