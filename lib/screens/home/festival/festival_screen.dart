import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:start_app/screens/home/festival/stamp_event_join.dart';
import 'package:start_app/widgets/test_button.dart';
import '../../../utils/common.dart';
import 'dart:io' show Platform;

class FestivalScreen extends StatefulWidget {
  const FestivalScreen({Key? key}) : super(key: key);

  @override
  State<FestivalScreen> createState() => _FestivalScreenState();
}

class _FestivalScreenState extends State<FestivalScreen> {
  final LatLng initialCameraPosition = const LatLng(37.6324657, 127.0776803);
  late GoogleMapController _controller;
  final Location _location = Location();
  bool isGetGpsLoading = false;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _location.onLocationChanged.listen((location) {
      // _controller.animateCamera(
      //   CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //         target: LatLng(location.latitude!, location.longitude!),
      //       zoom: 16.0
      //     ),
      //   ),
      // );
    });
  }

  Future<bool> checkLocationPermission() async {
    var status = await Permission.location.status;
    return status.isGranted;
  }

  Future<LocationData> getCurrentLocationGps() async {
    var currentLocation = await Location().getLocation();
    print("currentLocation : ${currentLocation}");
    return currentLocation;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markerList = {
      Marker(
          markerId: const MarkerId("hyang-hak-ro"),
          position: const LatLng(37.6318730, 127.0771544),
          onTap: () {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                barrierColor: Colors.transparent,
                backgroundColor: HexColor("#F8EAE1"),
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Stack(alignment: Alignment.bottomCenter, children: [
                      ListView(
                        children: <Widget>[
                          TestButton(
                              title: "",
                              onPressed: () async {
                                var curLoc = await getCurrentLocationGps();
                                var distance =
                                    mp.SphericalUtil.computeDistanceBetween(
                                        mp.LatLng(curLoc.latitude!,
                                            curLoc.longitude!),
                                        mp.LatLng(37.6318730, 127.0771544));
                                if (distance > 50) {}
                              }),
                        ],
                      ),
                      StampEventJoin(
                          onPressed: () => {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("스탬프 방문 도장 이벤트"),
                                        content: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                "스탬프 존에 들어오셨나요? 스탬프 존에 들어오셨다면 도장찍기 버튼을 눌러주세요."),
                                            Container(
                                              width: double.infinity,
                                              height: 40.h,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: HexColor("#425C5A"),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Text(
                                                "도장찍기",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20.sp,
                                                    color: HexColor("#F8EAE1")),
                                              ),
                                            )
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        backgroundColor: HexColor("#F8EAE1"),
                                      );
                                    })
                              })
                    ]);
                  });
                });
          }),
      Marker(
          markerId: MarkerId("bung-uh-bang"),
          position: LatLng(37.6330957, 127.0785229)),
      Marker(
          markerId: MarkerId("un-dong-jang"),
          position: LatLng(37.6298287, 127.0770952)),
      Marker(
          markerId: MarkerId("sang-sang-gwan"),
          position: LatLng(37.6308725, 127.0799307)),
      Marker(
          markerId: MarkerId("hi-tech"),
          position: LatLng(37.6320294, 127.0765909)),
    };

    Set<Circle> circleList = {
      Circle(
          circleId: const CircleId("hyang-hak-ro"),
          center: const LatLng(37.6318730, 127.0771544),
          radius: Common.CIRCLE_RADIUS,
          fillColor: Colors.redAccent.withOpacity(0.5),
          strokeWidth: 3,
          strokeColor: Colors.redAccent)
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
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("위치 서비스 사용"),
                                    content: const Text(
                                        "위치서비스를 사용할 수 없습니다.\n기기의 설정에서 위치서비스를 켜주세요."),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("확인")),
                                      ElevatedButton(
                                          onPressed: () {
                                            AppSettings.openAppSettings();
                                            Navigator.pop(context);
                                          },
                                          child: const Text("설정으로 이동")),
                                    ],
                                  );
                                });
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: SvgPicture.asset("assets/icon_check_stamp_status.svg"),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("스탬프 방문 도장 이벤트"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("스탬프 존에 들어오셨다면 도장찍기를 눌러주세요!"),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: HexColor("#F8EAE1"),
                        );
                      });
                },
              ),
            ],
          ),
        )
      ]),
    );
  }
}
