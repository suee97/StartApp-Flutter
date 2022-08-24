import 'dart:async';
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
import 'package:lottie/lottie.dart' as lottie;
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:app_settings/app_settings.dart';
import 'package:start_app/screens/home/festival/stamp_button.dart';
import '../../../models/status_code.dart';
import '../../../utils/auth.dart';
import '../../../utils/common.dart';
import 'dart:io' show Platform, SocketException;
import '../../login/login_screen.dart';
import 'festival_info_widget.dart';
import 'package:http/http.dart' as http;

import 'festival_lineup_widget.dart';

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
  final secureStorage = const FlutterSecureStorage();

  bool isLoading = false;

  int postofficeCrowded = 1,
      exhibitionCrowded = 1,
      bikingCrowded = 1,
      ccCrowded = 1,
      info1Crowded = 1,
      photozoneCrowded = 1,
      photoismCrowded = 1,
      pawnshopCrowded = 1,
      photoprintingCrowded = 1,
      costumeCrowded = 1,
      gameroomCrowded = 1,
      startshopCrowded = 1;

  List<List> lineup0921 = [], lineup0922 = [], lineup0923 = [];

  bool isExhibition = false;
  bool isFleamarket = false;
  bool isSangSang = false;
  bool isBungEoBang = false;
  bool isGround = false;

  bool allCollectedCheck = false;
  bool isPrized = false;

  bool isContents = true;

  var mydistance;

  late List<FestivalInfoWidget> contentsList;

  late List <FestivalLineupWidget> lineupList;

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
    // var status = await Permission.location.status;
    // print("위치권한");
    // print(status);
    // print(status.isGranted);
    // print(status.isLimited);
    // print(status.isRestricted);
    //
    // var loc = Location();
    // bool _serviceEnabled;
    // LocationData _locationData;
    //
    // _serviceEnabled = await loc.serviceEnabled();
    // print(_serviceEnabled);
    // print(await loc.hasPermission());
    // return status.isGranted;

    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
