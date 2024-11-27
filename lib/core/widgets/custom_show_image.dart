import 'dart:io';
import 'package:flutter/material.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';

class CustomShowImage extends StatelessWidget {
  final File? image;
  final double height;
  final double width;
  final String defaultImage;
  final bool online;
  const CustomShowImage({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
    required this.defaultImage,
    this.online =false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Image.file(
            image!,
            width: width,
            height: height,
          )
        : online?
        CustomCachedImage(imageUrl: defaultImage)
        :Image.asset(
            width: width,
            height: height,
            defaultImage,
          );
  }
}
