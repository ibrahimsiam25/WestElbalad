import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/utils/app_router.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';

class SignUpSuccessfully extends StatelessWidget {
  const SignUpSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16.0.h),
                  Text(
                    'تم التسجيل بنجاح',
                    style: AppStyles.title,
                  ),
                  Spacer(),
                  Image.asset(
                    width: 200.0.w,
                    AppAssets.successfull,
                  ),
                  Spacer(),
                  CustomButton(
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      GoRouter.of(context).go(AppRouter.kSigninView);
                    },
                    text: 'تسجيل الدخول',
                  ),
                  SizedBox(height: 16.0.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
