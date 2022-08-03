import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class DottedLineWidget extends StatelessWidget {
  const DottedLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            color: HexColor("#425c5a"),
            shape: BoxShape.circle
          ),
        ),
        DottedLine(
          direction: Axis.horizontal,
          lineLength: 310.w,
          dashColor: HexColor("#425c5a"),
          dashLength: 13.w,
          dashGapLength: 8.w,
          lineThickness: 1.2,
          dashGapRadius: 4.0,
        ),
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
              color: HexColor("#425c5a"),
              shape: BoxShape.circle
          ),
        ),
      ],
    );
  }
}
