import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:west_elbalad/core/utils/app_router.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
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
                launchCustomUr(context, 'https://wa.me/01000110049');
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
                callPhoneNumber("01000110049");
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

Future<void> launchCustomUr(context, String? url) async {
  if (url != null) {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {}
  }
}

void callPhoneNumber(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $phoneNumber';
  }
}
