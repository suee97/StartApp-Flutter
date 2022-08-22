import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_app/screens/home/rent/detail/category_rent_screen.dart';
import 'package:start_app/screens/home/rent/my_rent/my_rent_screen.dart';
import 'package:start_app/screens/home/rent/rent_widget.dart';
import '../../../utils/common.dart';
import '../../../utils/department_match.dart';
import '../../../widgets/start_android_dialog.dart';
import '../../login/login_screen.dart';

class RentScreen extends StatefulWidget {
  const RentScreen({Key? key}) : super(key: key);

  @override
  State<RentScreen> createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  String _name = '';
  String _studentNo = '';
  String _studentGroup = '';
  String _department = '';
  String selectedItem = "";

  @override
  void initState() {
    super.initState();
    _loadStudentInfo();
  }

  _loadStudentInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = (prefs.getString('appName') ?? '로그인이 필요합니다.');
      _studentNo = (prefs.getString('appStudentNo') ?? '');
      _department = (prefs.getString('department') ?? '');
      _studentGroup = DepartmentMatch.getDepartment(_department);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> rentScreenList = [
      CategoryRentScreen(
        categoryKr: "캐노피",
        categoryEng: "canopy",
        itemIcon: "assets/icon_canopy_green.svg",
        itemImg: "images/rent_canopy_img.jpg",
        itemPurpose: "기둥과 천막으로 부스를 만들 수 있습니다.",
        itemWarning: "천막이 찢어지지 않도록 주의해주세요.",
      ),
      CategoryRentScreen(
        categoryKr: "듀라테이블",
        categoryEng: "table",
        itemIcon: "assets/icon_table_green.svg",
        itemImg: "images/rent_table_img.jpg",
        itemPurpose: "간이 테이블로 사용할 수 있습니다.",
        itemWarning: "테이블을 깨끗하게 닦아주세요.",
      ),
      CategoryRentScreen(
        categoryKr: "앰프&마이크",
        categoryEng: "amp",
        itemIcon: "assets/icon_amp_green.svg",
        itemImg: "images/rent_amp_img.jpg",
        itemPurpose: "행사 시에 큰 음향을 낼 수 있습니다.",
        itemWarning: "비 또는 모레 등의 이물질이 들어가지 않도록 해주세요.",
      ),
      CategoryRentScreen(
        categoryKr: "리드선",
        categoryEng: "wire",
        itemIcon: "assets/icon_wire_green.svg",
        itemImg: "images/rent_wire_img.jpg",
        itemPurpose: "콘센트를 연장하여 사용할 수 있습니다.",
        itemWarning: "비에 젖지 않도록 해주세요.",
      ),
      CategoryRentScreen(
          categoryKr: "엘카",
          categoryEng: "cart",
          itemIcon: "assets/icon_cart_green.svg",
          itemImg: "images/rent_cart_img.jpg",
          itemPurpose: "여러 짐을 한 번에 옮길 수 있습니다.",
          itemWarning: "바퀴가 고장나지 않도록 주의 해주세요."),
      CategoryRentScreen(
          categoryKr: "의자",
          categoryEng: "chair",
          itemIcon: "assets/icon_chair_green.svg",
          itemImg: "images/rent_chair_img.jpg",
          itemPurpose: "외부 행사 시에 간이 의자로 활용할 수 있습니다.",
          itemWarning: "부서지지 않도록 주의 해주세요.")
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "상시사업 예약",
          style: Common.startAppBarTextStyle,
        ),
        backgroundColor: HexColor("#f3f3f3"),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: 55.h),
          decoration: BoxDecoration(
              color: HexColor("#425C5A"),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Column(
            children: [
              SizedBox(
                height: 76.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RentWidget(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => rentScreenList[0]));
                    },
                    title: "캐노피",
                    svgPath: "assets/icon_canopy.svg",
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  RentWidget(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => rentScreenList[1]));
                    },
                    title: "듀라테이블",
                    svgPath: "assets/icon_table.svg",
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  RentWidget(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => rentScreenList[2]));
                    },
                    title: "앰프&마이크",
                    svgPath: "assets/icon_amp.svg",
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RentWidget(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => rentScreenList[3]));
                    },
                    title: "리드선",
                    svgPath: "assets/icon_wire.svg",
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  RentWidget(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => rentScreenList[4]));
                    },
                    title: "엘카",
                    svgPath: "assets/icon_cart.svg",
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  RentWidget(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => rentScreenList[5]));
                    },
                    title: "의자",
                    svgPath: "assets/icon_chair.svg",
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "안내사항",
                      style: TextStyle(
                          fontSize: 17.5.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      "- 대여 물품이 파손되었을 시, 수리 비용의 80%를 대여인(또는 대여 기구) 측에서 비용하고 나머지 20%는 총학생회 자치회비에서 부담한다.",
                      style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7)),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "- 파손에 대해 수리가 불가하다고 판단될 시, 대여인(또는 대여 기구)에서 같은 제품 또는 그에 걸맞는 비용을 부담하여아 한다.",
                      style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7)),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: 110.w,
          height: 110.w,
          margin: EdgeInsets.only(left: 38.w),
          decoration: BoxDecoration(
              color: HexColor("#425c5a"),
              shape: BoxShape.circle,
              border: Border.all(width: 9.w, color: HexColor("#425C5A"))),
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: SvgPicture.asset(
                "assets/icon_rent_person.svg",
                color: HexColor("#425C5A"),
                fit: BoxFit.fill,
              )),
        ),
        Common.getIsLogin()
            ? Container(
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
                              color: HexColor("#425C5A"),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyRentScreen()));
                          },
                          child: Container(
                            width: 100.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                                color: HexColor("#FFCEA2"),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "내 예약 확인하기",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: HexColor("#425C5A"),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    userInfoText(_studentNo),
                    userInfoText(_studentGroup),
                    userInfoText(_department),
                  ],
                ),
              )
            : Container(
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
                              color: HexColor("#425C5A"),
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Platform.isIOS) {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  content:
                                      const Text("확인을 누르면 로그인 화면으로 이동합니다."),
                                  actions: [
                                    CupertinoDialogAction(
                                        isDefaultAction: false,
                                        child: const Text("확인"),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen()),
                                                  (route) => false);
                                        }),
                                    CupertinoDialogAction(
                                        isDefaultAction: false,
                                        child: const Text("취소"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StartAndroidDialog(
                                  title: "확인을 누르면 로그인 화면으로 이동합니다.",
                                  onOkPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                        (route) => false);
                                  },
                                  onCancelPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                              });
                        }
                      },
                      child: Container(
                        width: 100.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                            color: HexColor("#FFCEA2"),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "로그인 하기",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: HexColor("#425C5A"),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
      ]),
      backgroundColor: HexColor("#f3f3f3"),
    );
  }

  Widget userInfoText(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white, fontSize: 13.5.sp, fontWeight: FontWeight.w500),
    );
  }
}
