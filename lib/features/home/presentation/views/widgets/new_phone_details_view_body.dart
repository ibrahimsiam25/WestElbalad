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
      padding: EdgeInsets.zero,
      children: [
        // Space for the clipped app bar (Scaffold uses extendBodyBehindAppBar).
        SizedBox(height: 104.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Material(
            color: AppColors.white,
            elevation: 2,
            borderRadius: BorderRadius.circular(kRadius24),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 230.h,
                    child: Center(
                      child: CustomCachedImage(
                        width: 240.w,
                        imageUrl: phone.imageUrl,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.verify5,
                        color: AppColors.blueAccent,
                        size: 14.0.r,
                      ),
                      SizedBox(width: 4.0.w),
                      Text(
                        phone.type.toUpperCase(),
                        style: AppStyles.semiBold16.copyWith(
                          fontSize: 12.0.sp,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Material(
            color: AppColors.white,
            elevation: 2,
            borderRadius: BorderRadius.circular(kRadius24),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    phone.name.capitalize!,
                    textAlign: TextAlign.center,
                    style: AppStyles.title,
                  ),
                  SizedBox(height: 6.0.h),
                  Text(
                    phone.description,
                    textAlign: TextAlign.center,
                    style: AppStyles.subtitle.copyWith(
                      color: AppColors.darkGrey,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 14.0.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(26),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Text(
                      '${phone.price} جنية',
                      style: AppStyles.title.copyWith(
                        color: AppColors.primary,
                        fontSize: 22.0.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Room for bottom bar.
        SizedBox(height: 110.h),
      ],
    );
  }
}
