import 'package:flutter/material.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';

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
          'تأكيد الحذف',
          style: AppStyles.title,
        ),
        content: Text(
          title,
          style: AppStyles.semiBold16.copyWith(
            color: AppColors.red,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('رجوع'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onConfirm(); // Confirm action
            },
            child: Text('نعم'),
          ),
        ],
      );
    },
  );
}
