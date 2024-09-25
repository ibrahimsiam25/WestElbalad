import 'package:svg_flutter/svg.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/functions/get_user.dart';
import '../../../../../core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';



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
              shape: OvalBorder(), color: AppColors.white),
          child:
             Icon(Icons.shopping_cart, color: AppColors.black, size: 20)),
      leading: Image.asset(AppAssets.profile),
      title: Text("صباح الخير !..",
          style:AppStyles.semiBold16.copyWith(color: AppColors.grey)),
      subtitle: Text(getUser().name,
          style: AppStyles.semiBold16.copyWith(color: AppColors.black)),
    );
  }
}
