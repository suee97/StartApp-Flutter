import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

class FestivalScreen extends StatefulWidget {
  const FestivalScreen({Key? key}) : super(key: key);

  @override
  State<FestivalScreen> createState() => _FestivalScreenState();
}

class _FestivalScreenState extends State<FestivalScreen> {
  final LatLng initialCameraPosition = const LatLng(37.6324657, 127.0776803);
  late GoogleMapController _controller;
  final Location _location = Location();

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _location.onLocationChanged.listen((location) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(location.latitude!, location.longitude!),
              zoom: 15),
        ),
      );
    });
  }

  Future<bool> checkLocationPermission() async {
    var status = await Permission.location.status;
    return status.isGranted;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markerList = {
      Marker(
          markerId: MarkerId("hyang-hak-ro"),
          position: LatLng(37.6318730, 127.0771544),
          onTap: () => {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    barrierColor: Colors.transparent,
                    backgroundColor: HexColor("#F8EAE1"),
                    context: context,
                    builder: (context) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text('Photo'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    })
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("축제"),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: initialCameraPosition, zoom: 16.0),
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          markers: markerList,
          circles: {
            Circle(
                circleId: CircleId("hyanghakro"),
                center: LatLng(37.6318730, 127.0771544),
                radius: 70,
                fillColor: Colors.redAccent.withOpacity(0.5),
                strokeWidth: 3,
                strokeColor: Colors.redAccent)
          },
        ),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: SvgPicture.asset("assets/icon_check_stamp.svg"),
                ),
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("스탬프 방문트도장 이벤트"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("스탬프 존에 들어오셨다면 도장찍기를 눌러주세요!"),
                              Container(
                                width: double.infinity,
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: HexColor("#425C5A"),
                                    borderRadius: const BorderRadius.all(
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
