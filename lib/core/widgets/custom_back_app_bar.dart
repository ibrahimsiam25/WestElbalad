import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class CustomBackAppBar extends StatelessWidget {
  const CustomBackAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          SizedBox(height: 32.0.h),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    color: AppColors.primary,
                    size: 24.0.w,
                    Icons.arrow_back_ios_new,
                  )),
              Spacer(
                flex: 5,
              ),
              Text(
                title,
                style: AppStyles.title.copyWith(color: AppColors.primary),
              ),
              Spacer(
                flex: 7,
              ),
            ],
          ),
          SizedBox(height: 10.0.h),
        ],
      ),
    );
  }
}
