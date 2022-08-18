import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:start_app/notifiers/sign_up_notifier.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (context, signUpNotifier, child) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.lightGreen,
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
              GestureDetector(
                onTap: () async {
                  final file = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      maxWidth: 640,
                      maxHeight: 280,
                      imageQuality: 100 //0-100
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
                                fit: BoxFit.cover,
                                image: FileImage(File(imageFile!.path)))),
                      )
                    : Container(
                        width: 320.w,
                        height: 220.h,
                        decoration: BoxDecoration(
                          color: HexColor("#b2bfb6"),
                          borderRadius: BorderRadius.circular(30),
                        )),
              ),
              SizedBox(
                height: 16.h,
              ),
              GestureDetector(
                onTap: imageFile != null
                    ? () {
                        var studentNo = signUpNotifier.getStudentNo();
                        var appPassword = signUpNotifier.getAppPassword();
                        var name = signUpNotifier.getName();
                        var department = signUpNotifier.getDepartment();
                        var fcmToken = signUpNotifier.getFcmToken();

                        postCertificate(studentNo, appPassword, name,
                            department, fcmToken, imageFile);
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
                        child: Text(
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

  Future<void> postCertificate(String studentNo, String appPassword,
      String name, String department, String fcmToken, dynamic file) async {
    Dio dio = Dio();

    final MultipartFile _file = await MultipartFile.fromFile(
        imageFile!.path,
        contentType: MediaType("image", "jpg"));

    dio.options.contentType = 'multipart/form-data';

    FormData _formData = FormData.fromMap({
      "studentNo": studentNo,
      "appPassword": appPassword,
      "name": name,
      "department": department,
      "fcmToken": fcmToken,
      "file": _file
    });

    final resString = await dio.post("https://dev.seoultech-startapp.com/api/member",
        data: _formData);

    print(resString);
  }
}
