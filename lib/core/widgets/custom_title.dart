import 'package:flutter/material.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  const CustomTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: kHorizontalPadding),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: AppStyles.title,
        ),
      ),
    );
  }
}
