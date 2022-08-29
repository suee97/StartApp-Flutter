import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_app/utils/common.dart';
import 'package:start_app/utils/department_match.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  String name = '';
  String studentNo = '';
  String studentGroup = '';
  String department = '';
  bool membership = false;

  @override
  void initState() {
    _loadStudentInfo();
    super.initState();
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "자치회비 납부 확인",
          style: Common.startAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: HexColor("#f3f3f3"),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Common.getIsLogin() == true
          ? Center(
              child: statusCard(
                  true, name, studentNo, studentGroup, department, membership))
          : Center(child: statusCard(false, "", "", "", "", false)),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  Widget statusCard(bool isLogin, String name, String studentNo, String group,
      String department, bool membership) {
    return isLogin == true
        ? Container(
            width: 320.w,
            height: 550.h,
            child: Stack(
              children: [
                membership == true
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: const Alignment(0.0, 0.0),
                        child: Image(
                            image: const AssetImage("images/card_paid.png"),
                            width: 320.w,
                            height: 550.h,
                            fit: BoxFit.fill),
                      )
                    : Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: const Alignment(0.0, 0.0),
                        child: Image(
                            image: const AssetImage("images/card_unpaid.png"),
                            width: 320.w,
                            height: 550.h,
                            fit: BoxFit.fill)),
                Column(
                  children: [
                    SizedBox(
                      height: 356.h,
                    ),
                    Container(
                      width: 320.w,
                      height: 194.h,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      padding: EdgeInsets.only(top: 30.h, left: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            membership == true ? "자치회비 납부자" : "자치회비 미납부자",
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
            ))
        : Container(
            width: 320.w,
            height: 550.h,
            child: Stack(
              children: [
                membership == true
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: const Alignment(0.0, 0.0),
                        child: Image(
                            image: const AssetImage("images/card_paid.png"),
                            width: 320.w,
                            height: 550.h,
                            fit: BoxFit.fill),
                      )
                    : Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: const Alignment(0.0, 0.0),
                        child: Image(
                            image: const AssetImage("images/card_unpaid.png"),
                            width: 320.w,
                            height: 550.h,
                            fit: BoxFit.fill)),
                Column(
                  children: [
                    SizedBox(
                      height: 356.h,
                    ),
                    Container(
                      width: 320.w,
                      height: 194.h,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      padding: EdgeInsets.only(top: 30.h, left: 24.w),
                      child: Text(
                        "로그인이 필요합니다",
                        style: TextStyle(
                            fontSize: 21.5.sp, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )
              ],
            ));
  }

  Future<void> _loadStudentInfo() async {
    await _loadPrefs();
    final String _studentGroup = DepartmentMatch.getGroup(department);
    setState(() {
      studentGroup = _studentGroup;
    });
  }

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String _name = (prefs.getString('appName') ?? '');
    final String _studentNo = (prefs.getString('appStudentNo') ?? '');
    final String _department = (prefs.getString('department') ?? '');
    final bool _membership = (prefs.getBool('appMemberShip') ?? false);

    setState(() {
      name = _name;
      studentNo = _studentNo;
      department = _department;
      membership = _membership;
    });
  }
}
