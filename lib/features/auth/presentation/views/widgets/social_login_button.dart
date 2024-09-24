import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:flutter/material.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import '../../../../../core/utils/app_styles.dart';

class SocialLoginButton extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onPressed;
  const SocialLoginButton({
    super.key,
    required this.image,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.0.h,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0xFFDCDEDE),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(kRadius16),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              height: 24.0.h,
              image,
            ),
            SizedBox(width: 16.0.w),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyles.semiBold16,
            ),
          ],
        ),
      ),
    );
  }
}
