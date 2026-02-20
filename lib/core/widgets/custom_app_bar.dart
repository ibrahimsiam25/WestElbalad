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
              SizedBox(height: 8.0.h),
              Row(
                children: [
                  SizedBox(width: 24.0.w),
                  if (backButton)
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 24.0.r,
                        color: AppColors.white,
                      ),
                    )
                  else
                    SizedBox(width: 24.0.w),
                  const Spacer(),
                  Text(
                    title,
                    style: AppStyles.header.copyWith(
                      color: AppColors.white,
                      fontSize: 22.0.sp,
                    ),
                  ),
                  const Spacer(),
                  if (icon != null)
                    InkWell(
                      onTap: onTap,
                      child: Icon(
                        icon,
                        color: AppColors.white,
                        size: 24.0.h,
                      ),
                    )
                  else
                    SizedBox(width: 24.0.w),
                  SizedBox(width: 24.0.w),
                ],
              ),
              SizedBox(height: bottomHeight.h),
            ],
          ),
        ),
      ),
    );
  }
}
