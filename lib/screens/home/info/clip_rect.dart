import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClipPathClassTop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);

    var firstControlPoint = Offset(size.width / 2, size.height);
    path.lineTo(firstControlPoint.dx, firstControlPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ClipPathClassMiddle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 270.h);

    var firstControlPoint = Offset(size.width / 2, 320.h);
    path.lineTo(firstControlPoint.dx, firstControlPoint.dy);

    path.lineTo(size.width, 270.h);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ClipPathClassBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 540.h);

    var firstControlPoint = Offset(size.width / 2, 590.h);
    path.lineTo(firstControlPoint.dx, firstControlPoint.dy);

    path.lineTo(size.width, 540.h);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}