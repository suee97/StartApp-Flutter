import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/models/event_list.dart';
import 'package:start_app/screens/home/event/detail/short_line.dart';
import 'package:url_launcher/url_launcher.dart';
import 'event_apply_button.dart';

class EventDetailScreen extends StatefulWidget {
  EventDetailScreen(
      {Key? key,
      required this.event,
      required this.mainColorHex,
      required this.buttonTitle,
      required this.buttonHexColor})
      : super(key: key);

  Event event;
  String mainColorHex;
  String buttonTitle;
  String buttonHexColor;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "이벤트 참여",
          style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: HexColor(widget.mainColorHex),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        color: HexColor(widget.mainColorHex),
        child: Container(
          width: double.infinity,
          margin:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 0.h, bottom: 30.h),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 27.w, right: 27.w),
                width: double.infinity,
                child: Text(
                  widget.event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 21.5.sp),
                ),
              ),
              SizedBox(
                height: 11.h,
              ),
              Container(
                color: HexColor(widget.mainColorHex),
                height: 3,
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 18.w, right: 18.w, top: 0, bottom: 0),
              ),
              SizedBox(
                height: 13.h,
              ),
              GestureDetector(
                onTap: () async {
                  await showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 150),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return Center(
                          child: AspectRatio(
                            aspectRatio: 1 / 1.13,
                            child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height - 210,
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/stworld_test_data.png"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  width: double.infinity,
                  height: 320.h,
                  margin: EdgeInsets.only(left: 18.w, right: 18.w),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/poster_dummy.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: 9.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ShortLine(mainHexColor: widget.mainColorHex),
                    ShortLine(mainHexColor: widget.mainColorHex),
                    ShortLine(mainHexColor: widget.mainColorHex),
                  ],
                ),
              ),
              SizedBox(height: 13.h),
              GoToFormWidget(
                mainColorHex: widget.mainColorHex
              ),
              SizedBox(
                height: 8.h,
              ),
              EventApplyButton(
                buttonTitle: widget.buttonTitle,
                buttonHexColor: widget.buttonHexColor,
                mainHexColor: widget.mainColorHex,
                onPressed: () {
                  _launchUrl(widget.event.formLink);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String _uri) async {
    if (!await launchUrl(Uri.parse(_uri))) {
      throw 'Could not launch ${_uri}';
    }
  }
}

class GoToFormWidget extends StatelessWidget {
  GoToFormWidget({Key? key, required this.mainColorHex}) : super(key: key);

  String mainColorHex;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_drop_down,
            color: HexColor(mainColorHex),
            size: 42.w,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            "구글폼으로 이동",
            style: TextStyle(
                fontSize: 21.5.sp,
                color: HexColor(mainColorHex),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 4.w,
          ),
          Icon(
            Icons.arrow_drop_down,
            color: HexColor(mainColorHex),
            size: 42.w,
          ),
        ],
      ),
    );
  }
}
