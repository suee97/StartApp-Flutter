import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_app/models/event_list.dart';

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
        height: double.infinity,
        color: HexColor("#5C7775"),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin:
            EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h, bottom: 14.h),
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
              SizedBox(height: 28.h,),
              Container(
                margin: EdgeInsets.only(left: 28.w, right: 27.w),
                color: Colors.purpleAccent,
                width: double.infinity,
                child: Text(
                  widget.event.title!,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp),
                ),
              ),
              SizedBox(height: 13.h,),
              Container(
                color: HexColor("#5C7775"),
                height: 4,
                width: double.infinity,
                margin: EdgeInsets.only(left: 18.w, right: 17.w),
              ),
              SizedBox(height: 13.h,),
              Container(
                color: Colors.blue,
                width: 332.w,
                height: 470.25.h
              )
            ],
          ),
        ),
      ),
    );
  }
}
