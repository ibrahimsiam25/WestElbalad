import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/constants/app_colors.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'تمتلك حساب بالفعل ؟  ',
            style: AppStyles.semiBold16.copyWith(
              color: AppColors.black,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
            text: 'تسجيل الدخول',
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
