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
import 'festival_info_widget.dart';

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

  bool isJeonSi = true;
  bool isMarket = true;
  bool isSangSang = true;
  bool isBungUh = true;
  bool isSandUndong = true;

  bool allCollectedCheck = true;
  bool getPrize = false;

  bool isContents = true;

  static List<FestivalInfoWidget> contentsList = <FestivalInfoWidget>[
    FestivalInfoWidget(contentTitle: "과기대잡화점의기적", contentImg: "festival_postoffice_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "나만의 전시회", contentImg: "festival_exhibition_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "낙서 캔버스", contentImg: "festival_doodlewall_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "마당사업", contentImg: "festival_madangbiz_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "미니바이킹", contentImg: "festival_biking_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "씨씨는 사랑을 싣고", contentImg: "festival_cc_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "제1안내소", contentImg: "festival_info1_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "매표소", contentImg: "festival_ticketbooth_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "제3안내소", contentImg: "festival_info3_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "플리마켓", contentImg: "festival_fleamarket_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "포토존", contentImg: "festival_photozone_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "포토부스", contentImg: "festival_photoism_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "패션투표", contentImg: "festival_fashionvote_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "전당포", contentImg: "festival_pawnshop_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "인화부스", contentImg: "festival_photoprinting_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "믓쟁이 의상소", contentImg: "festival_costume_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "오락부스", contentImg: "festival_gameroom_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    FestivalInfoWidget(contentTitle: "어의상회", contentImg: "festival_startshop_img", contentCrowded: 3, openTime: "11:00~12:00", contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
  ];

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
                            "최-첨단 방문 도장 이벤트",
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
                              color: HexColor("#5C7775"),
                            ),
                          ),
                          SizedBox(height: 22.h,),
                          isJeonSi ? SvgPicture.asset("assets/stamp_exhibition.svg", width: 130.w, height: 130.h) : SvgPicture.asset("assets/gray_stamp_exhibition.svg", width: 130.w, height: 130.h),
                          SizedBox(height: 23.h,),
                          StampButton(title: isJeonSi ? "도장찍기" : "도장찍기완료!", onPressed: () async {
                              var curLoc = await getCurrentLocationGps();
                              var distance =
                                  mp.SphericalUtil.computeDistanceBetween(
                                      mp.LatLng(curLoc.latitude!,
                                          curLoc.longitude!),
                                      mp.LatLng(37.6318730, 127.0771544));
                              if (!isJeonSi && distance < 50) {
                                //도장찍기백엔드요청보내기
                                setState(() {
                                  isJeonSi = true;
                                });
                              }
                            })
                        ],
                      ),
                    );
                  },
                );
              });
        },
      ),
      Marker(
          markerId: MarkerId("market"),
          position: LatLng(37.6327762, 127.077273),
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
                              "최-첨단 방문 도장 이벤트",
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
                                color: HexColor("#5C7775"),
                              ),
                            ),
                            SvgPicture.asset("assets/stamp_exhibition.svg", width: 147.w, height: 147.h),
                            StampButton(title: "도장찍기", onPressed: () {})
                          ],
                        ),
                      );
                    },
                  );
                });
          }),
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
                        return isJeonSi && isSandUndong && isBungUh && isSangSang && isMarket || !allCollectedCheck ? Dialog(
                          backgroundColor: HexColor("#F8EAE1"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            width: double.infinity,
                            height: 230.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                SvgPicture.asset("assets/stamp_allcollected.svg", width: 70.w, height: 80.h,),
                              SizedBox(
                                width: 14.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("도장 이벤트", style: TextStyle(
                                      fontSize: 25.5.sp,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("#425C5A")),),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text("성공", style: TextStyle(
                                      fontSize: 33.5.sp,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor("#425C5A"))
                                  ),
                                ],
                              ),
                                SizedBox(
                                  width: 20.w,
                                ),
                              GestureDetector(
                                  child: SvgPicture.asset("assets/icon_stamp_next.svg", width: 14.w, height: 50.h,),
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState((){
                                      allCollectedCheck = true;
                                    });
                                    //스탬프를 모두 모았다는 값을 하나 두고 api 업데이트??
                                    showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                    return Dialog(
                                        backgroundColor: HexColor("#F8EAE1"),
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                        child: Container(
                                          width: double.infinity,
                                          height: 230.h,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                        Text("미션 참여 완료", style: TextStyle(fontSize: 33.5.sp, fontWeight: FontWeight.w600, color: HexColor("#425C5A")),),
                                        GestureDetector(
                                        child: Container(
                                        width: 200.w,
                                        height: 40.h,
                                        margin: EdgeInsets.only(
                                        top: 11.h, bottom: 30.h),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                        color: HexColor("#EE795F"),
                                        borderRadius: BorderRadius.circular(25)),
                                        child: Text(
                                        "상품 수령",
                                        style: TextStyle(
                                        color: HexColor("#F3F3F3"),
                                        fontSize: 17.5.sp,
                                        fontWeight: FontWeight.w600),
                                    ),
                                    ),
                                onTap: () {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return
                                            Dialog(
                                            backgroundColor: HexColor("#F8EAE1"),
                                            shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                            child: Container(
                                                width: double.infinity,
                                                height: 230.h,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                            Text("상품 수령", style: TextStyle(fontSize: 33.5.sp, fontWeight: FontWeight.w600, color: HexColor("#425C5A")),),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text("확인 버튼을 누르면\n더이상 상품수령이 불가합니다.\n담당자에게 확인 후 버튼을 클릭해주세요.", textAlign : TextAlign.center, style: TextStyle(fontSize: 12.5.sp, color: HexColor("#EE795F"))),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                            GestureDetector(
                                            child: Container(
                                            width: 100.w,
                                            height: 40.h,
                                              // margin: EdgeInsets.only(
                                              //     top: 16.h, bottom: 30.h),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                            color: HexColor("#EE795F"),
                                            borderRadius: BorderRadius.circular(25)),
                                            child: Text(
                                            "확인",
                                            style: TextStyle(
                                            color: HexColor("#F3F3F3"),
                                            fontSize: 17.5.sp,
                                            fontWeight: FontWeight.w600),
                                        ),
                                        ),
                                            onTap: () {
                                            setState((){
                                            setState((){
                                            getPrize = true;
                                        }
                                        );
                                            Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return
                                                Dialog(
                                                backgroundColor: HexColor("#F8EAE1"),
                                                shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20)),
                                                child: Container(
                                                    width: double.infinity,
                                                    height: 230.h,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                Text("축하합니다!", style: TextStyle(color : HexColor("#425C5A"), fontWeight: FontWeight.w600, fontSize: 37.5.sp),),
                                                SizedBox(
                                                height: 4.h,
                                            ),
                                                Text("상품 수령 완료", style: TextStyle(color: HexColor("#EE795F"), fontWeight: FontWeight.w600, fontSize : 25.5.sp),),
                                                SizedBox(
                                                height: 50.h,
                                            ),
                                                Text("스템프 이벤트 참여가 더이상 불가능합니다.", style: TextStyle(color: HexColor("#EE795F"), fontSize : 12.5.sp),)
                                                ])
                                            )
                                            );});
                                        }
                                        );
                                        }),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            GestureDetector(
                                            child: Container(
                                            width: 100.w,
                                            height: 40.h,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                            color: HexColor("#EE795F"),
                                            borderRadius: BorderRadius.circular(25)),
                                            child: Text(
                                            "취소",
                                            style: TextStyle(
                                            color: HexColor("#F3F3F3"),
                                            fontSize: 17.5.sp,
                                            fontWeight: FontWeight.w600),
                                        ),
                                        ),
                                            onTap: () {
                                            Navigator.of(context, rootNavigator: true).pop();
                                        })
                                            ],
                                        )
                                            ],
                                        )
                                        )
                                        );});
                                    },
                                    ),
                                        Text("전당포(상품수령장소)에 가서\n담당자에게 확인 후 상품을 수령하세요.", textAlign: TextAlign.center, style: TextStyle(fontSize: 12.5.sp, color: HexColor("#EE795F")),),
                                        ],
                                    ),
                                    ));});
                                  },)
                              ])
                          ),
                        ) : Dialog(
                            backgroundColor: HexColor("#F8EAE1"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                          width: 340.w,
                          height: 240.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: HexColor("#F8EAE1")),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Text("최-첨단 방문 도장 이벤트 현황", style: TextStyle(
                                  fontSize: 17.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#425C5A")),),
                          Container(
                            margin: EdgeInsets.only(top: 14.h, bottom: 18.h),
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  isSandUndong ? SvgPicture.asset("assets/stamp_ground.svg", width: 67.w, height: 67.h,) : SvgPicture.asset("assets/gray_stamp_ground.svg", width: 67.w, height: 67.h),
                                  SizedBox(width: 14.w,),
                                  isJeonSi ? SvgPicture.asset("assets/stamp_exhibition.svg", width: 67.w, height: 67.h) : SvgPicture.asset("assets/gray_stamp_exhibition.svg", width: 67.w, height: 67.h),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                isMarket ? SvgPicture.asset("assets/stamp_fleamarket.svg", width: 67.w, height: 67.h) : SvgPicture.asset("assets/gray_stamp_fleamarket.svg", width: 67.w, height: 67.h),
                                  SizedBox(width: 14.w,),
                                  isBungUh ? SvgPicture.asset("assets/stamp_bungeobang.svg", width: 67.w, height: 67.h) : SvgPicture.asset("assets/gray_stamp_bungeobang.svg", width: 67.w, height: 67.h),
                                  SizedBox(width: 14.w,),
                                  isSangSang ? SvgPicture.asset("assets/stamp_sangsang.svg", width: 67.w, height: 67.h) : SvgPicture.asset("assets/gray_stamp_sangsang.svg", width: 67.w, height: 67.h),
                              ],)
                            ],
                          ),),])
                        ));
                      });
                },
              ),
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Container(child: SvgPicture.asset("assets/icon_festival_info.svg"), decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],
                  ),),
                ),
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: HexColor("#F8EAE1"),
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                      ),
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return DraggableScrollableSheet(
                                  expand: false,
                                  builder: (BuildContext context, ScrollController scrollController) {
                                    return Column(children: <Widget>[
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 40.h,
                                            width: 160.w,
                                            child: TextButton(onPressed: (){
                                              setState((){
                                                  isContents = true;
                                              });
                                          }, child: !isContents ?  Text("무대 라인업", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.5.sp, color: HexColor("#50425C5A"))) : Text("컨텐츠" , style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.5.sp, color: HexColor("#425C5A"))),
                                                style: ButtonStyle(
                                    overlayColor : MaterialStateColor.resolveWith((states) => HexColor("#F8EAE1")),
                                              backgroundColor: isContents ? MaterialStateProperty.all<Color>(HexColor("#50FFFFFF")) : MaterialStateProperty.all<Color>(HexColor("#FFFFFF")),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                                    // side: BorderSide(color: Colors.red)
                                                  )
                                              )
                                          ))),
                                          SizedBox(
                                            height: 40.h,
                                            width: 160.w,
                                            child: TextButton(onPressed: (){
                                              setState((){
                                                  isContents = false;
                                              });
                                            },
                                                child: !isContents ?  Text("무대 라인업", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.5.sp, color: HexColor("#50425C5A"))) : Text("무대 라인업", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.5.sp, color: HexColor("#425C5A")),),
                                                style: ButtonStyle(
                                              overlayColor : MaterialStateColor.resolveWith((states) => HexColor("#F8EAE1")),
                                              backgroundColor: !isContents ? MaterialStateProperty.all<Color>(HexColor("#50FFFFFF")) : MaterialStateProperty.all<Color>(HexColor("#FFFFFF")),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                                                    // side: BorderSide(color: Colors.red)
                                                  )
                                              )
                                          )))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 14.h,
                                      ),
                                      Expanded(
                                        child: isContents ? ListView.builder(
                                            controller: scrollController,
                                            itemCount: contentsList.length,
                                            itemBuilder: (context, index) {
                                              return contentsList[index];
                                            }) : Container(
                                    width: 320.w,
                                    height: 450.h,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: HexColor("#FFFFFF")),)
                                      )
                                    ]);
                                  }
                              );
                            }
                        );}
                  );
                })],
          ),
        )
      ]),
    );
  }
}
