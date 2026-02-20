import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:west_elbalad/core/widgets/custom_clippath.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool backButton;
  final double bottomHeight;
  final bool compact;

  const CustomAppBar({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.backButton = true,
    this.bottomHeight = 40.0,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperPath(),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!compact) SizedBox(height: 6.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: compact ? 36.w : 44.w,
                      height: compact ? 36.w : 44.w,
                      child: backButton
                          ? IconButton(
                              onPressed: () {
                                context.pop();
                              },
                              icon: const BackButtonIcon(),
                              color: AppColors.white,
                              iconSize: compact ? 18.r : 22.r,
                              splashRadius: compact ? 18.r : 22.r,
                            )
                          : const SizedBox.shrink(),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.header.copyWith(
                            color: AppColors.white,
                            fontSize: compact ? 17.0.sp : 21.0.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: compact ? 36.w : 44.w,
                      height: compact ? 36.w : 44.w,
                      child: icon != null
                          ? IconButton(
                              onPressed: onTap,
                              icon: Icon(icon),
                              color: AppColors.white,
                              iconSize: compact ? 18.r : 22.r,
                              splashRadius: compact ? 18.r : 22.r,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: bottomHeight.h),
            ],
          ),
        ),
      ),
    );
  }
}
