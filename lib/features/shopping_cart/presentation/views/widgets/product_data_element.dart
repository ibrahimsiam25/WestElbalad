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
    return Material(
      color: AppColors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(kRadius24),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Row(
              children: [
                Container(
                  height: 120.0.h,
                  width: 120.0.w,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0.h),
                    child: CustomCachedImage(
                      imageUrl: phoneEntites.imageUrl,
                      width: 120.0.w,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VerifiedTypeRow(type: phoneEntites.type),
                      SizedBox(height: 6.0.h),
                      Text(
                        phoneEntites.name.capitalize!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.title,
                      ),
                      SizedBox(height: 8.0.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(26),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          "${phoneEntites.price} جنية",
                          style: AppStyles.semiBold16.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 44.0.h,
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kRadius24),
                    bottomRight: Radius.circular(kRadius24),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: AppColors.white,
                    size: 22.0.r,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "حذف المنتج",
                    style: AppStyles.semiBold16.copyWith(
                      color: AppColors.white,
                      fontSize: 14.sp,
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
