import 'package:flutter/material.dart';

class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var w = size.width;
    var h = size.height;
    path.lineTo(0, h);
    path.quadraticBezierTo(0, h - 32, 32, h - 32);
    path.lineTo(w - 32, h - 32);
    path.quadraticBezierTo(w, h - 32, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
