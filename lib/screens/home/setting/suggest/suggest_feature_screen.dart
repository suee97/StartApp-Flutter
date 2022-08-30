import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:start_app/screens/home/setting/suggest/suggest_widgets.dart';
import 'package:start_app/utils/common.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../models/status_code.dart';

class SuggestFeatureScreen extends StatefulWidget {
  const SuggestFeatureScreen({Key? key}) : super(key: key);

  @override
  State<SuggestFeatureScreen> createState() => _SuggestFeatureScreenState();
}

class _SuggestFeatureScreenState extends State<SuggestFeatureScreen> {
  final titleTextController = TextEditingController();
  final contentTextController = TextEditingController();
  File? imageFile;
  final ImagePicker imagePicker = ImagePicker();
  bool isLoading = false;

  @override
  void dispose() {
    titleTextController.dispose();
    contentTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "기능 개선 제안",
          style: Common.startAppBarTextStyle,
        ),
        foregroundColor: HexColor("#425C5A"),
        backgroundColor: HexColor("#f3f3f3"),
        elevation: 0,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 8.h,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: SuggestTitleTextField(
                    textController: titleTextController,
                    hintText: "제목을 입력하세요",
                  )),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: SuggestContentTextField(
                  textController: contentTextController,
                  hintText: "바라는 개선사항을 적어주세요",
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 12.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (imageFile != null) return;

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
                      }
                    },
                    child: Container(
                        child: imageFile != null
                            ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                                padding: EdgeInsets.all(10),
                                width: 300.w,
                                height: 300.h,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    border: Border.all(
                                      color: HexColor("#f9b7a9")
                                          .withOpacity(0.5),
                                    )),
                                child: Image.file(File(imageFile!.path), fit: BoxFit.cover)
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  imageFile = null;
                                });
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                width: 310.w,
                                height: 310.h,
                                padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
                                child: Icon(Icons.cancel),
                              ),
                            ),
                          ],
                        )
                            : Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 312.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: HexColor("#f5efea"),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1.w,
                                        color: HexColor("#f9b7a9")
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    child: Text("사진 추가하기",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400))),
                              )),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "- 안내사항\n모든 사항은 익명으로 전달됩니다.\n답변이 필요한 경우 연락처를 남겨주세요.",
                      style: TextStyle(
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w300,
                          color: HexColor("#EE795F")),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 155.w,
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: HexColor("#425C5A"),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      child: Text(
                        "취소",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (titleTextController.text.isEmpty ||
                          contentTextController.text.isEmpty) {
                        Common.showSnackBar(context, "비어있는 필드가 있는지 확인해주세요");
                        return;
                      }
                      final postSuggestResult = await postSuggest();
                      if (postSuggestResult == StatusCode.SUCCESS) {
                        if (!mounted) return;
                        Common.showSnackBar(context, "전달이 완료되었습니다!");
                        Navigator.pop(context);
                        return;
                      }
                      if (!mounted) return;
                      Common.showSnackBar(context, "오류가 발생했습니다.");
                    },
                    child: Container(
                      width: 155.w,
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: HexColor("#425C5A"),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Text(
                        "등록",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              )
            ],
          ),
        ),
      ),
      backgroundColor: HexColor("f3f3f3"),
    );
  }

  Future<StatusCode> postSuggest() async {
    final String title = titleTextController.text;
    final String content = contentTextController.text;

    Dio dio = Dio();
    dio.options.contentType = 'multipart/form-data';

    var _file;

    if (imageFile != null) {
      _file = await MultipartFile.fromFile(imageFile!.path,
          filename: "file_name", contentType: MediaType("image", "jpg"));
    } else {
      _file = null;
    }

    FormData _formData = FormData.fromMap({
      "title": title,
      "content": content,
      "category": "FEATURE",
      "file": _file
    });

    try {
      final resString = await dio.post(
          "${dotenv.get("DEV_API_BASE_URL")}/suggestion",
          data: _formData);

      if (resString.data["status"] == 201) {
        print("postSuggest() call : Success");
        return StatusCode.SUCCESS;
      }

      return StatusCode.UNCATCHED_ERROR;
    } catch (e) {
      print("postSuggest() call : Error\n$e");
      return StatusCode.UNCATCHED_ERROR;
    }
  }
}
