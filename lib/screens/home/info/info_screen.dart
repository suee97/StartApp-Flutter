import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../utils/common.dart';

class InfoScreen extends StatefulWidget {

  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();

}

class _InfoScreenState extends State<InfoScreen> {

  bool _isvisible1 = true;
  bool _isvisible2 = false;
  bool _isvisible3 = false;

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
        Row(
          children: [
            //탭1
            Container(
              width: MediaQuery.of(context).size.width * 0.32,
              decoration: BoxDecoration(
                color: HexColor("#FFFFFF"),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                    bottom: Radius.circular(0)),
              ),
              child: TextButton(
                  onPressed: (){
                    this.changeVisible1();
                  },
                  child: Text('총학생회란?', style: TextStyle(color:Colors.black, fontSize: 13.5.sp, fontWeight: FontWeight.w700),),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )
              ),
              padding: EdgeInsets.all(14),
            ),
            //탭2
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              decoration: BoxDecoration(
                color: HexColor("#B2BFB6"),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                    bottom: Radius.circular(0)),
              ),
              child: TextButton(
                  onPressed: (){
                    this.changeVisible2();
                  },
                  child: Text('FAQ', style: TextStyle(color:Colors.black, fontSize: 13.5.sp, fontWeight: FontWeight.w700),),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )
              ),
              padding: EdgeInsets.all(14),
            ),
            //탭3
            Container(
              width: MediaQuery.of(context).size.width * 0.38,
              decoration: BoxDecoration(
                color: HexColor("#D9D9D9"),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                    bottom: Radius.circular(0)),
              ),
              child: TextButton(
                  onPressed: (){
                    this.changeVisible3();
                  },
                  child: Text('학생회 구성 및 기능', style: TextStyle(color:Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w700),),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )
              ),
              padding: EdgeInsets.all(14),
            )],
            ),
          Stack(
            children: [
              Visibility(child: AboutChongHak(), visible: _isvisible1, ),
              Visibility(child: FAQ(), visible: _isvisible2, ),
              Visibility(child: ChongHakFunction(), visible: _isvisible3, ),
            ],
          )
        ],
        ),
      ),
    );
  }

  void changeVisible1() {
    setState(() {
      this._isvisible1 = true;
      this._isvisible2 = false;
      this._isvisible3 = false;
    });
  }

  void changeVisible2() {
    setState(() {
      this._isvisible1 = false;
      this._isvisible2 = true;
      this._isvisible3 = false;
    });
  }

  void changeVisible3() {
    setState(() {
      this._isvisible1 = false;
      this._isvisible2 = false;
      this._isvisible3 = true;
    });
  }
}

class AboutChongHak extends StatelessWidget {
  const AboutChongHak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                width: double.infinity, //MediaQuery.of(context).size.width
                height: 940.h,
              color: HexColor("#FFFFFF"),
              padding: EdgeInsets.only(top: 14, left: 20, right: 20),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Common.whatIsChongHak,
                    style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200),),
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "총학생회 조직도",
                        style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600),
                      ),
                      Image(image: AssetImage('images/STart_logo.png'))
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    alignment: Alignment(0.0, 0.0),
                    child:Image(image: AssetImage('images/STArt_organization.png')),), //SvgPicture.asset("assets/STart_organization.svg"),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "ST’art 총학생회",
                    style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 12.5.h,
                  ),
                  Text(
                    Common.stArt,
                    style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
    );
  }
}

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity, //MediaQuery.of(context).size.width
        height: 1000.h,
        color: HexColor("#B2BFB6"),
        padding: EdgeInsets.only(top: 14, left: 20, right: 20),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //컨테이너 재활용
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      Common.faq_q1,
                      style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 7.h),
                    Text(
                        Common.faq_a1,
                        style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
                  SizedBox(
                      height: 7.h),
                ],
              )
        ),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        Common.faq_q2,
                        style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
                    SizedBox(
                        height: 7.h),
                    Text(
                        Common.faq_a2,
                        style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
                    SizedBox(
                        height: 10.h),
                  ],
                )
            ),
    ],)
    );
  }
}

class ChongHakFunction extends StatelessWidget {
  const ChongHakFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity, //MediaQuery.of(context).size.width
        height: 800.h,
        color: HexColor("#D9D9D9"),
        padding: EdgeInsets.only(top: 14, left: 20, right: 20),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("  총학생회(본회)는 산하에 중앙집행국, 단과대학학생회, 과학생회, 동아리연합회, 학생복지위원회, 교지편집위원회 러비, 총졸업준비위원회, 학생인권위원회, 재정감사위원회를 둔다.",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("학생자치기구",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("중앙집행국",
            style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400)),
            Text("총학생회장, 부총학생회장, 집행위원장, 각 집행국(부·차)장과 국원으로 구성되며 본회의 최고집행기구이다.",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
            SizedBox(
              height: 10.h,
            ),
            Text("단과대학 학생회",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400)),
            Text("단과대학 학생회는 각 단과대학의 최고 자치기구로, 단과대학 학생회는 각 단과대학의 모든 회원으로 구성하며, 단과대학의 최고집행기구이다.",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("학과 학생회",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400)),
            Text("학과 학생회는 본회의 기초자치기구이자 각 학과의 최고 자치기구로, 학과 학생회는 각 학과의 모든 회원으로 구성하며, 학과의 최고집행기구이다.",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("동아리연합회",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400)),
            Text("동아리연합회에서 등록된 정규동아리들의 연합체인 동아리연합회는 전 동아리의 민주적 자치를 위한 대표기구이다. 동아리연합회의 으뜸빛, 버금빛을 동아리연합회 내에서 선거로 선출하며 동아리 으뜸빛은 전 동아리인들을 대표하여 동아리의 자치적 활동에 필요한 제반 업무를 담당한다.",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("학생복지위원회",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400)),
            Text("학생복지위원회 위원장과 부위원장은 반대표(각 학과, 각반) 이상 직선 대표자들에 의해 선출된다. 본회 회원들의 복지 향상을 위한 자율적 활동에 필요한 제반 사항은 학생복지위원회의 자치회칙에 따른다.",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("상설기구",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("교지편집위원회 러비",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400)),
            Text("총학생회 상설 특별기구로서 교지발간 등을 위한 제반업무를 담당하며 독자성과 전문성으로 편집권 및 예산집행의 자율권을 가진다.",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("정기특별기구",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("재정감사위원회",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400)),
            Text("학생들이 납부한 여러 종류의 자치회비를 사용하는 총학생회 산하의 과와 단과대학을 포함한 모든 기구들의 예·결산안을 대조하여 본회의 목적에 맞지 않게 사용되는 일을 감시하는 단체이다.",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("특별기구",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("학생인권위원회",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400)),
            Text("교내에서 일어나는 다양한 인권 관련 사건에 대해 학생들의 의견을 대표하고, 학생들의 인권의식 향상을 위해 노력하는 단체이다. 학생인권위원회의 활동에 필요한 제반 사항은 학생인권위원회의 자치회칙에 따른다.",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
            SizedBox(
              height: 12.5.h,
            ),
            Text("총졸업준비위원회",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w400)),
            Text("총졸업준비위원회는 졸업과 사회진출에 관한 업무를 관할하는 상설특별기구이며 회원이 될 자격은 본회의 각과 졸업준비위원장과 졸업이 가능한 본회의 회원으로 구성한다.",
                style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w200)),
          ]
      ),
    );
  }
}

