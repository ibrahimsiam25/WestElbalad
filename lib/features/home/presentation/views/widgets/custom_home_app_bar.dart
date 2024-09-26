import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/widgets/custom_clippath.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_styles.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperPath(),
      child: Container(
        color: AppColors.lightGreen,
        child: Center(
          child: ListTile(
            trailing: Container(
              width: 40.0.w,
              height: 40.0.w,
              padding: const EdgeInsets.all(12),
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: AppColors.white,
              ),
              child: Center(
                child: InkWell(
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
            ),
            leading: Image.asset(AppAssets.profile),
            title: Text(
              "صباح الخير !..",
              style: AppStyles.semiBold16.copyWith(color: AppColors.white),
            ),
            subtitle: Text('ابراهيم ثروت',
                style: AppStyles.title.copyWith(color: AppColors.white)),
          ),
        ),
      ),
    );
  }
}
