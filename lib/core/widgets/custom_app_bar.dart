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

  const CustomAppBar({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.backButton = true,
    this.bottomHeight = 40.0,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 6.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 44.w,
                      height: 44.w,
                      child: backButton
                          ? IconButton(
                              onPressed: () {
                                context.pop();
                              },
                              icon: const BackButtonIcon(),
                              color: AppColors.white,
                              iconSize: 22.r,
                              splashRadius: 22.r,
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
                            fontSize: 21.0.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 44.w,
                      height: 44.w,
                      child: icon != null
                          ? IconButton(
                              onPressed: onTap,
                              icon: Icon(icon),
                              color: AppColors.white,
                              iconSize: 22.r,
                              splashRadius: 22.r,
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
