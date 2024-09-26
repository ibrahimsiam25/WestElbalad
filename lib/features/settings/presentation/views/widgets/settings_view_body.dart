import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/utils/app_router.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              //Logout
              CustomButton(
                backgroundColor: AppColors.green,
                onPressed: () async {
                  await SharedPref.setBool(kIsSigninView, false);
                  SharedPref.setInt("isFirstTime", -1);
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
