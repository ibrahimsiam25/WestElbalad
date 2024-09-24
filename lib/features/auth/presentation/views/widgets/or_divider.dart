import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 0,
            color: Color(0xFFDCDEDE),
          ),
        ),
        SizedBox(width: 12.0.w),
        Text(
          'أو',
          textAlign: TextAlign.center,
          style: AppStyles.semiBold16,
        ),
        SizedBox(width: 12.0.w),
        Expanded(
          child: Divider(
            height: 0,
            color: Color(0xFFDCDEDE),
          ),
        ),
      ],
    );
  }
}
