import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/functions/get_user.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_styles.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(12),
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: AppColors.white,
        ),
        child: GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kShoppingCartView);
          },
          child: Icon(
            Icons.shopping_cart,
            size: 25,
            color: AppColors.lightGreen,
          ),
        ),
      ),
      leading: Image.asset(AppAssets.profile),
      title: Text(
        "صباح الخير !..",
        style: AppStyles.semiBold16.copyWith(color: AppColors.grey),
      ),
      subtitle: Text(getUser().name.toString(),
          style: AppStyles.semiBold16.copyWith(color: AppColors.black)),
    );
  }
}
