import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class ShortLine extends StatelessWidget {
  ShortLine({Key? key, required this.mainHexColor}) : super(key: key);

  String mainHexColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: HexColor(mainHexColor),
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
    );
  }
}
