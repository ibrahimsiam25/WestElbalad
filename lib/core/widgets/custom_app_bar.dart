import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(kRadius48),
          bottomRight: Radius.circular(kRadius48),
        ),
      ),
      child: Column(
        children: [
          SafeArea(child: SizedBox(height: 16.0.h)),
          Row(
            children: [
              SizedBox(width: 24.0.w),
              backButton
                  ? InkWell(
                      onTap: () {
                        GoRouter.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                      ),
                    )
                  : SizedBox(width: 24.0.w),
              Spacer(),
              Text(
                title,
                style: AppStyles.title,
              ),
              Spacer(),
              icon != null
                  ? InkWell(
                      onTap: onTap,
                      child: Icon(
                        icon,
                      ),
                    )
                  : SizedBox(width: 24.0.w),
              SizedBox(width: 24.0.w),
            ],
          ),
          SizedBox(height: 16.0.h),
        ],
      ),
    );
  }
}

