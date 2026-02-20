import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';
import 'package:west_elbalad/core/utils/app_router.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import '../../../../../core/service/laumch_url_service.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          _SectionTitle(title: 'تواصل معنا'),
          SizedBox(height: 8.h),
          _ContactCard(
            svgAsset: AppAssets.faceBockIcon,
            title: 'فيسبوك',
            subtitle: 'West Elbalad',
            color: const Color(0xFF1877F2),
            onTap: () => launchCustomUr(context,
                'https://www.facebook.com/profile.php?id=61562904220255'),
          ),
          SizedBox(height: 10.h),
          _ContactCard(
            svgAsset: AppAssets.whatsappIcon,
            title: 'واتساب',
            subtitle: '01011621272',
            color: const Color(0xFF25D366),
            onTap: () =>
                launchCustomUr(context, 'https://wa.me/20${'1011621272'}'),
          ),
          SizedBox(height: 10.h),
          _ContactCard(
            svgAsset: AppAssets.callIcon,
            title: 'اتصل بنا',
            subtitle: '01000110049',
            color: AppColors.primary,
            onTap: () => callPhoneNumber('0100 011 0049'),
          ),
          SizedBox(height: 10.h),
          _ContactCard(
            svgAsset: AppAssets.googleMapsIcon,
            title: 'موقعنا على الخريطة',
            subtitle: 'اضغط لفتح خرائط جوجل',
            color: const Color(0xFFEA4335),
            onTap: () => launchCustomUr(
                context, 'https://maps.app.goo.gl/Ws9PFJ9bSDDLkcWP9'),
          ),
          SizedBox(height: 24.h),
          GestureDetector(
            onTap: () async {
              await SharedPref.setBool(kIsSigninView, false);
              SharedPref.setInt('isFirstTimeForUsedPhone', -1);
              SharedPref.setInt('isFirstTime', -1);
              GoRouter.of(context).go(AppRouter.kSigninView);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.red.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded, color: AppColors.red, size: 20.r),
                  SizedBox(width: 10.w),
                  Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 18.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ContactCard({
    required this.svgAsset,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42.r,
              height: 42.r,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgAsset,
                  width: 22.r,
                  height: 22.r,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14.r, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
