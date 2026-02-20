import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../domian/entities/used_phone_entities.dart';

class SelectedUsedPhones extends StatelessWidget {
  final UsedPhonesEntities phones;
  const SelectedUsedPhones({
    super.key,
    required this.phones,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push(AppRouter.kUsedPhoneDetailsView, extra: phones);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              spreadRadius: 0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image area (fixed height) ──
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: SizedBox(
                height: 130.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    CustomCachedImage(
                      imageUrl: phones.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    // Used badge
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: AppColors.red.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          'مستعمل',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ── Content ──
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      phones.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.semiBold16.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Description
                    Expanded(
                      child: Text(
                        phones.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.tiny.copyWith(
                          color: AppColors.darkGrey,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    // Price badge
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${phones.price} جنيه',
                        style: AppStyles.semiBold16.copyWith(
                          fontSize: 13.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
