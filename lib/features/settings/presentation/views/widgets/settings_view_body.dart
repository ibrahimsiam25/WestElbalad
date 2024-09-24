import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/core/utils/app_router.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'الاعدادات',
          backButton: false,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              SizedBox(height: 40.0.h),
              CustomButton(
                onPressed: () async {
                  await SharedPref.setBool(kIsSigninView, false);
                  GoRouter.of(context).go(AppRouter.kSigninView);
                },
                text: 'تسجيل الخروج',
              ),
            ],
          ),
        )
      ],
    );
  }
}
