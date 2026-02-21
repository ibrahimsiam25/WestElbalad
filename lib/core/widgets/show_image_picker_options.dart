import 'package:flutter/material.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';

Future<dynamic> showImagePickerOptions({
  required BuildContext context,
  required VoidCallback onGalleryPressed,
  required VoidCallback onCameraPressed,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    context: context,
    builder: (context) {
      return SafeArea(
        child: Container(
          color: AppColors.white,
          padding: EdgeInsets.all(12.0.r),
          child: Wrap(
            children: [
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(top: 4.0.h),
                  child: const Icon(
                    Icons.photo_library,
                    size: 28,
                  ),
                ),
                title: Text(
                  'فتح معرض الصور',
                  style: AppStyles.subtitle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  onGalleryPressed();
                },
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(top: 4.0.h),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 28,
                  ),
                ),
                title: Text(
                  'فتح الكاميرا',
                  style: AppStyles.subtitle,
                ),
                onTap: () {
                  Navigator.pop(context); // Close bottom sheet before action
                  onCameraPressed();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
