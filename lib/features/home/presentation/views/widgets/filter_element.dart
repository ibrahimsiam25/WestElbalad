import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';

class FilterElement extends StatelessWidget {
  final String text;
  final Color color;
  FilterElement({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = color == AppColors.primary;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 6.0.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.white,
        border: Border.all(
          width: 1,
          color: isSelected ? AppColors.primary : AppColors.grey,
        ),
        borderRadius: BorderRadius.circular(kRadius24),
      ),
      child: Center(
        child: Text(
          text.toUpperCase(),
          style: AppStyles.semiBold16.copyWith(
            height: 1.2,
            fontSize: 13.sp,
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
