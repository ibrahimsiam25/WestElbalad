import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';

class PhonesGridSkeleton extends StatelessWidget {
  const PhonesGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: AppColors.grey.withOpacity(0.3),
        highlightColor: AppColors.white,
        duration: const Duration(milliseconds: 1200),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 16.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            mainAxisExtent: 240.h,
          ),
          itemCount: 6,
          itemBuilder: (context, _) => const _PhoneCardSkeleton(),
        ),
      ),
    );
  }
}

class _PhoneCardSkeleton extends StatelessWidget {
  const _PhoneCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Container(
              height: 130.h,
              width: double.infinity,
              color: AppColors.grey.withOpacity(0.4),
            ),
          ),
          // Content placeholder
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Container(
                    height: 14.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Description line 1
                  Container(
                    height: 10.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Description line 2
                  Container(
                    height: 10.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  const Spacer(),
                  // Price badge
                  Container(
                    height: 26.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
