import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final BoxFit fit;
  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.width = 128.0,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedWidth =
        (width == double.infinity) ? double.infinity : width!.w;
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: resolvedWidth,
      height: double.infinity,
      fit: fit,
      alignment:  Alignment.topCenter,
      placeholder: (context, url) => Skeletonizer(
        containersColor: AppColors.grey,
        child: Container(
          width: resolvedWidth,
          color: AppColors.white,
        ),
      ),
      errorWidget: (context, url, error) =>
          const Icon(Icons.image_not_supported_outlined),
    );
  }
}
