import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../../utils/common.dart';
import '../../../../../widgets/rent_custom_text_field.dart';
import 'dotted_line_widget.dart';


class RentApplyScreen extends StatefulWidget {
  const RentApplyScreen({Key? key}) : super(key: key);

  @override
  State<RentApplyScreen> createState() => _RentApplyScreenState();
}

class _RentApplyScreenState extends State<RentApplyScreen> {

  DateTimeRange? _selectedDateRange;
  bool agreementCheckBoxState = false;

  void _show() async {
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

  @override
  Widget build(BuildContext context) {

    final rentpurposeControlloer = TextEditingController();
    final rentamountControlloer = TextEditingController();

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
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
              child: SvgPicture.asset(
                "assets/background_rent_apply.svg",
                fit: BoxFit.fill,
              )),
          SingleChildScrollView(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 312.w,
                height: 40.h,
                margin: EdgeInsets.only(top: 33.h, bottom: 7.5.h, left: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icon_amp_green.svg",
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 11.w),
                      Text("앰프&마이크", style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w600),)
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  DottedLineWidget(),
                ],
              ),
              SizedBox(height: 10.h),
              Padding(padding: EdgeInsets.only(top: 10.5.h, left: 30.w), child: Text("기간", textAlign: TextAlign.left, style: TextStyle(fontSize: 21.5.sp, fontWeight: FontWeight.w400),),),
              _selectedDateRange == null
                  ? Container(
                padding: EdgeInsets.only(top: 2.h, left: 30.w),
                child: Row(
                  children:[
                  Text('0000.00.00 ~ 0000.00.00', style: TextStyle(fontSize: 17.5.sp)),
                  TextButton(onPressed: () {_show();}, child: Icon(Icons.date_range, size: 17.5.h,)),
                ])
              )
                  : Padding(
                      padding: EdgeInsets.only(top: 2.h, left: 30.w),
                      child:Row(
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
              Padding(padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: RentCustomTextField(
                    label: "목적",
                    labelHint: '물품 대여 목적을 적어주세요.',
                    controller: rentpurposeControlloer,
                    isObscure: false,
                      inputType: TextInputType.text
                  ),
              ),
              Padding(padding: EdgeInsets.only(top: 14.h, left: 30.w, right: 30.w),
                child: RentCustomTextField(
                  label: "수량",
                  labelHint: '대여할 물품의 수량을 적어주세요.',
                  controller: rentamountControlloer,
                  isObscure: false,
                  inputType: TextInputType.number,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 14.h, left: 30.w), child: Text("이용약관", textAlign: TextAlign.left, style: TextStyle(fontSize: 21.5.sp, fontWeight: FontWeight.w400),),),
              Container(
                margin: EdgeInsets.only(left: 30.w),
                width: 300.w,
                height: 150.0.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0)
                  )
                ),
                child: Column(
                  children: [
                Padding(padding: EdgeInsets.only(top: 8.h), child: Text("상시사업 물품 대여 약관", )),
                    SizedBox(height: 85.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("동의합니다", style: TextStyle(fontSize: 10.sp)),
                        Checkbox(shape:CircleBorder(), side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(width: 1.5, color: HexColor("#EE795F")),
                        ),value: agreementCheckBoxState, checkColor: HexColor("#EE795F"), activeColor: Colors.transparent, onChanged: (value) {
                          setState((){
                            agreementCheckBoxState = value!;
                          });
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 17.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  DottedLineWidget(),
                ],
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RentApplyScreen()))
                },
                child: Container(
                  width: 290.w,
                  height: 44.h,
                  margin: EdgeInsets.only(top:10.h, left:35.w, right: 35.w, bottom: 10.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HexColor("#EE795F"),
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    "신청하기",
                    style: TextStyle(
                        color: HexColor("#F3F3F3"), fontSize: 21.5.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
      backgroundColor: HexColor("#425c5a"),
    );
  }
}
