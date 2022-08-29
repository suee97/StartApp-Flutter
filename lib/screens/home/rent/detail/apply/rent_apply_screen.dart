import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../models/status_code.dart';
import '../../../../../utils/auth.dart';
import '../../../../../utils/common.dart';
import '../../../../../widgets/rent_custom_text_field.dart';
import '../../../../login/login_screen.dart';
import 'dotted_line_widget.dart';
import 'package:http/http.dart' as http;

class RentApplyScreen extends StatefulWidget {
  RentApplyScreen(
      {Key? key,
      required this.categoryKr,
      required this.itemIcon,
      required this.categoryEng})
      : super(key: key);

  String categoryKr;
  String categoryEng;
  String itemIcon;

  @override
  State<RentApplyScreen> createState() => _RentApplyScreenState();
}

class _RentApplyScreenState extends State<RentApplyScreen> {
  DateTimeRange? _selectedDateRange;
  bool agreementCheckBoxState = false;
  final rentPurposeController = TextEditingController();
  final rentAmountController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    rentPurposeController.dispose();
    rentAmountController.dispose();
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
          "상시사업 예약",
          style: Common.startAppBarTextStyle,
        ),
        foregroundColor: Colors.white,
        backgroundColor: HexColor("#425C5A"),
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                child: SvgPicture.asset(
                  "assets/background_rent_apply.svg",
                  fit: BoxFit.fill,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: 300.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 20.h, bottom: 0.h, left: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          widget.itemIcon,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 11.w),
                        Text(
                          widget.categoryKr.toString(),
                          style: TextStyle(
                              fontSize: 21.sp, fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    DottedLineWidget(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "기간",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 17.5.sp,
                        fontWeight: FontWeight.w400,
                        color: HexColor("#425c5a")),
                  ),
                ),
                _selectedDateRange == null
                    ? Container(
                        padding: EdgeInsets.only(left: 30.w),
                        child: Row(children: [
                          Text('0000.00.00 ~ 0000.00.00',
                              style: TextStyle(fontSize: 17.5.sp)),
                          SizedBox(
                            width: 12.w,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final DateTimeRange? result =
                                  await showDateRangePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030, 12, 31),
                                currentDate: DateTime.now(),
                                saveText: '확인',
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: HexColor("#425C5A"),
                                        onPrimary: HexColor("#f3f3f3"),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (result != null) {
                                setState(() {
                                  _selectedDateRange = result;
                                });
                              }
                            },
                            child: Icon(
                              Icons.date_range,
                              size: 22,
                              color: HexColor("#425c5a"),
                            ),
                          )
                        ]))
                    : Padding(
                        padding: EdgeInsets.only(top: 0.h, left: 30.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_selectedDateRange?.start.toString().split(' ')[0]}",
                              style: TextStyle(fontSize: 17.5.sp),
                            ),
                            Text(" ~ ", style: TextStyle(fontSize: 17.5.sp)),
                            Text(
                                "${_selectedDateRange?.end.toString().split(' ')[0]}",
                                style: TextStyle(fontSize: 17.5.sp)),
                          ],
                        )),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: RentCustomTextField(
                      label: "목적",
                      labelHint: '물품 대여 목적을 적어주세요.',
                      controller: rentPurposeController,
                      isObscure: false,
                      inputType: TextInputType.text),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: RentCustomTextField(
                    label: "수량",
                    labelHint: '대여할 물품의 수량을 적어주세요.',
                    controller: rentAmountController,
                    isObscure: false,
                    inputType: TextInputType.number,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.w, top: 10.h),
                  child: Text(
                    "주의사항",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: HexColor("#425c5a"), fontWeight: FontWeight.w400, fontSize: 17.5.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30.w),
                  width: 300.w,
                  height: 150.h,
                  padding: EdgeInsets.only(top: 8.h, left: 12.w, right: 10.w, bottom: 8.h),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.2,
                        color: HexColor("#425c5a")
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: SingleChildScrollView(
                      child: Text(
                          getPolicyTextFromCategory(widget.categoryEng),
                          style: TextStyle(fontSize: 15.5.sp, height: 1.4, fontWeight: FontWeight.w400),
                        ))
                ),
                Container(
                  margin: EdgeInsets.only(right: 30.w),
                  child : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("주의사항을 숙지하였습니다. ",
                              style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w400)),
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: Checkbox(
                            shape: const CircleBorder(),
                            side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                  width: 1.5, color: HexColor("#EE795F")),
                            ),
                            value: agreementCheckBoxState,
                            checkColor: HexColor("#EE795F"),
                            activeColor: Colors.transparent,
                            onChanged: (value) {
                              setState(() {
                                agreementCheckBoxState = value!;
                              });
                            }),
                      ),
                    ],
                  ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    DottedLineWidget(),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    if (!agreementCheckBoxState) {
                      return;
                    }

                    if (rentPurposeController.text.isEmpty ||
                        rentAmountController.text.isEmpty ||
                        widget.categoryKr.isEmpty ||
                        _selectedDateRange == null) {
                      Common.showSnackBar(context, "비어있는 필드가 있는지 확인해주세요.");
                      return;
                    }

                    setState(() {
                      isLoading = true;
                    });

                    final authTokenAndReIssueResult =
                        await Auth.authTokenAndReIssue();
                    if (authTokenAndReIssueResult != StatusCode.SUCCESS) {
                      Common.setIsLogin(false);
                      await Common.setNonLogin(false);
                      await Common.setAutoLogin(false);
                      await Common.clearStudentInfoPref();
                      if (mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                        Common.showSnackBar(context, "다시 로그인해주세요.");
                        setState(() {
                          isLoading = false;
                        });
                        return;
                      }
                      Common.showSnackBar(context, "다시 로그인해주세요.");
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }

                    Map bodyData = {
                      "purpose": rentPurposeController.text,
                      "account": int.parse(rentAmountController.text),
                      "itemCategory": widget.categoryEng,
                      "startTime":
                          "${_selectedDateRange?.start.toString().split(' ')[0]}",
                      "endTime":
                          "${_selectedDateRange?.end.toString().split(' ')[0]}"
                    };

                    final AT =
                        await Auth.secureStorage.read(key: "ACCESS_TOKEN");

                    try {
                      final resString = await http
                          .post(
                              Uri.parse(
                                  "${dotenv.get("DEV_API_BASE_URL")}/rent"),
                              headers: {
                                "Authorization": "Bearer $AT",
                                "Content-Type": "application/json"
                              },
                              body: json.encode(bodyData))
                          .timeout(const Duration(seconds: 30));
                      Map<String, dynamic> resData =
                          jsonDecode(utf8.decode(resString.bodyBytes));
                      var data = resData["status"];

                      if (data == 200) {
                        setState(() {
                          isLoading = false;
                        });
                        int count = 0;
                        if (!mounted) return;
                        Navigator.of(context).popUntil((_) => count++ >= 2);
                        Common.showSnackBar(context, "신청이 완료되었습니다.");
                        return;
                      }

                      if (data == 409) {
                        setState(() {
                          isLoading = false;
                        });
                        if (!mounted) return;
                        Common.showSnackBar(context, "신청 정보를 확인해주세요.");
                        return;
                      }

                      setState(() {
                        isLoading = false;
                      });
                      if (!mounted) return;
                      Common.showSnackBar(context, "오류가 발생했습니다.");
                      return;
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      if (!mounted) return;
                      Common.showSnackBar(context, "오류가 발생했습니다.");
                      return;
                    }
                  },
                  child: agreementCheckBoxState == true
                      ? Container(
                          width: 290.w,
                          height: 44.h,
                          margin: EdgeInsets.only(
                              left: 35.w, right: 35.w, bottom: 20.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: HexColor("#EE795F"),
                              borderRadius: BorderRadius.circular(25)),
                          child: isLoading
                              ? Text(
                                  "신청중입니다...",
                                  style: TextStyle(
                                      color: HexColor("#F3F3F3"),
                                      fontSize: 21.5.sp,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  "신청하기",
                                  style: TextStyle(
                                      color: HexColor("#F3F3F3"),
                                      fontSize: 21.5.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                        )
                      : Container(
                          width: 290.w,
                          height: 44.h,
                          margin: EdgeInsets.only(
                              left: 35.w, right: 35.w, bottom: 20.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: HexColor("#EE795F").withOpacity(0.6),
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            "신청하기",
                            style: TextStyle(
                                color: HexColor("#F3F3F3"),
                                fontSize: 21.5.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor("#425c5a"),
    );
  }

  String getPolicyTextFromCategory(String category) {
    switch (category) {
      case "CANOPY":
        return "1. 캐노피를 설치하거나 기둥 높이를 조절할 때에는 여럿이서 작업해야 합니다.\n2. 운반 시에 끌지 않고 들어서 이동시켜야 합니다.\n3. 캐노피를 경사면에 설치하지 않도록 해주세요.";
      case "TABLE":
        return "1. 듀라테이블을 조립하거나 정리할 때, 테이블 다리 접합부 또는 관절 부분에 손이 끼이지 않도록 주의해 주세요.";
      case "AMP":
        return "1. 엠프에 물이 들어가지 않도록 해야 합니다.\n2. 다른 장비를 연결한 뒤에 엠프의 전원을 켜주세요.\n3. 사용 후에는 볼륨노브를 0으로 설정한 뒤 엠프의 전원을 끄고 장비를 분리해주세요.";
      case "WIRE":
        return "1. 선을 말아서 정리할 때, 릴의 한쪽으로 선이 치우치지 않도록 해주세요.\n2. 리드선을 모두 풀어서 사용해야 부하를 최소화할 수 있습니다.";
      case "CART":
        return "1. 바퀴가 고장나지 않도록 조심히 다뤄 주세요.\n2. 카트를 끌 때, 사람이 올라 타지 않도록 해야 합니다.";
      default:
        return "1. 의자를 포개서 정리할 때, 의자 사이에 손이 끼이지 않도록 주의해 주세요.\n2. 의자 위에 무거운 물건을 올리지 말아 주세요.";
    }
  }
}
