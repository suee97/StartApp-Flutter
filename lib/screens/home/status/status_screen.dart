import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_app/utils/common.dart';
import 'package:http/http.dart' as http;
import 'package:start_app/utils/departmentST.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

  String _name = '';
  String _studentNo = '';
  String _studentGroup = '';
  String _department = '';
  bool _membership = false;
  String membership = '';

  @override
  void initState() {
    super.initState();
    _loadStudentInfo();
  }

  _loadStudentInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() async {
      _name = (prefs.getString('appName') ?? '로그인이 필요한 정보입니다.');
      _studentNo = (prefs.getString('appStudentNo') ?? '');
      _department = (prefs.getString('department') ?? '');
      _studentGroup = DepartmentST.getDepartment(_department);
      _membership = (prefs.getBool('appMemberShip') ?? false);
      if (_membership) {
            setState((){
          membership = "학생회비 납부";
        });
      } else {
        setState(() {
          membership = "학생회비 미납부";
        });
      }

      if(!Common.getIsLogin()){
        setState(() {
          membership = "";
        });
      }
    });
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "재학생 확인 및 자치회비 납부 확인",
          style: Common.startAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: HexColor("#f3f3f3"),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
          child: statusCard(
              _name, _studentNo, _studentGroup, _department, membership)),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  Widget statusCard(String isPaid, String name, String studentNo, String group,
      String department) {
    return Container(
        width: 320.w,
        height: 550.h,
        color: Colors.transparent,
        child: Stack(
          children: [
            isPaid == "학생회비 납부자"
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image(
                        image: AssetImage("images/card_payer.png"),
                        width: 320.w,
                        height: 550.h,
                        fit: BoxFit.fill),
                    alignment: Alignment(0.0, 0.0),
                  )
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image(
                        image: AssetImage("images/card_unpaid.png"),
                        width: 320.w,
                        height: 550.h,
                        fit: BoxFit.fill),
                    alignment: Alignment(0.0, 0.0)),
            Column(
              children: [
                SizedBox(
                  height: 366.h,
                ),
                Container(
                  width: 320.w,
                  height: 184.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  padding: EdgeInsets.only(top: 27.h, left: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isPaid,
                        style: TextStyle(
                            fontSize: 21.5.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 15.5.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        studentNo,
                        style: TextStyle(fontSize: 13.5.sp),
                      ),
                      Text(
                        group,
                        style: TextStyle(fontSize: 13.5.sp),
                      ),
                      Text(
                        department,
                        style: TextStyle(fontSize: 13.5.sp),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
