import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_app/screens/home/rent/my_rent/rent_tile.dart';
import 'package:http/http.dart' as http;
import 'package:start_app/screens/login/login_screen.dart';
import 'dart:io' show Platform;
import '../../../../models/rent.dart';
import '../../../../models/status_code.dart';
import '../../../../utils/auth.dart';
import '../../../../utils/common.dart';
import '../../../../utils/department_match.dart';

class MyRentScreen extends StatefulWidget {
  const MyRentScreen({Key? key}) : super(key: key);

  @override
  State<MyRentScreen> createState() => _MyRentScreenState();
}

class _MyRentScreenState extends State<MyRentScreen> {
  final secureStorage = const FlutterSecureStorage();

  String _name = '';
  String _studentNo = '';
  String _studentGroup = '';
  String _department = '';

  List<Rent> rentList = [];
  bool isLoading = true;

  @override
  void initState() {
    fetchMyRentList();
    _loadStudentInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "내 예약",
          style: Common.startAppBarTextStyle,
        ),
        backgroundColor: HexColor("#425C5A"),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(top: 55.h),
            decoration: BoxDecoration(
                color: HexColor("#f3f3f3"),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Container(
              padding: EdgeInsets.only(top: 72.h, left: 20.w, right: 20.w),
              child: Column(
                children: [rentListWidget()],
              ),
            )),
        Container(
          width: 110.w,
          height: 110.w,
          margin: EdgeInsets.only(left: 38.w),
          decoration: BoxDecoration(
              color: HexColor("#f3f3f3"),
              shape: BoxShape.circle,
              border: Border.all(width: 9.w, color: HexColor("#f3f3f3"))),
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: HexColor("#425C5A"), shape: BoxShape.circle),
              child: SvgPicture.asset(
                "assets/icon_rent_person.svg",
                color: HexColor("#f3f3f3"),
                fit: BoxFit.fill,
              )),
        ),
        Container(
          width: 170.w,
          height: 90.h,
          margin: EdgeInsets.only(left: 160.w, top: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _name,
                    style: TextStyle(
                        fontSize: 17.5.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              myUserInfoText(_studentNo),
              myUserInfoText(_studentGroup),
              myUserInfoText(_department),
            ],
          ),
        )
      ]),
      backgroundColor: HexColor("#425C5A"),
    );
  }

  _loadStudentInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = (prefs.getString('appName') ?? '로그인이 필요한 정보입니다.');
      _studentNo = (prefs.getString('appStudentNo') ?? '');
      _department = (prefs.getString('department') ?? '');
      _studentGroup = DepartmentMatch.getGroup(_department);
    });
  }

  Future<void> fetchMyRentList() async {
    setState(() {
      isLoading = true;
    });
    final authTokenAndReIssueResult = await Auth.authTokenAndReIssue();
    if (authTokenAndReIssueResult == StatusCode.UNCATCHED_ERROR) {
      setState(() {
        isLoading = false;
      });
      return Future.error("fetchRentList() call : Error");
    }

    if (authTokenAndReIssueResult == StatusCode.REFRESH_EXPIRED) {
      setState(() {
        isLoading = false;
      });
      if(mounted) {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => LoginScreen()), (
            route) => false);
      }

      return Future.error("fetchRentList() call : refresh token expired");
    }

    final AT = await Auth.secureStorage.read(key: "ACCESS_TOKEN");

    try {
      final resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/rent"), headers: {
        "Authorization": "Bearer $AT"
      }).timeout(const Duration(seconds: 30));
      Map<String, dynamic> resData =
      jsonDecode(utf8.decode(resString.bodyBytes));
      List<dynamic> data = resData["data"];
      print(data);

      List<Rent> _rentList = [];
      List<Rent> _tempList = [];
      for (var e in data) {
        if (e["rentStatus"] == "DENY") _rentList.add(Rent.fromJson(e));
      }
      for (var e in data) {
        if (e["rentStatus"] == "DONE") _tempList.add(Rent.fromJson(e));
      }
      for (var e in data) {
        if (e["rentStatus"] == "WAIT") _tempList.add(Rent.fromJson(e));
      }
      for (var e in data) {
        if (e["rentStatus"] == "CONFIRM") _tempList.add(Rent.fromJson(e));
      }

      setState(() {
        rentList = _rentList + _tempList.reversed.toList();
      });

      for (var e in data) {
        if (e["rentStatus"] == "RENT") _rentList.add(Rent.fromJson(e));
      }

      for (var e in _rentList) {
        print(e.itemCategory);
      }
    } catch (e) {
      print(e);
      return;
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget myUserInfoText(String title) {
    return Text(
      title,
      style: TextStyle(
          color: HexColor("#5C7775"),
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w500),
    );
  }

  Widget ErrorWidget() {
    return Column(
      children: [
        SizedBox(
          height: 120.h,
        ),
        Container(
          width: 132.w,
          child: Image(
            fit: BoxFit.fitWidth,
            image: const AssetImage("images/logo_crying_ready.png"),
            color: Colors.white.withOpacity(0.5),
            colorBlendMode: BlendMode.modulate,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          "예약 정보를 불러오지 못했습니다.",
          style: TextStyle(
              fontSize: 20.sp,
              color: const Color.fromARGB(128, 216, 232, 231),
              fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget rentListWidget() {
    if (isLoading) {
      if (Platform.isIOS) {
        return Column(
          children: [
            SizedBox(
              height: 160.h,
            ),
            const CupertinoActivityIndicator(
              radius: 12,
            ),
          ],
        );
      } else {
        return Column(
          children: [
            SizedBox(
              height: 160.h,
            ),
            Center(
              child: CircularProgressIndicator(
                color: HexColor("#425C5A"),
              ),
            ),
          ],
        );
      }
    }
    if (rentList.isEmpty) {
      return Column(
        children: [
          SizedBox(
            height: 120.h,
          ),
          Container(
            width: 150.w,
            child: Image(
              fit: BoxFit.fitWidth,
              image: const AssetImage("images/logo_crying_ready.png"),
              color: Colors.white.withOpacity(0.8),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            "예약 정보가 없거나\n불러오지 못했습니다.",
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black.withOpacity(0.2),
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: rentList.length,
        itemBuilder: (context, index) {
          return RentTile(rent: rentList[index], onPressed: () => {});
        },
      ),
    );
  }
}
