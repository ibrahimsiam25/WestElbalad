import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';

void showDeleteConfirmationDialog(
  BuildContext context,
  String title,
  VoidCallback onConfirm,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        title: Text(
          'تأكيد الحذف!',
          textAlign: TextAlign.center,
          style: AppStyles.title.apply(
            color: AppColors.red,
          ),
        ),
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: AppStyles.semiBold16,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadius24),
              ),
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.only(bottom: 4.0.h),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              'رجوع',
              style: AppStyles.semiBold16.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadius24),
              ),
              backgroundColor: AppColors.red,
              padding: EdgeInsets.only(bottom: 4.0.h),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onConfirm(); // Confirm action
            },
            child: Text(
              'نعم',
              style: AppStyles.semiBold16.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}
