import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';

abstract class AppStyles {
  static TextStyle header = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 26.sp,
    letterSpacing: 0.0,
    color: AppColors.black,
  );
  static TextStyle title = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    letterSpacing: 0.0,
    color: AppColors.black,
  );
  static TextStyle subtitle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    letterSpacing: 0.0,
    color: AppColors.black,
  );
  static TextStyle tiny = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    letterSpacing: 0.0,
    color: AppColors.black,
  );
  static TextStyle semiBold16 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0.sp,
    letterSpacing: 0.0,
    color: AppColors.black,
  );
}
