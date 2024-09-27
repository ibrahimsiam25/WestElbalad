import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class NewPhoneDetailsViewBody extends StatelessWidget {
  const NewPhoneDetailsViewBody({
    super.key,
    required this.phone,
  });
  final PhoneEntites phone;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 260.0.h,
          child: Padding(
            padding: EdgeInsets.all(40.0.w),
            child: Center(
              child: CustomCachedImage(
                width: 220.0.w,
                imageUrl: phone.imageUrl,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 24.0.h,
          child: Center(
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
                  "${phone.type}".toUpperCase(),
                  style: AppStyles.semiBold16.copyWith(
                    fontSize: 12.0.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 4.0.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(phone.name.capitalize!, style: AppStyles.title),
              SizedBox(height: 4.0.h),
              SizedBox(
                width: 300.0.w,
                child: Text(
                  phone.description,
                  textAlign: TextAlign.center,
                  style: AppStyles.subtitle,
                ),
              ),
              SizedBox(height: 16.0.h),
              Text(
                '${phone.price} جنية',
                style: AppStyles.title.copyWith(
                  color: AppColors.red,
                  fontSize: 24.0.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0.h),
      ],
    );
  }
}
