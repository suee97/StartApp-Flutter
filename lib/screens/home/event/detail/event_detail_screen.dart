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
              EdgeInsets.only(left: 12.w, right: 12.w, top: 0.w, bottom: 14.w),
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
              SizedBox(height: 20.w),
              Container(
                margin: EdgeInsets.only(left: 28.w, right: 27.w),
                width: double.infinity,
                child: Text(
                  widget.event.title!,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 22.sp),
                ),
              ),
              SizedBox(
                height: 15.w,
              ),
              Container(
                color: HexColor("#5C7775"),
                height: 4,
                width: double.infinity,
                margin: EdgeInsets.only(left: 18.w, right: 17.w),
              ),
              SizedBox(
                height: 16.w,
              ),
              Container(
                width: double.infinity,
                height: 300.w,
                margin: EdgeInsets.only(left: 14.w, right: 14.w),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/poster_dummy.png")
                  )
                ),
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  ShortLine(),
                  ShortLine(),
                  ShortLine(),
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              const GoToFormWidget(),
              SizedBox(
                height: 8.w,
              ),
              EventApply(
                onPressed: () => {
                  _launchUrl(widget.event.formLink!)
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
            width: 8.w,
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
