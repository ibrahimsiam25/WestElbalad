import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/constants/app_consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';




class ProductDataElement extends StatelessWidget {
  const ProductDataElement({super.key, required this.phoneEntites, required this. onPressed});
  final PhoneEntites phoneEntites;
  final void Function()  onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0.h),
      margin: EdgeInsets.symmetric(vertical: 8.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius24),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: phoneEntites.imageUrl,
            height: 128.0.h,
            placeholder: (context, url) => Skeletonizer(
              containersColor: AppColors.darkGrey,
              child: Container(
                width: 128.0.w,
                height: 128.0.h,
                color: AppColors.white,
              ),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
            ),
          ),
          SizedBox(height: 16.0.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "النوع:    ${phoneEntites.type}".toUpperCase(),
              style: AppStyles.semiBold16,
            ),
          ),
          SizedBox(height: 8.0.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "الاسم:   ${phoneEntites.name}",
              style: AppStyles.semiBold16,
            ),
          ),
          SizedBox(height: 8.0.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "السعر:   ${phoneEntites.price}",
              style: AppStyles.semiBold16,
            ),
          ),
          SizedBox(height: 8.0.h),

          SizedBox(height: 20.0.h),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize:
                    Size(MediaQuery.of(context).size.width * 0.3, 40.h),
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              ),
              onPressed: onPressed ,
              child: Text(
                "حذف المنتج",
                style: AppStyles.semiBold16.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
