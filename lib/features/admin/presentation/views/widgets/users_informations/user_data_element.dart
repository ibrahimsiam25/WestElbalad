import 'package:flutter/material.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/features/admin/domain/entities/user_informations_entites.dart';

class UserDataElement extends StatelessWidget {
  const UserDataElement({
    super.key,
    required this.user,
  });

  final UserInformationsEntity user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius24),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            user.name,
            style: AppStyles.title.copyWith(
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 4.0.h),
          Text(
            user.email,
            style: AppStyles.semiBold16.copyWith(
              color: AppColors.green,
            ),
          ),
        ],
      ),
    );
  }
}
