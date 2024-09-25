import 'package:flutter/material.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        trailing: Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(12),
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            color: AppColors.white,
          ),
          child: Icon(
            Icons.shopping_cart,
            color: AppColors.black,
            size: 20,
          ),
        ),
        leading: Image.asset(AppAssets.profile),
        title: Text(
          "صباح الخير !..",
          style: AppStyles.semiBold16.copyWith(color: AppColors.grey),
        ),
        subtitle: Text(
          "ابراهيم ثروت",
          style: AppStyles.semiBold16.copyWith(color: AppColors.black),
        ),
        //   subtitle: Text(getUser().name,
        //       style: AppStyles.semiBold16.copyWith(color: AppColors.black)),
      ),
    );
  }
}
