import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../utils/common.dart';
import '../../../../../widgets/rent_custom_text_field.dart';
import 'dotted_line_widget.dart';

class RentApplyScreen extends StatefulWidget {
  RentApplyScreen({Key? key, required this.category, required this.itemIcon})
      : super(key: key);

  String category;
  String itemIcon;

  @override
  State<RentApplyScreen> createState() => _RentApplyScreenState();
}

class _RentApplyScreenState extends State<RentApplyScreen> {
  DateTimeRange? _selectedDateRange;
  bool agreementCheckBoxState = false;
  final rentPurposeController = TextEditingController();
  final rentAmountController = TextEditingController();

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
                          widget.category.toString(),
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
                            onTap: () {
                              _showDateRangePicker();
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
                  child: Container(
                    child: RentCustomTextField(
                      label: "수량",
                      labelHint: '대여할 물품의 수량을 적어주세요.',
                      controller: rentAmountController,
                      isObscure: false,
                      inputType: TextInputType.number,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "이용약관",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30.w),
                  width: 300.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Stack(children: [
                    Padding(
                        padding: EdgeInsets.only(top: 8.h, left: 8.w),
                        child: Text(
                          "1. 물 묻히지 마세요\n2. 조심히 다뤄주세요\n3. TF팀 화이팅",
                        )),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              height: 32.h,
                              alignment: Alignment.center,
                              child: Text("동의합니다",
                                  style: TextStyle(fontSize: 10.sp))),
                          Container(
                            width: 32.w,
                            height: 32.h,
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
                      ),
                    ),
                  ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    DottedLineWidget(),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 290.w,
                    height: 44.h,
                    margin:
                        EdgeInsets.only(left: 35.w, right: 35.w, bottom: 20.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: HexColor("#EE795F"),
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
      resizeToAvoidBottomInset : false,
      backgroundColor: HexColor("#425c5a"),
    );
  }

  void _showDateRangePicker() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      print(result.start.toString());
      setState(() {
        _selectedDateRange = result;
      });
    }
  }
}
