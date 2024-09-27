import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

import '../../../../../core/utils/app_router.dart';

class SelectedPhones extends StatelessWidget {
  final PhoneEntites phones;
  const SelectedPhones({
    super.key,
    required this.phones,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push(AppRouter.kNewPhoneDetailsView, extra: phones);
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(bottom: 16.0.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            kRadius16,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 128.0.h,
              child: CustomCachedImage(
                imageUrl: phones.imageUrl,
              ),
            ),
            SizedBox(height: 8.0.h),
            SizedBox(
              width: 128.0.w,
              child: Center(
                child: Text(
                  phones.name,
                  textAlign: TextAlign.center,
                  style: AppStyles.title.copyWith(
                    height: 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.0.h),
            SizedBox(
              width: 128.0.w,
              child: Center(
                child: Text(
                  phones.description,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.subtitle.copyWith(
                    height: 1.3,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.0.h),
            SizedBox(
              width: 128.0.w,
              child: Center(
                child: FittedBox(
                  child: Text(
                    '${phones.price} جنية',
                    style: AppStyles.title.copyWith(
                      color: AppColors.red,
                      fontSize: 18.0.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
