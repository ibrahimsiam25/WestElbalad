import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';

class VerifiedTypeRow extends StatelessWidget {
  final String type;
  const VerifiedTypeRow({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.verify5,
            color: AppColors.blueAccent,
            size: 12.0.r,
          ),
          SizedBox(width: 2.0.w),
          Text(
            type.toUpperCase(),
            style: AppStyles.semiBold16.copyWith(
              fontSize: 12.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}
