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
  const CustomAppBar({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
    this.backButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperPath(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 8.0.h),
              Row(
                children: [
                  SizedBox(width: 24.0.w),
                  backButton
                      ? InkWell(
                          onTap: () {
                            GoRouter.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 24.0.r,
                            color: AppColors.white,
                          ),
                        )
                      : SizedBox(width: 24.0.w),
                  Spacer(),
                  Text(
                    title,
                    style: AppStyles.header.copyWith(
                      color: AppColors.white,
                      fontSize: 24.0.sp,
                    ),
                  ),
                  Spacer(),
                  icon != null
                      ? InkWell(
                          onTap: onTap,
                          child: Icon(
                            icon,
                            color: AppColors.white,
                          ),
                        )
                      : SizedBox(width: 24.0.w),
                  SizedBox(width: 24.0.w),
                ],
              ),
              SizedBox(height: 40.0.h),
            ],
          ),
        ),
      ),
    );
  }
}
