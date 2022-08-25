import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';
import 'package:start_app/models/status_code.dart';
import 'package:start_app/screens/home/festival/new_festival/stamp_status_dialog.dart';
import 'package:start_app/screens/login/login_screen.dart';
import '../../../../utils/auth.dart';
import 'package:lottie/lottie.dart' as lottie;
import '../../../../utils/common.dart';
import 'dart:io' show Platform;
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:http/http.dart' as http;

class NewFestivalScreen extends StatefulWidget {
  const NewFestivalScreen({Key? key}) : super(key: key);

  @override
  State<NewFestivalScreen> createState() => _NewFestivalScreenState();
}

class _NewFestivalScreenState extends State<NewFestivalScreen> {
  final LatLng initialCameraPosition = const LatLng(37.6324657, 127.0776803);
  late GoogleMapController _controller;
  final Location _location = Location();
  final secureStorage = const FlutterSecureStorage();
  bool isGetGpsLoading = false;
  bool isLoading = false;
  int boundaryDistance = 2000;
  int alertLevel = 1;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    // _location.onLocationChanged.listen((location) {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markerList = {
      Marker(
        markerId: const MarkerId("exhibition"),
        position: const LatLng(37.6313962, 127.0767797),
        onTap: () async {
          await markerOnTap("exhibition");
        },
      ),
      Marker(
          markerId: MarkerId("fleamarket"),
          position: LatLng(37.6327762, 127.077273),
          onTap: () async {
            await markerOnTap("fleamarket");
          }),
      Marker(
          markerId: MarkerId("sangsang"),
          position: LatLng(37.63089, 127.0796858),
          onTap: () async {
            await markerOnTap("sangsang");
          }),
      Marker(
          markerId: MarkerId("bungeobang"),
          position: LatLng(37.6331603, 127.0785649),
          onTap: () async {
            await markerOnTap("bungeobang");
          }),
      Marker(
          markerId: MarkerId("ground"),
          position: LatLng(37.6297553, 127.0770174),
          onTap: () async {
            await markerOnTap("ground");
          }),
    };

    Set<Circle> circleList = {
      Circle(
          circleId: const CircleId("jeon-si"),
          center: const LatLng(37.6313962, 127.0767797),
          radius: Common.CIRCLE_RADIUS,
          fillColor: Colors.redAccent.withOpacity(0.2),
          strokeWidth: 2,
          strokeColor: Colors.redAccent),
      Circle(
          circleId: const CircleId("market"),
          center: const LatLng(37.6327762, 127.077273),
          radius: Common.CIRCLE_RADIUS,
          fillColor: Colors.redAccent.withOpacity(0.2),
          strokeWidth: 2,
          strokeColor: Colors.redAccent),
      Circle(
          circleId: const CircleId("sang-sang"),
          center: const LatLng(37.63089, 127.0796858),
          radius: Common.CIRCLE_RADIUS,
          fillColor: Colors.redAccent.withOpacity(0.2),
          strokeWidth: 2,
          strokeColor: Colors.redAccent),
      Circle(
          circleId: const CircleId("bung-uh"),
          center: const LatLng(37.6331603, 127.0785649),
          radius: Common.CIRCLE_RADIUS,
          fillColor: Colors.redAccent.withOpacity(0.2),
          strokeWidth: 2,
          strokeColor: Colors.redAccent),
      Circle(
          circleId: const CircleId("sand-undong"),
          center: const LatLng(37.6297553, 127.0770174),
          radius: Common.CIRCLE_RADIUS,
          fillColor: Colors.redAccent.withOpacity(0.2),
          strokeWidth: 2,
          strokeColor: Colors.redAccent),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "축제",
          style: Common.startAppBarTextStyle,
        ),
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#92AEAC"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: initialCameraPosition, zoom: 16.5),
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          markers: markerList,
          circles: circleList,
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: Platform.isIOS
                  ? EdgeInsets.all(8.w)
                  : EdgeInsets.only(bottom: 100.w, right: 8.w),
              child: Material(
                borderRadius: BorderRadius.circular(28.w),
                elevation: 8,
                child: CircleAvatar(
                  radius: 28.w,
                  backgroundColor: HexColor("#EE795F"),
                  foregroundColor: Colors.white,
                  child: IconButton(
                      iconSize: 28,
                      onPressed: () async {
                        if (await checkLocationPermission() == true) {
                          setState(() {
                            isGetGpsLoading = true;
                          });
                          var curLoc = await getCurrentLocationGps();
                          setState(() {
                            isGetGpsLoading = false;
                          });
                          _controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(
                                      curLoc.latitude!, curLoc.longitude!),
                                  zoom: 16.5)));
                        } else {
                          if (Platform.isIOS) {
                            showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: const Text("위치 서비스 사용"),
                                    content: const Text(
                                        "위치서비스를 사용할 수 없습니다.\n기기의 \"설정 > Start App > 위치\"에서\n위치서비스를 켜주세요."),
                                    actions: [
                                      CupertinoDialogAction(
                                          isDefaultAction: false,
                                          child: const Text("확인"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                      CupertinoDialogAction(
                                          isDefaultAction: false,
                                          child: const Text("설정으로 이동"),
                                          onPressed: () async {
                                            await AppSettings.openAppSettings();
                                          })
                                    ],
                                  );
                                });
                          } else {
                            Common.showSnackBar(context,
                                "위치서비스를 사용할 수 없습니다.\n기기의 설정에서 위치서비스를 켜주세요.");
                            return;
                          }
                        }
                      },
                      icon: isGetGpsLoading == false
                          ? Icon(Icons.gps_fixed)
                          : Icon(Icons.access_time)),
                ),
              ),
            )),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: SvgPicture.asset("assets/icon_check_stamp_status.svg"),
                ),
                onTap: () async {
                  if (!Common.getIsLogin()) {
                    Common.showSnackBar(
                        context, "로그인이 필요한 기능입니다. '설정 > 로그인 하기'에서 로그인해주세요.");
                    return;
                  }

                  final stampStatusWithErrorResult = await fetchStampStatus();

                  if (stampStatusWithErrorResult.isExpired) {
                    if (!mounted) return;
                    Common.showSnackBar(context, "다시 로그인해주세요.");
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                    return;
                  }

                  if (stampStatusWithErrorResult.isError) {
                    if (!mounted) return;
                    Common.showSnackBar(context, "에러가 발생했습니다.");
                    return;
                  }

                  if (!isAllClear(stampStatusWithErrorResult)) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StampStatusDialog(
                            stampStatusWithError: stampStatusWithErrorResult,
                          );
                        });
                    return;
                  }

                  if (isAllClear(stampStatusWithErrorResult) == true &&
                      stampStatusWithErrorResult.isPrized == false) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    showDialogContentFromLevel(alertLevel, () {
                                      setState(() {
                                        alertLevel = 2;
                                      });
                                    }, () {
                                      setState(() {
                                        alertLevel = 3;
                                      });
                                    }, () {
                                      setState(() {
                                        alertLevel = 4;
                                      });
                                    }, () {
                                      Navigator.pop(context);
                                    }),
                                  ],
                                ),
                                backgroundColor: HexColor("#F8EAE1"),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              );
                            },
                          );
                        });
                    return;
                  }

                  if (isAllClear(stampStatusWithErrorResult) == true &&
                      stampStatusWithErrorResult.isPrized == true) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    showDialogContentFromLevel(
                                        4, () {}, () {}, () {}, () {
                                      Navigator.pop(context);
                                    }),
                                  ],
                                ),
                                backgroundColor: HexColor("#F8EAE1"),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              );
                            },
                          );
                        });
                  }
                },
              ),
              GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: SvgPicture.asset("assets/icon_festival_info.svg"),
                  ),
                  onTap: () {})
            ],
          ),
        )
      ]),
    );
  }

  Future<bool> isStampable(String place) async {
    final curLoc = await getCurrentLocationGps();
    var distance;

    if (place == "exhibition") {
      distance = mp.SphericalUtil.computeDistanceBetween(
          mp.LatLng(curLoc.latitude!, curLoc.longitude!),
          mp.LatLng(37.6313962, 127.0767797));
    } else if (place == "fleamarket") {
      distance = mp.SphericalUtil.computeDistanceBetween(
          mp.LatLng(curLoc.latitude!, curLoc.longitude!),
          mp.LatLng(37.6327762, 127.077273));
    } else if (place == "sangsang") {
      distance = mp.SphericalUtil.computeDistanceBetween(
          mp.LatLng(curLoc.latitude!, curLoc.longitude!),
          mp.LatLng(37.63089, 127.0796858));
    } else if (place == "bungeobang") {
      distance = mp.SphericalUtil.computeDistanceBetween(
          mp.LatLng(curLoc.latitude!, curLoc.longitude!),
          mp.LatLng(37.6331603, 127.0785649));
    } else {
      // ground
      distance = mp.SphericalUtil.computeDistanceBetween(
          mp.LatLng(curLoc.latitude!, curLoc.longitude!),
          mp.LatLng(37.6297553, 127.0770174));
    }

    print("${place}와의 거리 : ${distance}");

    if (distance > boundaryDistance) {
      return false;
    }
    return true;
  }

  Future<StatusCode> stampPlace(String place) async {
    try {
      Map bodyData = {"target": place};
      final resString = await http
          .post(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/stamp"),
              headers: {
                "Authorization":
                    "Bearer ${await secureStorage.read(key: "ACCESS_TOKEN")}",
                "Content-Type": "application/json"
              },
              body: json.encode(bodyData))
          .timeout(const Duration(seconds: 30));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 409) {
        return StatusCode.REQUEST_ERROR;
      }

      if (resData["status"] != 200) {
        return StatusCode.UNCATCHED_ERROR;
      }

      return StatusCode.SUCCESS;
    } catch (e) {
      print(e);
      return StatusCode.UNCATCHED_ERROR;
    }
  }

  Future<LocationData> getCurrentLocationGps() async {
    var currentLocation = await Location().getLocation();
    print("currentLocation : ${currentLocation}");
    return currentLocation;
  }

  Future<bool> checkLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<StampStatusWithError> fetchStampStatus() async {
    print("fetchStampStatus() call");
    final authTokenAndReIssueResult = await Auth.authTokenAndReIssue();
    if (authTokenAndReIssueResult == StatusCode.REFRESH_EXPIRED) {
      return StampStatusWithError(
          false, false, false, false, false, false, true, true);
    }
    if (authTokenAndReIssueResult != StatusCode.SUCCESS) {
      return StampStatusWithError(
          false, false, false, false, false, false, true, false);
    }
    try {
      final resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/stamp"), headers: {
        "Authorization":
            "Bearer ${await secureStorage.read(key: "ACCESS_TOKEN")}"
      }).timeout(const Duration(seconds: 20));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] != 200) {
        return StampStatusWithError(
            false, false, false, false, false, false, true, false);
      }

      List<dynamic> data = resData["data"];
      final stampStatusWithError = StampStatusWithError(
          data[0]["exhibition"],
          data[0]["ground"],
          data[0]["fleamarket"],
          data[0]["bungeobang"],
          data[0]["sangsang"],
          data[0]["isPrized"],
          false,
          false);

      return stampStatusWithError;
    } catch (e) {
      return StampStatusWithError(
          false, false, false, false, false, false, true, false);
    }
  }

  bool isAllClear(StampStatusWithError stampStatusWithError) {
    if (stampStatusWithError.exhibition == true &&
        stampStatusWithError.ground == true &&
        stampStatusWithError.sangsang == true &&
        stampStatusWithError.fleamarket == true &&
        stampStatusWithError.bungeobang == true) {
      return true;
    }
    return false;
  }

  bool getFromStampStatus(
      StampStatusWithError stampStatusWithError, String place) {
    if (place == "exhibition") {
      return stampStatusWithError.exhibition;
    }
    if (place == "sangsang") {
      return stampStatusWithError.sangsang;
    }
    if (place == "bungeobang") {
      return stampStatusWithError.bungeobang;
    }
    if (place == "ground") {
      return stampStatusWithError.ground;
    }
    return stampStatusWithError.fleamarket;
  }

  Future<void> markerOnTap(String place) async {
    if (!Common.getIsLogin()) {
      Common.showSnackBar(context, "로그인이 필요한 기능입니다. '설정 > 로그인 하기'에서 로그인해주세요.");
      return;
    }

    final stampStatusWithErrorResult = await fetchStampStatus();

    if (stampStatusWithErrorResult.isExpired) {
      if (!mounted) return;
      Common.showSnackBar(context, "다시 로그인해주세요.");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
      return;
    }

    if (stampStatusWithErrorResult.isError) {
      if (!mounted) return;
      Common.showSnackBar(context, "에러가 발생했습니다.");
      return;
    }

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "방문 도장 이벤트",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: HexColor("#425C5A")),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    getFromStampStatus(stampStatusWithErrorResult, place) ==
                            true
                        ? SvgPicture.asset(
                            "assets/stamp_$place.svg",
                            width: 130.w,
                            height: 130.h,
                          )
                        : SvgPicture.asset(
                            "assets/stamp_${place}_grey.svg",
                            width: 130.w,
                            height: 130.h,
                          ),
                    SizedBox(
                      height: 22.h,
                    ),
                    GestureDetector(
                      child: Container(
                          width: 250.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              color: HexColor("#425C5A"),
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          child: isLoading
                              ? Center(
                                  child: Platform.isIOS
                                      ? CupertinoActivityIndicator(
                                          color: HexColor("#f3f3f3"),
                                        )
                                      : CircularProgressIndicator(
                                          color: HexColor("#f3f3f3"),
                                        ),
                                )
                              : Text(
                                  "도장찍기",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("#F8EAE1")),
                                )),
                      onTap: () async {
                        /// 스탬프로 다이얼로그 열고 2주동안 대기하는 상황 배제
                        setState(() {
                          isLoading = true;
                        });
                        final stampPlaceResult = await stampPlace(place);

                        if (stampPlaceResult == StatusCode.REQUEST_ERROR) {
                          if (!mounted) return;
                          Common.showSnackBar(context, "이미 참여했습니다!");
                          Navigator.pop(context);
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        if (stampPlaceResult != StatusCode.SUCCESS) {
                          if (!mounted) return;
                          Common.showSnackBar(context, "오류가 발생했습니다.");
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        final isStampableResult = await isStampable(place);
                        print("isStampableResult : $isStampableResult");
                        if (!isStampableResult) {
                          if (!mounted) return;
                          Common.showSnackBar(context, "원 안으로 들어와 주세요!");
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        if (!mounted) return;
                        Common.showSnackBar(context, "참여가 완료되었습니다!");
                        Navigator.pop(context);
                        setState(() {
                          isLoading = false;
                        });
                        return;
                      },
                    )
                  ],
                ),
                backgroundColor: HexColor("#F8EAE1"),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              );
            },
          );
        });
  }

  Widget showDialogContentFromLevel(int level, VoidCallback next1,
      VoidCallback next2, VoidCallback next3, VoidCallback cancel1) {
    if (level == 1) {
      return Stack(children: [
        Container(
          width: 340.w,
          height: 160.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: HexColor("#F8EAE1")),
          alignment: Alignment.center,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/stamp_allcollected.svg",
                  width: 80.w,
                  height: 80.h,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "도장 이벤트",
                      style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w600,
                          color: HexColor("#425C5A")),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text("성공",
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            color: HexColor("#425C5A"))),
                  ],
                ),
                SizedBox(
                  width: 16.w,
                )
              ]),
        ),
        Container(
            height: 160.h,
            width: 340.w,
            child: lottie.Lottie.asset(
              "assets/lottie_congratulations.json",
            )),
        GestureDetector(
          onTap: next1,
          child: Container(
            height: 160.h,
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              "assets/icon_stamp_next.svg",
              width: 24.w,
              height: 60.h,
            ),
          ),
        )
      ]);
    }
    if (level == 2) {
      return Container(
        width: 340.w,
        height: 160.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: HexColor("#F8EAE1")),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "미션 참여 완료",
              style: TextStyle(fontSize: 30.sp, color: HexColor("425C5A")),
            ),
            Text(
              "전당포(상품수장소)에 가서\n담당자에게 확인 후 상품을 수령하세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: HexColor("#EE795F")),
            ),
            GestureDetector(
              onTap: next2,
              child: Container(
                width: 200.w,
                height: 40.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor("#EE795F")),
                alignment: Alignment.center,
                child: Text(
                  "상품수령",
                  style:
                      TextStyle(fontSize: 17.5.sp, color: HexColor("#f3f3f3")),
                ),
              ),
            )
          ],
        ),
      );
    }

    if (level == 3) {
      return Container(
        width: 340.w,
        height: 160.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: HexColor("#F8EAE1")),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "상품 수령",
              style: TextStyle(fontSize: 30.sp, color: HexColor("425C5A")),
            ),
            Text(
              "확인버튼을 누르시면\n더이상 상품수령이 불가합니다.\n담당자에게 확인 후 눌러주세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: HexColor("#EE795F")),
            ),
            GestureDetector(
              onTap: next2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: next3,
                    child: Container(
                      width: 110.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: HexColor("#EE795F")),
                      alignment: Alignment.center,
                      child: Text(
                        "상품수령",
                        style: TextStyle(
                            fontSize: 17.5.sp, color: HexColor("#f3f3f3")),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  GestureDetector(
                    onTap: cancel1,
                    child: Container(
                      width: 110.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: HexColor("#EE795F")),
                      alignment: Alignment.center,
                      child: Text(
                        "취소",
                        style: TextStyle(
                            fontSize: 17.5.sp, color: HexColor("#f3f3f3")),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Container(
      width: 340.w,
      height: 160.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: HexColor("#F8EAE1")),
      alignment: Alignment.center,
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "축하합니다",
              style: TextStyle(fontSize: 30.sp, color: HexColor("425C5A")),
            ),
            Text(
              "상품 수령 완료",
              style: TextStyle(
                  fontSize: 24.sp,
                  color: HexColor("#EE795F"),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ]),
    );
  }
}

class StampStatusWithError {
  StampStatusWithError(
      this.exhibition,
      this.ground,
      this.fleamarket,
      this.bungeobang,
      this.sangsang,
      this.isPrized,
      this.isError,
      this.isExpired);

  bool exhibition;
  bool ground;
  bool fleamarket;
  bool bungeobang;
  bool sangsang;
  bool isPrized;
  bool isError;
  bool isExpired;
}
