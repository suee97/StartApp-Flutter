import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class ShortLine extends StatelessWidget {
  const ShortLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.51.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: HexColor("#5C7775"),
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
    );
  }
}