//권한 상태를 확인합니다.
    if (_permissionGranted == PermissionStatus.denied) {
      // 권한이 없으면 권한을 요청합니다.
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // 권한이 없으면 위치정보를 사용할 수 없어 위치정보를 사용하려는 코드에서 에러가 나기때문에 종료합니다.
        return false;
      }
    }

    // _locationData = await location.getLocation(); //_locationData에는 위도, 경도, 위치의 정확도, 고도, 속도, 방향 시간등의 정보가 담겨있습니다.
    return true;
  }

  Future<LocationData> getCurrentLocationGps() async {
    var currentLocation = await Location().getLocation();
    print("currentLocation : ${currentLocation}");
    return currentLocation;
  }

  @override
  void initState() {
    super.initState();
    setContentsInfo();
    checkStamps();
    getDistance(
        initialCameraPosition.latitude, initialCameraPosition.longitude);
    print("거리확인1: $mydistance");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //도장 찍기 장소와 내 위치 거리 구하기
  Future<void> getDistance(double lat, double long) async {
    var curLoc = await getCurrentLocationGps();
    setState(() {
      mydistance = mp.SphericalUtil.computeDistanceBetween(
          mp.LatLng(curLoc.latitude!, curLoc.longitude!), mp.LatLng(lat, long));
    });
    print("거리확인:: $curLoc 내위치 $mydistance");
  }

  //혼잡도 호출
  Future<void> fetchCrowded() async {
    Map<String, dynamic> resData = {};

    try {
      var resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/booth"))
          .timeout(const Duration(seconds: 30));
      resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 200) {
        List<dynamic> data = resData["data"];

        List<String> _boothInfo = [];
        List<int> _crowdedInfo = [];


        for(Map e in data[0]["boothList"]){
            _boothInfo.add(e.values.toList()[1]);
            _crowdedInfo.add(e.values.toList()[2]);
          }

        String time, lineupTime = '';

        for(Map e in data[0]["lineUpList"]){
          if(e["lineUpDay"] == "2022-09-21"){
            time = e["lineUpTime"].split('T')[1];
            lineupTime = "${time.split(':')[0]}:${time.split(':')[1]}";
            lineup0921.add([lineupTime,e["lineUpTitle"]]);
          }
          if(e["lineUpDay"] == "2022-09-22"){
            time = e["lineUpTime"].split('T')[1];
            lineupTime = "${time.split(':')[0]}:${time.split(':')[1]}";
            lineup0922.add([e["lineUpTime"],e["lineUpTitle"]]);
          }
          if(e["lineUpDay"] == "2022-09-23"){
            time = e["lineUpTime"].split('T')[1];
            lineupTime = "${time.split(':')[0]}:${time.split(':')[1]}";
            lineup0923.add([e["lineUpTime"],e["lineUpTitle"]]);
          }
        }

        int num, crowded;

        for (String booth in _boothInfo) {
          if (booth == "과기대잡화점의기적") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              postofficeCrowded = crowded;
            });
          } else if (booth == "나만의 전시회") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              exhibitionCrowded = crowded;
            });
          } else if (booth == "미니바이킹") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              bikingCrowded = crowded;
            });
          } else if (booth == "씨씨는 사랑을 싣고") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              ccCrowded = crowded;
            });
          } else if (booth == "제1안내소") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              info1Crowded = crowded;
            });
          } else if (booth == "포토존") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              photozoneCrowded = crowded;
            });
          } else if (booth == "포토부스") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              photoismCrowded = crowded;
            });
          } else if (booth == "전당포") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              pawnshopCrowded = crowded;
            });
          } else if (booth == "인화부스") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              photoprintingCrowded = crowded;
            });
          } else if (booth == "믓쟁이 의상소") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              costumeCrowded = crowded;
            });
          } else if (booth == "오락부스") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              gameroomCrowded = crowded;
            });
          } else if (booth == "어의상회") {
            num = _boothInfo.indexOf(booth);
            crowded = _crowdedInfo[num];
            setState(() {
              startshopCrowded = crowded;
            });
          }
        }

        return;
      }

      print("정보를 불러오지 못했습니다.");
    } on TimeoutException catch (e) {
      print("timeout_exception $e");
    } on SocketException catch (e) {
      "socket_error $e";
    } catch (e) {
      "error $e";
    }


  }

  //5개 장소 중 스탬프 찍기 함수
  Future<StatusCode> setStamp(String stampPlace) async {

    final authTokenAndReIssueResult = await Auth.authTokenAndReIssue();
    if(authTokenAndReIssueResult == StatusCode.UNCATCHED_ERROR) {
      return StatusCode.UNCATCHED_ERROR;
    }

    if (authTokenAndReIssueResult == StatusCode.REFRESH_EXPIRED) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
      }

      return StatusCode.UNCATCHED_ERROR;
    }

    final ACCESS_TOKEN = await Auth.secureStorage.read(key: "ACCESS_TOKEN");

    Map bodyData = {"target": stampPlace};

    try {
      final resString = await http
          .post(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/stamp"),
              headers: {
                "Authorization": "Bearer $ACCESS_TOKEN",
                "Content-Type": "application/json"
              },
              body: json.encode(bodyData))
          .timeout(const Duration(seconds: 30));
      final resData = jsonDecode(utf8.decode(resString.bodyBytes));

      if (resData["status"] == 200) {
        //도장 정보가 post 됨.
        print("access토큰이 바로 사용되어 스탬프 api 성공");
        return StatusCode.SUCCESS;
      }

    } on TimeoutException catch (e) {
      print("timeout_exception $e");
      return StatusCode.TIMEOUT_ERROR;
    } on SocketException catch (e) {
      "socket_error $e";
      return StatusCode.CONNECTION_ERROR;
    } catch (e) {
      "error $e";
      return StatusCode.UNCATCHED_ERROR;
    }

    return StatusCode.UNCATCHED_ERROR;
  }

  Future<void> finishSetStamp(String place) async {
    final setStampResult = await setStamp(place);
    if (setStampResult == StatusCode.SUCCESS) {
      return;
    }
    if (setStampResult == StatusCode.UNCATCHED_ERROR) {
      Common.setIsLogin(false);
      await Common.setNonLogin(false);
      await Common.setAutoLogin(false);
      await Common.clearStudentInfoPref();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
      Common.showSnackBar(context, "1. 다시 로그인해주세요.");
      return;
    }
    if (setStampResult == StatusCode.TIMEOUT_ERROR) {
      Common.showSnackBar(context, "잠시 후 다시 시도해주세요.");
      return;
    }
    if (setStampResult == StatusCode.CONNECTION_ERROR) {
      Common.showSnackBar(context, "네트워크 문제가 발생했습니다.");
      return;
    }

    Common.showSnackBar(context, "오류가 발생했습니다.");
    return;
  }

  //전체 5개 스탬프 찍기 상태 조회
  Future<StatusCode> getStampStatus() async {

    final authTokenAndReIssueResult = await Auth.authTokenAndReIssue();
    if (authTokenAndReIssueResult == StatusCode.UNCATCHED_ERROR) {
      return StatusCode.UNCATCHED_ERROR;
    }

    if (authTokenAndReIssueResult == StatusCode.REFRESH_EXPIRED) {

      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
      }

      return StatusCode.UNCATCHED_ERROR;
    }

    final ACCESS_TOKEN = await Auth.secureStorage.read(key: "ACCESS_TOKEN");

    Map<String, dynamic> resData = {};

    try {
      final resString = await http
          .get(Uri.parse("${dotenv.get("DEV_API_BASE_URL")}/stamp"), headers: {
        "Authorization": "Bearer $ACCESS_TOKEN"
      }).timeout(const Duration(seconds: 30));
      resData = jsonDecode(utf8.decode(resString.bodyBytes));

      print("전상태$isExhibition");
      print("데이터: $resData");
      if (resData["status"] == 200) {
        //스탬프 수집 정보 조회됨.
        Map data = resData["data"][0];

        setState(() {
          isExhibition = data['exhibition'];
          isGround = data['ground'];
          isFleamarket = data['fleamarket'];
          isBungEoBang = data['bungeobang'];
          isSangSang = data['sangsang'];
          isPrized = data['isPrized'];
        });

        print("후상태$isExhibition");
        return StatusCode.SUCCESS;
      }

    } on TimeoutException catch (e) {
      print("timeout_exception $e");
      return StatusCode.TIMEOUT_ERROR;
    } on SocketException catch (e) {
      "socker_error $e";
      return StatusCode.CONNECTION_ERROR;
    } catch (e) {
      "error $e";
      return StatusCode.UNCATCHED_ERROR;
    }

    return StatusCode.UNCATCHED_ERROR;
  }

  Future<void> checkStamps() async {
    if(!Common.getIsLogin()){
      return;
    }

    final getStampStatusResult = await getStampStatus();
    if (getStampStatusResult == StatusCode.SUCCESS) {
      //5개를 모두 모았다면,
      return;
    }
    if (getStampStatusResult == StatusCode.UNCATCHED_ERROR) {
      Common.setIsLogin(false);
      await Common.setNonLogin(false);
      await Common.setAutoLogin(false);
      await Common.clearStudentInfoPref();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const LoginScreen()),
          (route) => false);
      Common.showSnackBar(context, "10. 다시 로그인해주세요.");
      return;
    }
    if (getStampStatusResult == StatusCode.TIMEOUT_ERROR) {
      Common.showSnackBar(context, "잠시 후 다시 시도해주세요.");
      return;
    }
    if (getStampStatusResult == StatusCode.CONNECTION_ERROR) {
      Common.showSnackBar(context, "네트워크 문제가 발생했습니다.");
      return;
    }
    return;
  }

  Future<void> setContentsInfo() async {
    await fetchCrowded();
    contentsList = <FestivalInfoWidget>[
      FestivalInfoWidget(
          contentTitle: "과기대\n잡화점의 기적",
          contentImg: "festival_postoffice_img",
          openTime: "11:00~12:00",
          contentCrowded: postofficeCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "나만의 전시회",
          contentImg: "festival_exhibition_img",
          openTime: "11:00~12:00",
          contentCrowded: exhibitionCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "낙서 캔버스",
          contentImg: "festival_doodlewall_img",
          openTime: "11:00~12:00",
          contentCrowded: 0,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "마당사업",
          contentImg: "festival_madangbiz_img",
          openTime: "11:00~12:00",
          contentCrowded: 0,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "미니바이킹",
          contentImg: "festival_biking_img",
          openTime: "11:00~12:00",
          contentCrowded: bikingCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "씨씨는 사랑을 싣고",
          contentImg: "festival_cc_img",
          openTime: "11:00~12:00",
          contentCrowded: ccCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "제1안내소",
          contentImg: "festival_info1_img",
          openTime: "11:00~12:00",
          contentCrowded: info1Crowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "매표소",
          contentImg: "festival_ticketbooth_img",
          openTime: "11:00~12:00",
          contentCrowded: 0,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "제3안내소",
          contentImg: "festival_info3_img",
          openTime: "11:00~12:00",
          contentCrowded: 0,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "플리마켓",
          contentImg: "festival_fleamarket_img",
          openTime: "11:00~12:00",
          contentCrowded: 0,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "포토존",
          contentImg: "festival_photozone_img",
          openTime: "11:00~12:00",
          contentCrowded: photozoneCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "포토부스",
          contentImg: "festival_photoism_img",
          openTime: "11:00~12:00",
          contentCrowded: photoismCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "패션투표",
          contentImg: "festival_fashionvote_img",
          openTime: "11:00~12:00",
          contentCrowded: 0,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "전당포",
          contentImg: "festival_pawnshop_img",
          openTime: "11:00~12:00",
          contentCrowded: pawnshopCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "인화부스",
          contentImg: "festival_photoprinting_img",
          openTime: "11:00~12:00",
          contentCrowded: photoprintingCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "믓쟁이 의상소",
          contentImg: "festival_costume_img",
          openTime: "11:00~12:00",
          contentCrowded: costumeCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "오락부스",
          contentImg: "festival_gameroom_img",
          openTime: "11:00~12:00",
          contentCrowded: gameroomCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
      FestivalInfoWidget(
          contentTitle: "어의상회",
          contentImg: "festival_startshop_img",
          openTime: "11:00~12:00",
          contentCrowded: startshopCrowded,
          contentFee: "자치회비 납부자(무료)\n자치회비 미납부자(500원)\n외부 참가자(2,000원)"),
    ];

    lineupList =  <FestivalLineupWidget>[
      // lineup0921 == [] ?:
      FestivalLineupWidget(lineupDay: "9월 21일",lineups: lineup0921),
      FestivalLineupWidget(lineupDay: "9월 22일",lineups: lineup0922),
      FestivalLineupWidget(lineupDay: "9월 23일",lineups: lineup0923),
    ];
    print("확인:$lineup0921 , $lineup0922 , $lineup0923");
  }

  @override
  Widget build(BuildContext context) {
    Widget _getContentsCrowded(ScrollController scrollController) {
      return ListView.builder(
          controller: scrollController,
          itemCount: contentsList.length,
          itemBuilder: (context, index) {
            return contentsList[index];
          });
    }

    Widget _getLineupInfo(ScrollController scrollController) {
      return ListView.builder(
          controller: scrollController,
          itemCount: lineupList.length,
          itemBuilder: (context, index) {
            return lineupList[index];
          });
    }

    Set<Marker> _markerList = {
      Marker(
        markerId: const MarkerId("exhibition"),
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
                          SizedBox(
                            height: 22.h,
                          ),
                          isExhibition
                              ? SvgPicture.asset("assets/stamp_exhibition.svg",
                                  width: 130.w, height: 130.h)
                              : SvgPicture.asset(
                                  "assets/gray_stamp_exhibition.svg",
                                  width: 130.w,
                                  height: 130.h),
                          SizedBox(
                            height: 23.h,
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith(
                                    (state) => HexColor("#5C7775")),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (state) => HexColor("#425c5a")),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: HexColor("#425c5a")),
                                ))),
                            child: StampButton(
                                title: isExhibition ? "도장찍기완료!" : "도장찍기", loading: isLoading),
                            onPressed: () async {

                              if (!Common.getIsLogin()) {
                                Common.showSnackBar(context, "로그인이 필요한 기능입니다. '설정 > 로그인 하기'에서 로그인해주세요.");
                                return;
                              }

                              if (isExhibition) {
                                //도장을 이미 찍은 상태
                                Common.showSnackBar(context, "이미 도장을 찍었습니다.");
                                return;
                              } else {
                                //도장을 안 찍은 상태
                                setState(() {
                                  isLoading = true;
                                });

                                await getDistance(37.6313962, 127.0767797);

                                if (mydistance < 50) {
                                  //거리가 멀어서 도장을 찍을 수 없음.
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Common.showSnackBar(
                                      context, "거리가 멀어 도장을 찍을 수 없어요.");
                                  return;
                                }

                                await finishSetStamp("exhibition");
                                setState((){
                                  isExhibition = true;
                                  isLoading = false;
                                });

                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              });
        },
      ),
      Marker(
          markerId: MarkerId("fleamarket"),
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
                            SizedBox(
                              height: 22.h,
                            ),
                            isFleamarket
                                ? SvgPicture.asset(
                                    "assets/stamp_fleamarket.svg",
                                    width: 130.w,
                                    height: 130.h)
                                : SvgPicture.asset(
                                    "assets/gray_stamp_fleamarket.svg",
                                    width: 130.w,
                                    height: 130.h),
                            SizedBox(
                              height: 23.h,
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith(
                                          (state) => HexColor("#5C7775")),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (state) => HexColor("#425c5a")),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side:
                                        BorderSide(color: HexColor("#425c5a")),
                                  ))),
                              child: StampButton(
                                  title: isFleamarket ? "도장찍기완료!" : "도장찍기", loading: isLoading),
                              onPressed: () async {
                                if (!Common.getIsLogin()) {
                                  Common.showSnackBar(context, "로그인이 필요한 기능입니다. '설정 > 로그인 하기'에서 로그인해주세요.");
                                  return;
                                }
                                if (isFleamarket) {
                                  //도장을 이미 찍은 상태
                                  Common.showSnackBar(context, "이미 도장을 찍었습니다.");
                                  return;
                                } else {
                                  //도장을 안 찍은 상태
                                  setState(() {
                                    isLoading = true;
                                  });

                                  await getDistance(37.6327762, 127.077273);
                                  print("거리확인2: $mydistance");
                                  if (mydistance < 50) {
                                    //거리가 멀어서 도장을 찍을 수 없음.
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Common.showSnackBar(
                                        context, "거리가 멀어 도장을 찍을 수 없어요.");
                                    return;
                                  }

                                  await finishSetStamp("fleamarket");
                                  setState(() {
                                    isFleamarket = true;
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                });
          }),
      Marker(
          markerId: MarkerId("sangsang"),
          position: LatLng(37.63089, 127.0796858),
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
                            SizedBox(
                              height: 22.h,
                            ),
                            isSangSang
                                ? SvgPicture.asset("assets/stamp_sangsang.svg",
                                    width: 130.w, height: 130.h)
                                : SvgPicture.asset(
                                    "assets/gray_stamp_sangsang.svg",
                                    width: 130.w,
                                    height: 130.h),
                            SizedBox(
                              height: 23.h,
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith(
                                          (state) => HexColor("#5C7775")),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (state) => HexColor("#425c5a")),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side:
                                        BorderSide(color: HexColor("#425c5a")),
                                  ))),
                              child: StampButton(
                                  title: isSangSang ? "도장찍기완료!" : "도장찍기", loading: isLoading),
                              onPressed: () async {
                                if (!Common.getIsLogin()) {
                                  Common.showSnackBar(
                                      context, "로그인이 필요한 기능입니다. '설정 > 로그인 하기'에서 로그인해주세요.");
                                  return;
                                }
                                if (isSangSang) {
                                  //도장을 이미 찍은 상태
                                  Common.showSnackBar(context, "이미 도장을 찍었습니다.");
                                  return;
                                } else {
                                  //도장을 안 찍은 상태
                                  setState(() {
                                    isLoading = true;
                                  });

                                  await getDistance(37.63089, 127.0796858);

                                  if (mydistance < 50) {
                                    //거리가 멀어서 도장을 찍을 수 없음.
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Common.showSnackBar(
                                        context, "거리가 멀어 도장을 찍을 수 없어요.");
                                    return;
                                  }

                                  await finishSetStamp("sangsang");
                                  setState(() {
                                    isSangSang = true;
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                });
          }),
      Marker(
          markerId: MarkerId("bungeobang"),
          position: LatLng(37.6331603, 127.0785649),
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
                            SizedBox(
                              height: 22.h,
                            ),
                            isBungEoBang
                                ? SvgPicture.asset(
                                    "assets/stamp_bungeobang.svg",
                                    width: 130.w,
                                    height: 130.h)
                                : SvgPicture.asset(
                                    "assets/gray_stamp_bungeobang.svg",
                                    width: 130.w,
                                    height: 130.h),
                            SizedBox(
                              height: 23.h,
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith(
                                          (state) => HexColor("#5C7775")),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (state) => HexColor("#425c5a")),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side:
                                        BorderSide(color: HexColor("#425c5a")),
                                  ))),
                              child: StampButton(
                                  title: isBungEoBang ? "도장찍기완료!" : "도장찍기", loading: isLoading),
                              onPressed: () async {
                                if (!Common.getIsLogin()) {
                                  Common.showSnackBar(
                                      context, "로그인이 필요한 기능입니다. '설정 > 로그인 하기'에서 로그인해주세요.");
                                  return;
                                }

                                if (isBungEoBang) {
                                  //도장을 이미 찍은 상태
                                  Common.showSnackBar(context, "이미 도장을 찍었습니다.");
                                  return;
                                } else {
                                  //도장을 안 찍은 상태
                                  setState(() {
                                    isLoading = true;
                                  });

                                  await getDistance(37.6331603, 127.0785649);

                                  if (mydistance < 50) {
                                    //거리가 멀어서 도장을 찍을 수 없음.
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Common.showSnackBar(
                                        context, "거리가 멀어 도장을 찍을 수 없어요.");
                                    return;
                                  }

                                  await finishSetStamp("bungeobang");
                                  setState(() {
                                    isBungEoBang = true;
                                    isLoading = false;
                                  });

                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                });
          }),
      Marker(
          markerId: MarkerId("ground"),
          position: LatLng(37.6297553, 127.0770174),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                width: 318.w,
                                height: 330.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: HexColor("#F8EAE1")),
                                // padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                                padding:
                                    EdgeInsets.fromLTRB(34.w, 21.h, 34.w, 21.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "최-첨단 방문 도장 이벤트",
                                      style: TextStyle(
                                          fontSize: 17.5.sp,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor("#425C5A")),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "도장 존에 들어오셨나요? 도장 존에 들어오셨다면 도장 찍기를 눌러주세요!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13.5.sp,
                                        fontWeight: FontWeight.w300,
                                        color: HexColor("#5C7775"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 22.h,
                                    ),
                                    isGround
                                        ? SvgPicture.asset(
                                            "assets/stamp_ground.svg",
                                            width: 130.w,
                                            height: 130.h)
                                        : SvgPicture.asset(
                                            "assets/gray_stamp_ground.svg",
                                            width: 130.w,
                                            height: 130.h),
                                    SizedBox(
                                      height: 23.h,
                                    ),
                                    OutlinedButton(
                                        style: ButtonStyle(
                                            overlayColor: MaterialStateProperty
                                                .resolveWith((state) =>
                                                    HexColor("#5C7775")),
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith((state) =>
                                                        HexColor("#425c5a")),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              side: BorderSide(
                                                  color: HexColor("#425c5a")),
                                            ))),
                                        child: StampButton(
                                            title:
                                                isGround ? "도장찍기완료!" : "도장찍기", loading: isLoading),
                                        onPressed: () async {
                                          if (!Common.getIsLogin()) {
                                            Common.showSnackBar(
                                                context, "로그인이 필요한 기능입니다. '설정 > 로그인 하기'에서 로그인해주세요.");
                                            return;
                                          }

                                          if (isGround) {
                                            //도장을 이미 찍은 상태
                                            Common.showSnackBar(
                                                context, "이미 도장을 찍었습니다.");
                                            return;
                                          } else {
                                            //도장을 안 찍은 상태
                                            setState(() {
                                              isLoading = true;
                                            });

                                            await getDistance(37.6297553, 127.0770174);

                                            if (mydistance < 50) {
                                              //거리가 멀어서 도장을 찍을 수 없음.
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Common.showSnackBar(context,
                                                  "거리가 멀어 도장을 찍을 수 없어요.");
                                              return;
                                            }

                                            await finishSetStamp("ground");
                                            setState(() {
                                              isGround = true;
                                              isLoading = false;
                                            });
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    },
                  );
                });
          }),
    };

    Set<Circle> circleList = {
      Circle(
          circleId: const CircleId("exhibition"),
          center: const LatLng(37.6313962, 127.0767797),
          radius: Common.CIRCLE_RADIUS,
          fillColor: Colors.redAccent.withOpacity(0.2),
          strokeWidth: 2,
          strokeColor: Colors.redAccent),
      Circle(
          circleId: const CircleId("fleamarket"),
          center: const LatLng(37.6327762, 127.077273),
          radius: Common.CIRCLE_RADIUS,
          fillColor: Colors.redAccent.withOpacity(0.2),
          strokeWidth: 2,
          strokeColor: Colors.redAccent),
      Circle(
          circleId: const CircleId("sangsang"),
          center: const LatLng(37.63089, 127.0796858),
          radius: Common.CIRCLE_RADIUS,
          fillColor: Colors.redAccent.withOpacity(0.2),
          strokeWidth: 2,
          strokeColor: Colors.redAccent),
      Circle(
          circleId: const CircleId("bungeobang"),
          center: const LatLng(37.6331603, 127.0785649),
          radius: Common.CIRCLE_RADIUS,
          fillColor: Colors.redAccent.withOpacity(0.2),
          strokeWidth: 2,
          strokeColor: Colors.redAccent),
      Circle(
          circleId: const CircleId("ground"),
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
                            return;
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return AlertDialog(
                            //         title: const Text("위치 서비스 사용"),
                            //         content: const Text(
                            //             "위치서비스를 사용할 수 없습니다.\n기기의 설정에서 위치서비스를 켜주세요."),
                            //         actions: [
                            //           ElevatedButton(
                            //               onPressed: () {
                            //                 Navigator.pop(context);
                            //               },
                            //               child: const Text("확인")),
                            //           ElevatedButton(
                            //               onPressed: () {
                            //                 AppSettings.openAppSettings();
                            //                 Navigator.pop(context);
                            //               },
                            //               child: const Text("설정으로 이동")),
                            //         ],
                            //       );
                            //     });
                          }
                        }
                      },
                      icon: isGetGpsLoading == false
                          ? const Icon(Icons.gps_fixed)
                          : const Icon(Icons.access_time)),
                ),
              ),
            )),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //스탬프 조회
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: SvgPicture.asset("assets/icon_check_stamp_status.svg"),
                ),
                onTap: () async {
                  if (!Common.getIsLogin()) {
                    Common.showSnackBar(context, "로그인이 필요한 기능입니다. '설정 > 로그인 하기'에서 로그인해주세요.");
                    return;
                  }

                  final getStampStatusResult = await getStampStatus();
                  if (getStampStatusResult == StatusCode.SUCCESS) {
                    //5개를 모두 모았다면,
                    // if (isExhibition &&
                    //     isGround &&
                    //     isBungEoBang &&
                    //     isSangSang &&
                    //     isFleamarket) {
                    //   //?
                    // }
                    // return;
                  }
                  if (getStampStatusResult == StatusCode.UNCATCHED_ERROR) {
                    Common.setIsLogin(false);
                    await Common.setNonLogin(false);
                    await Common.setAutoLogin(false);
                    await Common.clearStudentInfoPref();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                    Common.showSnackBar(context, "2. 다시 로그인해주세요.");
                    return;
                  }
                  if (getStampStatusResult == StatusCode.TIMEOUT_ERROR) {
                    Common.showSnackBar(context, "잠시 후 다시 시도해주세요.");
                    return;
                  }
                  if (getStampStatusResult == StatusCode.CONNECTION_ERROR) {
                    Common.showSnackBar(context, "네트워크 문제가 발생했습니다.");
                    return;
                  }

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        print("결정$isExhibition");
                        return isExhibition &&
                            isGround &&
                            isBungEoBang &&
                            isSangSang &&
                            isFleamarket
                            ? Stack(
                            children: [
                                Dialog(
                                    backgroundColor: Colors.transparent,
                                    insetPadding: EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 340.w,
                                          height: 230.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: HexColor("#F8EAE1")),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.fromLTRB(
                                              24.w, 58.h, 21.77.w, 58.51.h),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/stamp_allcollected.svg",
                                                  width: 80.w,
                                                  height: 93.49.h,
                                                ),
                                                SizedBox(
                                                  width: 19.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "도장 이벤트",
                                                      style: TextStyle(
                                                          fontSize: 25.5.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: HexColor(
                                                              "#425C5A")),
                                                    ),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Text("성공",
                                                        style: TextStyle(
                                                            fontSize: 33.5.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: HexColor(
                                                                "#425C5A"))),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Container(
                                                    width: 24.w, height: 60.h)
                                              ]),
                                        ),
                                      ],
                                    )),
                                Center(
                                    child: Container(
                                        width: double.infinity,
                                        height: 230.h,
                                        child: Stack(children: [
                                          Container(
                                              width: double.infinity,
                                              height: 230.h,
                                              alignment: Alignment.center,
                                              child: lottie.Lottie.asset(
                                                "assets/lottie_congratulations.json",
                                              )),
                                          Container(
                                              width: double.infinity,
                                              height: 230.h,
                                              child: GestureDetector(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  padding: EdgeInsets.fromLTRB(
                                                      24.w,
                                                      58.h,
                                                      21.7.w,
                                                      58.51.h),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: SvgPicture.asset(
                                                    "assets/icon_stamp_next.svg",
                                                    width: 24.w,
                                                    height: 60.h,
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState((){
                                                    allCollectedCheck = true;
                                                  });
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Dialog(
                                                            backgroundColor:
                                                                HexColor(
                                                                    "#F8EAE1"),
                                                            insetPadding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Stack(
                                                                clipBehavior:
                                                                    Clip.none,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    width:
                                                                        340.w,
                                                                    height:
                                                                        230.h,
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            20.w,
                                                                            73.h,
                                                                            20.w,
                                                                            13.h),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "미션 참여 완료",
                                                                          style: TextStyle(
                                                                              fontSize: 33.5.sp,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: HexColor("#425C5A")),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              11.h,
                                                                        ),
                                                                        GestureDetector(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                200.w,
                                                                            height:
                                                                                40.h,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(color: HexColor("#EE795F"), borderRadius: BorderRadius.circular(20)),
                                                                            child:
                                                                                Text(
                                                                              "상품 수령",
                                                                              style: TextStyle(color: HexColor("#F3F3F3"), fontSize: 17.5.sp, fontWeight: FontWeight.w600, decoration: TextDecoration.none),
                                                                            ),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return Dialog(
                                                                                      backgroundColor: HexColor("#F8EAE1"),
                                                                                      insetPadding: EdgeInsets.all(10),
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(30.0),
                                                                                      ),
                                                                                      child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: <Widget>[
                                                                                        Container(
                                                                                            width: 320.w,
                                                                                            height: 240.h,
                                                                                            padding: EdgeInsets.fromLTRB(20.w, 49.h, 20.w, 27.h),
                                                                                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                              Text(
                                                                                                "상품 수령",
                                                                                                style: TextStyle(fontSize: 33.5.sp, fontWeight: FontWeight.w600, color: HexColor("#425C5A")),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 8.h,
                                                                                              ),
                                                                                              Text("확인 버튼을 누르면\n더이상 상품수령이 불가합니다.\n담당자에게 확인 후 버튼을 클릭해주세요.", textAlign: TextAlign.center, style: TextStyle(fontSize: 12.5.sp, color: HexColor("#EE795F"))),
                                                                                              SizedBox(
                                                                                                height: 23.h,
                                                                                              ),
                                                                                              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                GestureDetector(
                                                                                                    child: Container(
                                                                                                      width: 130.w,
                                                                                                      height: 40.h,
                                                                                                      alignment: Alignment.center,
                                                                                                      decoration: BoxDecoration(color: HexColor("#EE795F"), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                                                                                      child: isLoading ? Center(
                                                                                                        child: Platform.isIOS
                                                                                                            ? const CupertinoActivityIndicator(
                                                                                                          color: Colors.white,
                                                                                                        )
                                                                                                            : CircularProgressIndicator(
                                                                                                          color: HexColor("#f3f3f3"),
                                                                                                        ),
                                                                                                      ) : Text("확인", style: TextStyle(color: HexColor("#F3F3F3"), fontSize: 17.5.sp, fontWeight: FontWeight.w600)),
                                                                                                    ),
                                                                                                    onTap: () async {
                                                                                                      setState((){isLoading = true;});
                                                                                                        setState(() {
                                                                                                          isPrized = true;
                                                                                                        });

                                                                                                        await finishSetStamp("prized");
                                                                                                      setState((){isLoading = false;});

                                                                                                        Navigator.pop(context);
                                                                                                        showDialog(
                                                                                                            context: context,
                                                                                                            builder: (BuildContext context) {
                                                                                                              return Dialog(
                                                                                                                  backgroundColor: Colors.transparent,
                                                                                                                  insetPadding: EdgeInsets.all(10),
                                                                                                                  shape: RoundedRectangleBorder(
                                                                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                                                                  ),
                                                                                                                  child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: <Widget>[
                                                                                                                    Container(
                                                                                                                        width: 340.w,
                                                                                                                        height: 230.h,
                                                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: HexColor("#F8EAE1")),
                                                                                                                        alignment: Alignment.center,
                                                                                                                        padding: EdgeInsets.fromLTRB(50.w, 77.h, 50.w, 13.h),
                                                                                                                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                                                          Text(
                                                                                                                            "축하합니다!",
                                                                                                                            style: TextStyle(color: HexColor("#425C5A"), fontWeight: FontWeight.w600, fontSize: 37.5.sp),
                                                                                                                          ),
                                                                                                                          SizedBox(
                                                                                                                            height: 4.h,
                                                                                                                          ),
                                                                                                                          Text(
                                                                                                                            "상품 수령 완료",
                                                                                                                            style: TextStyle(color: HexColor("#EE795F"), fontWeight: FontWeight.w600, fontSize: 25.5.sp),
                                                                                                                          ),
                                                                                                                          SizedBox(
                                                                                                                            height: 50.h,
                                                                                                                          ),
                                                                                                                          Text(
                                                                                                                            "스템프 이벤트 참여가 더이상 불가능합니다.",
                                                                                                                            style: TextStyle(color: HexColor("#EE795F"), fontSize: 12.5.sp),
                                                                                                                          )
                                                                                                                        ]))
                                                                                                                  ]));
                                                                                                            });
                                                                                                    }),
                                                                                                SizedBox(
                                                                                                  width: 6.w,
                                                                                                ),
                                                                                                GestureDetector(
                                                                                                    child: Container(
                                                                                                      width: 130.w,
                                                                                                      height: 40.h,
                                                                                                      alignment: Alignment.center,
                                                                                                      decoration: BoxDecoration(color: HexColor("#EE795F"), borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
                                                                                                      child: Text("취소", style: TextStyle(color: HexColor("#F3F3F3"), fontSize: 17.5.sp, fontWeight: FontWeight.w600)),
                                                                                                    ),
                                                                                                    onTap: () {
                                                                                                      // Navigator.of(context, rootNavigator: true).pop();
                                                                                                      Navigator.pop(context);
                                                                                                    }),
                                                                                              ])
                                                                                            ]))
                                                                                      ]));
                                                                                });
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              30.h,
                                                                        ),
                                                                        Text(
                                                                          "전당포(상품수령장소)에 가서\n담당자에게 확인 후 버튼을 클릭해 주세요.",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontSize: 12.5.sp,
                                                                              color: HexColor("#EE795F")),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ]));
                                                      });
                                                },
                                              ))
                                        ])))
                              ])
                            : Dialog(
                                backgroundColor: HexColor("#F8EAE1"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                    width: 340.w,
                                    height: 230.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: HexColor("#F8EAE1")),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "최-첨단 방문 도장 이벤트 현황",
                                            style: TextStyle(
                                                fontSize: 17.5.sp,
                                                fontWeight: FontWeight.w600,
                                                color: HexColor("#425C5A")),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 14.h, bottom: 18.h),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    isGround
                                                        ? SvgPicture.asset(
                                                            "assets/stamp_ground.svg",
                                                            width: 67.w,
                                                            height: 67.h,
                                                          )
                                                        : SvgPicture.asset(
                                                            "assets/gray_stamp_ground.svg",
                                                            width: 67.w,
                                                            height: 67.h),
                                                    SizedBox(
                                                      width: 14.w,
                                                    ),
                                                    isExhibition
                                                        ? SvgPicture.asset(
                                                            "assets/stamp_exhibition.svg",
                                                            width: 67.w,
                                                            height: 67.h)
                                                        : SvgPicture.asset(
                                                            "assets/gray_stamp_exhibition.svg",
                                                            width: 67.w,
                                                            height: 67.h),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    isFleamarket
                                                        ? SvgPicture.asset(
                                                            "assets/stamp_fleamarket.svg",
                                                            width: 67.w,
                                                            height: 67.h)
                                                        : SvgPicture.asset(
                                                            "assets/gray_stamp_fleamarket.svg",
                                                            width: 67.w,
                                                            height: 67.h),
                                                    SizedBox(
                                                      width: 14.w,
                                                    ),
                                                    isBungEoBang
                                                        ? SvgPicture.asset(
                                                            "assets/stamp_bungeobang.svg",
                                                            width: 67.w,
                                                            height: 67.h)
                                                        : SvgPicture.asset(
                                                            "assets/gray_stamp_bungeobang.svg",
                                                            width: 67.w,
                                                            height: 67.h),
                                                    SizedBox(
                                                      width: 14.w,
                                                    ),
                                                    isSangSang
                                                        ? SvgPicture.asset(
                                                            "assets/stamp_sangsang.svg",
                                                            width: 67.w,
                                                            height: 67.h)
                                                        : SvgPicture.asset(
                                                            "assets/gray_stamp_sangsang.svg",
                                                            width: 67.w,
                                                            height: 67.h),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ])));
                      });
                },
              ),

              //축제 컨텐츠 정보 조회
              GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Container(
                      child: SvgPicture.asset("assets/icon_festival_info.svg"),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: HexColor("#F8EAE1"),
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30.0)),
                        ),
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return DraggableScrollableSheet(
                                expand: false,
                                builder: (BuildContext context,
                                    ScrollController scrollController) {
                                  return Column(children: <Widget>[
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: 40.h,
                                            width: 160.w,
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isContents = true;
                                                  });
                                                },
                                                child: !isContents
                                                    ? Text("컨텐츠",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 17.5.sp,
                                                            color: HexColor(
                                                                "#425C5A")))
                                                    : Text("컨텐츠",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 17.5.sp,
                                                            color: HexColor(
                                                                "#50425C5A"))),
                                                style: ButtonStyle(
                                                    overlayColor:
                                                        MaterialStateColor.resolveWith(
                                                            (states) => HexColor(
                                                                "#F8EAE1")),
                                                    backgroundColor: isContents
                                                        ? MaterialStateProperty.all<
                                                                Color>(
                                                            HexColor("#50FFFFFF"))
                                                        : MaterialStateProperty.all<Color>(HexColor("#FFFFFF")),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      20)),
                                                      // side: BorderSide(color: Colors.red)
                                                    ))))),
                                        SizedBox(
                                            height: 40.h,
                                            width: 160.w,
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isContents = false;
                                                  });
                                                },
                                                child: !isContents
                                                    ? Text("무대 라인업",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 17.5.sp,
                                                            color: HexColor(
                                                                "#50425C5A")))
                                                    : Text(
                                                        "무대 라인업",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 17.5.sp,
                                                            color: HexColor(
                                                                "#425C5A")),
                                                      ),
                                                style: ButtonStyle(
                                                    overlayColor:
                                                        MaterialStateColor.resolveWith(
                                                            (states) => HexColor(
                                                                "#F8EAE1")),
                                                    backgroundColor: !isContents
                                                        ? MaterialStateProperty
                                                            .all<Color>(HexColor(
                                                                "#50FFFFFF"))
                                                        : MaterialStateProperty.all<
                                                                Color>(
                                                            HexColor("#FFFFFF")),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                      // side: BorderSide(color: Colors.red)
                                                    )))))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 14.h,
                                    ),
                                    Expanded(
                                        child: isContents
                                            ? _getContentsCrowded(
                                                scrollController)
                                            : _getLineupInfo(scrollController))
                                  ]);
                                });
                          });
                        });
                  })
            ],
          ),
        )
      ]),
    );
  }
}
