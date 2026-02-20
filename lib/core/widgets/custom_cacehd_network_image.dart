import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? borderRadius;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedWidth =
        (width == double.infinity || width == null) ? width : width!.w;

    final resolvedHeight =
        (height == null || height == double.infinity) ? height : height!.h;

    return ClipRRect(
      borderRadius: BorderRadius.circular((borderRadius ?? 0).r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: resolvedWidth,
        height: resolvedHeight,
        fit: fit,
        alignment: Alignment.topCenter,
        fadeInDuration: const Duration(milliseconds: 300),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: resolvedWidth,
            height: resolvedHeight,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: resolvedWidth,
          height: resolvedHeight,
          color: AppColors.lightGrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                size: 24.sp,
                color: Colors.grey.shade400,
              ),
              if (resolvedHeight == null || resolvedHeight > 60) ...[
                SizedBox(height: 4.h),
                Text(
                  'لا توجد صورة',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey.shade400,
                    fontFamily:
                        'Cairo', // Assuming font family, ok to remove if risky
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
