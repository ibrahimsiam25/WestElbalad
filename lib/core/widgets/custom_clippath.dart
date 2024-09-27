import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var w = size.width;
    var h = size.height;
    path.lineTo(0, h);
    path.quadraticBezierTo(0, h - 16.0.h, 16.0.h, h - 16.0.h);
    path.lineTo(w - 16.0.h, h - 16.0.h);
    path.quadraticBezierTo(w, h - 16.0.h, w, h);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
