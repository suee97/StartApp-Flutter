import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

class FestivalInfoWidget extends StatefulWidget {
  FestivalInfoWidget(
      {Key? key,
        required this.contentTitle,
        required this.contentImg,
        this.contentCrowded = 1,
        required this.openTime,
        required this.contentFee})
      : super(key: key);

  String contentTitle;
  String contentImg;
  int contentCrowded;
  String openTime;
  String contentFee;

  @override
  State<FestivalInfoWidget> createState() => _FestivalInfoWidgetState();
}

class _FestivalInfoWidgetState extends State<FestivalInfoWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 320.w,
        height: 200.h,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: HexColor("#FFFFFF")),
        child: Row(
          children: [
            Container(
              width: 180.w,
              height: 180.h,
              padding: EdgeInsets.only(right: 4.w),
              child: Image(
                fit: BoxFit.fitWidth,
                image: AssetImage("images/${widget.contentImg}.png"),
                color: Colors.white.withOpacity(0.5),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contentTitle,
                  style:
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text("혼잡도",
                    style: TextStyle(
                      fontSize: 12.sp,
                    )),
                getCrowdedSvgFromList(widget.contentCrowded),
                SizedBox(
                  height: 27.h,
                ),
                Text("운영시간",
                    style: TextStyle(
                        fontSize: 10.5.sp, fontWeight: FontWeight.w600)),
                Text(widget.openTime,
                    style: TextStyle(
                        fontSize: 10.5.sp, fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 2.h,
                ),
                Text("요금",
                    style: TextStyle(
                        fontSize: 10.5.sp, fontWeight: FontWeight.w600)),
                Text(widget.contentFee,
                    style: TextStyle(
                        fontSize: 10.5.sp, fontWeight: FontWeight.w400)),
              ],
            )
          ],
        ),
      ),
      SizedBox(
        height: 20.h,
      )
    ]);
  }

  Widget getCrowdedSvgFromList(int crowded) {
    if (crowded == 2) {
      return SvgPicture.asset(
        "assets/mid_crowded.svg",
        width: 80.w,
        height: 10.h,
      );
    }

    if (crowded == 3) {
      return SvgPicture.asset(
        "assets/high_crowded.svg",
        width: 80.w,
        height: 10.h,
      );
    }

    return SvgPicture.asset(
      "assets/low_crowded.svg",
      width: 80.w,
      height: 10.h,
    );
  }
}