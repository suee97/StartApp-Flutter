import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/models/event_list.dart';
import 'package:start_app/screens/home/event/detail/short_line.dart';
import 'package:url_launcher/url_launcher.dart';
import 'event_apply.dart';

class EventDetailScreen extends StatefulWidget {
  EventDetailScreen({Key? key, required this.event}) : super(key: key);
  Event event;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이벤트 참여"),
        elevation: 0,
        backgroundColor: HexColor("#5C7775"),
        foregroundColor: Colors.white,
      ),
         body: Container(
          width: double.infinity,
          color: HexColor("#5C7775"),
          child: Container(
            width: double.infinity,
            margin:
                EdgeInsets.only(left: 12.w, right: 12.w, top: 0.h, bottom: 14.h),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(height: 20.w),
                Container(
                  margin: EdgeInsets.only(left: 27.w, right: 27.w),
                  width: double.infinity,
                  child: Text(
                    widget.event.title,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 22.sp),
                  ),
                ),
                Container(
                  color: HexColor("#5C7775"),
                  height: 4,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 17.w, right: 17.w),
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
                            Animation animation,
                            Animation secondaryAnimation) {
                          return Center(
                            child: AspectRatio(
                              aspectRatio: 1/1.3,
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height -  210,
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/stworld_test_data.png"),
                                    fit: BoxFit.fill
                                  )
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 350.w,
                    margin: EdgeInsets.only(left: 14.w, right: 14.w),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/poster_dummy.png")
                      )
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    ShortLine(),
                    ShortLine(),
                    ShortLine(),
                  ],
                ),
                const GoToFormWidget(),
                EventApply(
                  onPressed: () => {
                    _launchUrl(widget.event.formLink)
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
  const GoToFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_drop_down,
            color: HexColor("#5C7775"),
            size: 32,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            "구글폼으로 이동",
            style: TextStyle(
                fontSize: 20.sp,
                color: HexColor("#5C7775"),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 8.h,
          ),
          Icon(
            Icons.arrow_drop_down,
            color: HexColor("#5C7775"),
            size: 32,
          ),
        ],
      ),
    );
  }
}
