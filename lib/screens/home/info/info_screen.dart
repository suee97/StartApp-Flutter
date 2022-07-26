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
              //탭
        Padding(
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
                    this.changeVisible1();
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
                    this.changeVisible2();
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
                    this.changeVisible3();
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
      ),
              //TabCollection(),
              Stack(
                children: [
                  Visibility(child: AboutChongHak(), visible: _isvisible1, ),
                  Visibility(child: FAQ(), visible: _isvisible2, ),
                  Visibility(child: ChongHakFunction(), visible: _isvisible3, ),
                ],
              )
            ]),
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

class TabCollection extends StatelessWidget {
  const TabCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("hello");
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
                  Image(image: AssetImage('images/STArt_organization.png')), //SvgPicture.asset("assets/STart_organization.svg"),
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
              "A. 자치회비는 매학기 등록금 납부기간에 가상계좌를 통해 납부하실 수 있습니다. 고지서에 기재된 등록금에 11,000원을 추가한 금액을 입금하면 자동으로 자치회비 납부처리가 됩니다. 세부사항은 등록금 고지서를 통해 확인하실 수 있습니다. 또한 등록금 납부기간에 기재된 학생처나 총학생회 번호(02-970-7011)로 연락주시면 자세한 설명을 들으실 수 있습니다."),
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
            SizedBox(
              height: 10.h,
            ),
            Text("중앙집행국",
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700)),
            Text("총학생회장, 부총학생회장, 집행위원장, 각 집행국(부·차)장과 국원으로 구성되며 본회의 최고집행기구이다."),
            SizedBox(
              height: 10.h,
            ),
            Text("단과대학 학생회",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700)),
            Text("단과대학 학생회는 각 단과대학의 최고 자치기구로, 단과대학 학생회는 각 단과대학의 모든 회원으로 구성하며, 단과대학의 최고집행기구이다."),
            SizedBox(
              height: 10.h,
            ),
            Text("학과 학생회",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700)),
            Text("학과 학생회는 본회의 기초자치기구이자 각 학과의 최고 자치기구로, 학과 학생회는 각 학과의 모든 회원으로 구성하며, 학과의 최고집행기구이다."),
            SizedBox(
              height: 10.h,
            ),
            Text("동아리연합회",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700)),
            Text("동아리연합회에서 등록된 정규동아리들의 연합체인 동아리연합회는 전 동아리의 민주적 자치를 위한 대표기구이다. 동아리연합회의 으뜸빛, 버금빛을 동아리연합회 내에서 선거로 선출하며 동아리 으뜸빛은 전 동아리인들을 대표하여 동아리의 자치적 활동에 필요한 제반 업무를 담당한다."),
            SizedBox(
              height: 10.h,
            ),
            Text("학생복지위원회",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700)),
            Text("학생복지위원회 위원장과 부위원장은 반대표(각 학과, 각반) 이상 직선 대표자들에 의해 선출된다. 본회 회원들의 복지 향상을 위한 자율적 활동에 필요한 제반 사항은 학생복지위원회의 자치회칙에 따른다."),
            SizedBox(
              height: 10.h,
            ),
        ]
      ),
      )
    );
  }
}

