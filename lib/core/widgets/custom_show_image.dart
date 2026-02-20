import 'dart:io';

import 'package:flutter/material.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';

class CustomShowImage extends StatelessWidget {
  final File? image;
  final double? height;
  final double? width;
  final String defaultImage;
  final bool online;
  final BoxFit fit;

  const CustomShowImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    required this.defaultImage,
    this.online = false,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return Image.file(
        image!,
        width: width,
        height: height,
        fit: fit,
      );
    } else if (online) {
      return CustomCachedImage(
        imageUrl: defaultImage,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Image.asset(
        defaultImage,
        width: width,
        height: height,
        fit: fit,
      );
    }
  }
}
