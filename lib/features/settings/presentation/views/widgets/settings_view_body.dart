import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/utils/app_router.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import '../../../../../core/service/laumch_url_service.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/features/auth/presentation/views/widgets/social_login_button.dart';


class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          SocialLoginButton(
              image: AppAssets.faceBockIcon,
              title: "تواصل معنا علي الفيسبوك",
              onPressed: () {
                launchCustomUr(context,
                    "https://www.facebook.com/profile.php?id=61562904220255");
              }),
              SizedBox(height: 24.0),
          SocialLoginButton(
              image: AppAssets.whatsappIcon,
              title: "تواصل معنا علي الواتساب",
              onPressed: () {
             launchCustomUr(context, 'https://wa.me/20${'1011621272'}');
              }),
                 SizedBox(height: 24.0),
          SocialLoginButton(
              image: AppAssets.googleMapsIcon,
              title: "اعثر علينا علي خرائط جوجل",
              onPressed: () {
                launchCustomUr(
                    context, "https://maps.app.goo.gl/Ws9PFJ9bSDDLkcWP9");
              }),
                 SizedBox(height: 24.0),
          SocialLoginButton(
              image: AppAssets.callIcon,
              title: "اتصل بنا على 01000110049",
              onPressed: () {
                callPhoneNumber("0100 011 0049");
              }),
          Spacer(),
          CustomButton(
            backgroundColor: AppColors.green,
            onPressed: () async {
              await SharedPref.setBool(kIsSigninView, false);
              SharedPref.setInt("isFirstTimeForUsedPhone", -1);
              SharedPref.setInt("isFirstTime", -1);
              GoRouter.of(context).go(AppRouter.kSigninView);
            },
            text: 'تسجيل الخروج',
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }
}


