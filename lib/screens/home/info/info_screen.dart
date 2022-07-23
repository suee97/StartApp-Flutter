import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math' as math;

import 'package:start_app/screens/home/info/clip_rect.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: HexColor("#425C5A"),
      appBar: AppBar(
        title: const Text(
          "총학생회 설명",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        foregroundColor: Colors.white,
        backgroundColor: HexColor("#425C5A"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: 900.h,
            color: HexColor("#B2BFB6"),
          ),
          ClipPath(
            clipper: ClipPathClassBottom(),
            child: Container(
              width: double.infinity,
              height: 640.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          ClipPath(
            clipper: ClipPathClassMiddle(),
            child: Container(
              width: double.infinity,
              height: 320.h,
              decoration: BoxDecoration(
                color: HexColor("#F8EAE1"),
              ),
            ),
          ),
          ClipPath(
            clipper: ClipPathClassTop(),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: HexColor("#425C5A"),
              ),
            ),
          ),

        ]),
      ),
    );
  }
}
