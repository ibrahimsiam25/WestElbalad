import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackAppBar extends StatelessWidget {
  const CustomBackAppBar({
    super.key,
  });

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
                      size: 32.0,
                      Icons.arrow_back_ios_new)),
              Spacer(
                flex: 5,
              ),
              Text(
                "التفاصيل",
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



