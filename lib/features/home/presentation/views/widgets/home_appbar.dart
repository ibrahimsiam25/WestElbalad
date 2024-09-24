import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
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
          Align(
            child: Text(
              'تصفح الأجهزة المتاحة',
              style: AppStyles.title,
            ),
          ),
          SizedBox(height: 16.0.h),
        ],
      ),
    );
  }
}
