import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import 'package:west_elbalad/core/utils/app_router.dart';




class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'لا تمتلك حساب؟  ',
            style: AppStyles.semiBold16.copyWith(
              color: AppColors.black,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context).push(AppRouter.kSignupView);
              },
            text: 'قم بإنشاء حساب',
            style: AppStyles.semiBold16.copyWith(
              color: AppColors.red,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
