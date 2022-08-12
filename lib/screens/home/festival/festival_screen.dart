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
import 'package:start_app/screens/home/festival/stamp_button.dart';
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
    
    Set<Marker> _markerList = {
      Marker(
          markerId: const MarkerId("jeon-si"),
          position: const LatLng(37.6313962, 127.0767797),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        backgroundColor: HexColor("#F8EAE1"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Column(
                          children: <Widget>[
                            Text(
                              "최첨단 방문 도장 이벤트",
                              style: TextStyle(
                                  fontSize: 17.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#425C5A")),
                            ),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "도장 존에 들어오셨나요? 도장 존에 들어오셨다면 도장 찍기를 눌러주세요!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w300,
                                  color: HexColor("#5C7775"),),
                            ),
                            StampButton(title: "도장찍기", onPressed: () {})
                          ],
                        ),
                      );
                    },
                  );
                });

            // return TestButton(
            //                         title: "",
            //                         onPressed: () async {
            //                           var curLoc = await getCurrentLocationGps();
            //                           var distance =
            //                               mp.SphericalUtil.computeDistanceBetween(
            //                                   mp.LatLng(curLoc.latitude!,
            //                                       curLoc.longitude!),
            //                                   mp.LatLng(37.6318730, 127.0771544));
            //                           if (distance > 50) {}
            //                         })
          },),
      Marker(
          markerId: MarkerId("market"),
          position: LatLng(37.6327762, 127.077273)),
      Marker(
          markerId: MarkerId("sang-sang"),
          position: LatLng(37.63089, 127.0796858)),
      Marker(
          markerId: MarkerId("bung-uh"),
          position: LatLng(37.6331603, 127.0785649)),
      Marker(
          markerId: MarkerId("sand-undong"),
          position: LatLng(37.6297553, 127.0770174)),
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
          markers: _markerList,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: SvgPicture.asset("assets/icon_festival_info.svg"),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("이벤트 정보"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("이벤트 정보를 보여줄게요."),
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
