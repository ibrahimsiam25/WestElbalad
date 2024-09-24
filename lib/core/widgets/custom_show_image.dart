import 'dart:io';
import 'package:flutter/material.dart';

class CustomShowImage extends StatelessWidget {
  final File? image;
  final double height;
  final double width;
  final String defaultImage;
  const CustomShowImage({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
    required this.defaultImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Image.file(
            image!,
            width: width,
            height: height,
          )
        : Image.asset(
            width: width,
            height: height,
            defaultImage,
          );
  }
}
