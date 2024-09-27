import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';
import 'package:west_elbalad/core/widgets/verified_type_row.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

import '../../../../../../core/constants/app_consts.dart';
import '../../../../../../core/utils/app_styles.dart';

class ProductDataElement extends StatelessWidget {
  const ProductDataElement(
      {super.key, required this.phoneEntites, required this.onPressed});
  final PhoneEntites phoneEntites;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius24),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Row(
              children: [
                SizedBox(
                  height: 140.0.h,
                  width: 140.0.w,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0.h),
                      child: CustomCachedImage(
                        imageUrl: phoneEntites.imageUrl,
                        width: 140.0.w,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      VerifiedTypeRow(type: phoneEntites.type),
                      Center(
                        child: Text(
                          "${phoneEntites.name}".capitalize!,
                          textAlign: TextAlign.center,
                          style: AppStyles.title,
                        ),
                      ),
                      SizedBox(height: 4.0.h),
                      Text(
                        "${phoneEntites.price} جنية",
                        style: AppStyles.title.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.0.h,
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: AppColors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(kRadius24),
                      bottomRight: Radius.circular(kRadius24),
                    ),
                  )),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: AppColors.white,
                    size: 25.0.r,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "حذف المنتج",
                    style: AppStyles.semiBold16.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
