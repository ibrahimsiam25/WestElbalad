import 'package:flutter/material.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/constants/app_colors.dart';

class CustomAdminViewCard extends StatelessWidget {
  const CustomAdminViewCard({
    super.key,
    required this.onPressed,
    required this.title,
  });
  final VoidCallback onPressed;

  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius24),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            title,
            style: AppStyles.title.copyWith(
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
