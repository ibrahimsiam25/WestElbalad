import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';

class SidingText extends StatelessWidget {
  const SidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Text(
            "FOR MOBILE SERVICE",
            style: AppStyles.subtitle.copyWith(
              color: AppColors.green,
              fontSize: 14.0.sp,
              letterSpacing: 4.0.w,
            ),
          ),
        );
      },
    );
  }
}
