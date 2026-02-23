import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:svg_flutter/svg.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/service/laumch_url_service.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class UsedPhonesDetailsViewBody extends StatelessWidget {
  const UsedPhonesDetailsViewBody({
    super.key,
    required this.phone,
  });
  final UsedPhonesEntities phone;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
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
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: AppColors.red.withAlpha(31),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'مستعمل',
                          style: AppStyles.tiny.copyWith(
                            color: AppColors.red,
                            fontWeight: FontWeight.w600,
                          ),
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
                  SizedBox(height: 16.h),
                  // Contact section
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(13),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                          color: AppColors.primary.withAlpha(51), width: 1),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '📞 للاستفسار عن السعر أو الشراء',
                          textAlign: TextAlign.center,
                          style: AppStyles.semiBold16.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'تواصل مع المحل مباشرةً عبر واتساب أو الاتصال',
                          textAlign: TextAlign.center,
                          style: AppStyles.subtitle.copyWith(
                            color: AppColors.darkGrey,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _ContactButton(
                          svgAsset: AppAssets.whatsappIcon,
                          label: 'واتساب',
                          color: const Color(0xFF25D366),
                          onTap: () => launchCustomUr(
                              context, 'https://wa.me/201000110049'),
                        ),
                             SizedBox(height: 8.h),
                        _ContactButton(
                          svgAsset: AppAssets.callIcon,
                          label: '01000110049',
                          color: AppColors.primary,
                          onTap: () => callPhoneNumber('01000110049'),
                        ),
                        SizedBox(height: 8.h),
                        _ContactButton(
                          svgAsset: AppAssets.faceBockIcon,
                          label: 'West Elbalad على فيسبوك',
                          color: const Color(0xFF1877F2),
                          onTap: () => launchCustomUr(context,
                              'https://www.facebook.com/profile.php?id=61562904220255'),
                        ),
                      
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
       SizedBox(height: 120.h),
       
      ],

    );
  }
}

class _ContactButton extends StatelessWidget {
  final String svgAsset;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ContactButton({
    required this.svgAsset,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: color.withAlpha(26),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withAlpha(77), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(svgAsset, width: 18.r, height: 18.r),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                label,
                 maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
             
                 
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
