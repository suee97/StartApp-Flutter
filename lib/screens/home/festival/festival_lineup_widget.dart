import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class FestivalLineupWidget extends StatefulWidget {
  FestivalLineupWidget({Key? key,
    required this.lineupDay, required this.lineups,}) : super(key: key);

  String lineupDay;
  List lineups;

  @override
  State<FestivalLineupWidget> createState() => _FestivalLineupWidgetState();
}

class _FestivalLineupWidgetState extends State<FestivalLineupWidget> {
  List lineupInfoList = [];
  List lineupTitle = [];
  List lineupTime = [];

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    for(var e in widget.lineups){
      lineupInfoList.add(e);
    }

    for(List e in lineupInfoList){
      lineupTime.add(e[0]);
      lineupTitle.add(e[1]);
    }

    return Container(
      width: 300.w,
      height: 250.h,
      margin: EdgeInsets.only(bottom: 16.h, left: 30.w, right: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
        "  ${widget.lineupDay}", style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w500, color: HexColor("#425C5A"))),
          SizedBox(
            height: 8.h,
          ),
          Expanded(child: listviewLineupInfo())
        ],
      ),
    );
  }

  Widget listviewLineupInfo() {
    return ListView.builder(
      itemCount: lineupInfoList.length,
        itemBuilder: (BuildContext context, int index) {
      return lineupTile(index, lineupInfoList.length, lineupTime[index], lineupTitle[index]);
    });
  }

  Widget lineupTile(int num, int last, String time, String title) {

    return Container(
      width: 300.w,
      height: 40.h,
      margin: EdgeInsets.only(bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Container(
            width: 94.w,
            height: 40.h,
            alignment: Alignment.center,
            child: Text(time, style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w600, color: HexColor("#FFFFFF"))),
            decoration: BoxDecoration(
              color: HexColor("#B2BFB6"),
                borderRadius: getLeftTileType(num, last)
            ),
          ),
          SizedBox(
            width: 6.w,
          ),
          Container(
            width: 200.w,
            height: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: HexColor("#FFFFFF"),
                borderRadius: getRightTileType(num, last)
            ),
            child: AutoSizeText(title, style: TextStyle(fontSize: 15.5.sp, fontWeight: FontWeight.w500, color: HexColor("#425C5A"))),
          )
        ]
      ),
    );
  }

  BorderRadius getLeftTileType(int num, int last){
    if(num == 0){
      return const BorderRadius.only(topLeft: Radius.circular(20));
    }else if(num == last-1){
      return const BorderRadius.only(bottomLeft: Radius.circular(20));
    }else{
      return const BorderRadius.all(Radius.circular(0));
    }
  }

  BorderRadius getRightTileType(int num, int last){
    if(num == 0){
      return const BorderRadius.only(topRight: Radius.circular(20));
    }else if(num == last-1){
      return const BorderRadius.only(bottomRight: Radius.circular(20));
    }else{
      return const BorderRadius.all(Radius.circular(0));
    }
  }
}


