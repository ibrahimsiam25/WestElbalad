import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

class CustomAdminViewCard extends StatelessWidget {
  const CustomAdminViewCard({
    super.key,
    required this.onPressed,
    required this.title,
  });
  final VoidCallback onPressed;

  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.0.h),
        padding: EdgeInsets.all(16.0.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius24),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            title,
            style: AppStyles.title.copyWith(
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
