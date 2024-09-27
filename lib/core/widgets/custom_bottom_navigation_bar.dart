import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onPressedOne,
    required this.onPressedTwo,
    required this.iconOne,
    required this.iconTwo,
    required this.textTwo,
  });

  final void Function() onPressedOne;
  final void Function() onPressedTwo;
  final IconData iconOne;
  final IconData iconTwo;
  final String textTwo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0.w),
      color: AppColors.white,
      child: Row(
        children: [
          InkWell(
            onTap: onPressedOne,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(kRadius24),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                iconOne,
                color: AppColors.primary,
                size: 30,
              ),
            ),
          ),
          SizedBox(width: 4.0.w),
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadius24),
                ),
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 10.0.h),
              ),
              onPressed: onPressedTwo,
              icon: Icon(iconTwo, color: AppColors.white),
              label: Text(
                textTwo,
                style: AppStyles.title.copyWith(
                  color: AppColors.white,
                  fontSize: 15.0.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
