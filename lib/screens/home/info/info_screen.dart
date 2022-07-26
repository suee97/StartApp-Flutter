import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/screens/home/info/clip_rect.dart';
import '../../../utils/common.dart';

bool _isvisible1 = true;
bool _isvisible2 = false;
bool _isvisible3 = false;

class InfoScreen extends StatelessWidget {

  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: HexColor("#425C5A"),
      appBar: AppBar(
        title: const Text(
          "총학생회 설명",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        foregroundColor: Colors.white,
        backgroundColor: HexColor("#425C5A"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: Column(
            children: [
              TabCollection(),
              Stack(
                children: [
                  Visibility(child: AboutChongHak(), visible: _isvisible1, ),
                  // InfoTextColumn(),
                  Visibility(child: FAQ(), visible: _isvisible2, ),
                  Visibility(child: ChongHakFunction(), visible: _isvisible3, ),
                ],
              )
            ]),
      ),
    );
  }
}

class TabCollection extends StatelessWidget {
  const TabCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child:
          Row(
            children: [
              //탭1
              Container(
                width: 97.w,
                decoration: BoxDecoration(
                  color: HexColor("#FFFFFF"),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                    bottom: Radius.circular(0)),
                ),
                child: TextButton(
                  onPressed: (){
                        _isvisible1 = true;
                        _isvisible2 = false;
                        _isvisible3 = false;
                  },
                    child: Text('총학생회란?', style: TextStyle(color:Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w700),),
                  style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                ),
                padding: EdgeInsets.all(12),
              ),
              //탭2
              Container(
                width: 97.w,
                decoration: BoxDecoration(
                  color: HexColor("#B2BFB6"),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                      bottom: Radius.circular(0)),
                ),
                child: TextButton(
                    onPressed: (){

                        _isvisible1 = false;
                        _isvisible2 = true;
                        _isvisible3 = false;

                    },
                    child: Text('FAQ', style: TextStyle(color:Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w700),),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                ),
                padding: EdgeInsets.all(12),
              ),
              //탭3
              Container(
                decoration: BoxDecoration(
                  color: HexColor("#D9D9D9"),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                      bottom: Radius.circular(0)),
                ),
                child: TextButton(
                    onPressed: (){
                        _isvisible1 = false;
                        _isvisible2 = false;
                        _isvisible3 = true;
                    },
                    child: Text('학생회 구성 및 기능', style: TextStyle(color:Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w700),),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                ),
                padding: EdgeInsets.all(12),
              )
            ],
          ),
  );
  }
}

class AboutChongHak extends StatelessWidget {
  const AboutChongHak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child:
          Container(
                width: double.infinity, //MediaQuery.of(context).size.width
                height: 900.h,
              color: HexColor("#FFFFFF"),
              padding: EdgeInsets.all(10),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(Common.whatIsChongHak,),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    "총학생회 조직도",
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  SvgPicture.asset("assets/STart_organization.svg"),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    "ST’art 총학생회",
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    Common.stArt,
                  ),
                ],
              ),
            ),
    );
  }
}

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child:
      Container(
        width: double.infinity, //MediaQuery.of(context).size.width
        height: 900.h,
        color: HexColor("#B2BFB6"),
        padding: EdgeInsets.all(10),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Text("Q. 자치회비 납부는 언제 하는 건가요?",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700)),
            SizedBox(
              height: 7.h,
            ),
            Text(
              "A. 있어요."),
          ],
        ),
      ),
    );
  }
}

class ChongHakFunction extends StatelessWidget {
  const ChongHakFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child:
      Container(
        width: double.infinity, //MediaQuery.of(context).size.width
        height: 900.h,
        color: HexColor("#D9D9D9"),
        padding: EdgeInsets.all(10),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Text("   총학생회(본회)는 산하에 중앙집행국, 단과대학학생회, 과학생회, 동아리연합회, 학생복지위원회, 교지편집위원회 러비, 총졸업준비위원회, 학생인권위원회, 재정감사위원회를 둔다."),
            SizedBox(
              height: 10.h,
            ),
            Text("학생자치기구",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700)),
            ],
        ),
      ),
    );
  }
}

