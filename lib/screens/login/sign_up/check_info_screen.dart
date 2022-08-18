import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/models/status_code.dart';
import 'package:start_app/screens/login/sign_up/pw_setting_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import '../../../utils/common.dart';

class CheckInfoScreen extends StatefulWidget {
  const CheckInfoScreen({Key? key}) : super(key: key);

  @override
  State<CheckInfoScreen> createState() => _CheckInfoScreenState();
}

class _CheckInfoScreenState extends State<CheckInfoScreen> {
  bool isLoading = false;
  final studentIdController = TextEditingController();
  final studentNameController = TextEditingController();
  final studentDepartmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    studentIdController.dispose();
    studentNameController.dispose();
    studentDepartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                    "학생증과 일치하는 정보를 입력해주세요.",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Container(
                height: 304.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    textFiledTitleRowWidget("학번"),
                    Padding(
                        padding: EdgeInsets.only(left: 28.w, right: 28.w),
                        child: SizedBox(
                          height: 30.h,
                          child: TextField(
                            controller: studentIdController,
                            keyboardType: TextInputType.number,
                            cursorColor: HexColor("#425C5A"),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLines: 1,
                            enableSuggestions: false,
                            style: TextStyle(
                                fontSize: 17.5.sp, fontWeight: FontWeight.w300),
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
                          ),
                        )),
                    SizedBox(
                      height: 16.h,
                    ),
                    textFiledTitleRowWidget("이름"),
                    Padding(
                        padding: EdgeInsets.only(left: 28.w, right: 28.w),
                        child: SizedBox(
                          height: 30.h,
                          child: TextField(
                            controller: studentNameController,
                            cursorColor: HexColor("#425C5A"),
                            maxLines: 1,
                            enableSuggestions: false,
                            style: TextStyle(
                                fontSize: 17.5.sp, fontWeight: FontWeight.w300),
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
                          ),
                        )),
                    SizedBox(
                      height: 16.h,
                    ),
                    textFiledTitleRowWidget("학과"),
                    Padding(
                        padding: EdgeInsets.only(left: 28.w, right: 28.w),
                        child: SizedBox(
                          height: 30.h,
                          child: TextField(
                            controller: studentDepartmentController,
                            cursorColor: HexColor("#425C5A"),
                            maxLines: 1,
                            enableSuggestions: false,
                            style: TextStyle(
                                fontSize: 17.5.sp, fontWeight: FontWeight.w300),
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
                          ),
                        )),
                    SizedBox(
                      height: 28.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });

                        /// 학번 유효성 검사
                        if (studentIdController.text.isEmpty) {
                          Common.showSnackBar(context, "학번을 입력해주세요.");
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        if (studentIdController.text.length != 8) {
                          Common.showSnackBar(context, "올바른 학번을 입력해주세요.");
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        /// 학번 중복 검사
                        var statusCode = await checkIdDuplication(
                            studentIdController.text, context);

                        if (statusCode == StatusCode.CONNECTION_ERROR) {
                          if (mounted) {
                            Common.showSnackBar(context, "오류가 발생했습니다.");
                          }

                          return;
                        }

                        if (statusCode == StatusCode.UNCATCHED_ERROR) {
                          if (mounted) {
                            Common.showSnackBar(context, "이미 가입된 학번입니다.");
                          }
                          return;
                        }

                        /// 이름 유효성 검사
                        if (studentNameController.text.isEmpty) {
                          if (mounted) {
                            Common.showSnackBar(context, "이름을 입력해주세요.");
                          }
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        /// 학과 유효성 검사
                        if (studentDepartmentController.text.isEmpty) {
                          if (mounted) {
                            Common.showSnackBar(context, "학과를 입력해주세요.");
                          }
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        if (statusCode == StatusCode.SUCCESS) {
                          if (mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PwSettingScreen()));
                            setState(() {
                              isLoading = false;
                            });
                          }
                          return;
                        }

                        if (mounted) {
                          Common.showSnackBar(context, "오류가 발생했습니다.");
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        width: 304.w,
                        height: 54.h,
                        decoration: BoxDecoration(
                            color: HexColor("#425C5A"),
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: isLoading == false
                            ? Text(
                                "다음",
                                style: TextStyle(
                                    fontSize: 19.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            : Center(
                                child: Platform.isIOS
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.white,
                                      )
                                    : CircularProgressIndicator(
                                        color: HexColor("#f3f3f3"),
                                      ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: HexColor("#f3f3f3"),
      ),
    );
  }

  Future<StatusCode> checkIdDuplication(
      String studentId, BuildContext context) async {
    final _studentId = int.parse(studentId);
    Map<String, dynamic> resData = {};

    try {
      var resString = await http
          .get(
            Uri.parse(
                "${dotenv.get("DEV_API_BASE_URL")}/member/duplicate?studentNo=${_studentId}"),
          )
          .timeout(const Duration(seconds: 10));
      resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 200) {
        return StatusCode.SUCCESS;
      }

      if (resData["status"] == 400) {
        return StatusCode.UNCATCHED_ERROR; // 중복
      }

      return StatusCode.CONNECTION_ERROR;
    } on TimeoutException catch (e) {
      return StatusCode.TIMEOUT_ERROR;
    } on SocketException catch (e) {
      return StatusCode.CONNECTION_ERROR;
    } catch (e) {
      return StatusCode.CONNECTION_ERROR;
    }
  }

  Widget textFiledTitleRowWidget(String title) {
    return Row(
      children: [
        SizedBox(
          width: 28.w,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w300,
              color: HexColor("#425c5a")),
        ),
      ],
    );
  }
}
