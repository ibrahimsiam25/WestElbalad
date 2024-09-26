import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_back_app_bar.dart';

class PhoneDetailsViewBody extends StatelessWidget {
  const PhoneDetailsViewBody({
    super.key,
    required this.phone,
  });
  final PhoneEntites phone;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomBackAppBar(
            title: "التفاصيل",
          ),
          Padding(
            padding: EdgeInsets.all(40.0.w),
            child: Center(
              child: CustomCachedImage(
                width: 220.0.w,
                imageUrl: phone.imageUrl,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(phone.name, style: AppStyles.title),
                SizedBox(height: 4.0.h),
                Text(phone.description, style: AppStyles.subtitle),
                SizedBox(height: 24.0.h),
                Text(
                  '${phone.price} جنية',
                  style: AppStyles.title.copyWith(
                    color: AppColors.red,
                    fontSize: 24.0.sp,
                  ),
                ),
                SizedBox(height: 4.0.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
