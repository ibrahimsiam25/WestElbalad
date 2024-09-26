import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.width = 128.0,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width!.w,
      placeholder: (context, url) => Skeletonizer(
        containersColor: AppColors.darkGrey,
        child: Container(
          width: width!.w,
          color: AppColors.white,
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
      ),
    );
  }
}
