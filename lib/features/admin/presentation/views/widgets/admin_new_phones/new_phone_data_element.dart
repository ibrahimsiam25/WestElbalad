import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/features/admin/presentation/manager/new_phones/new_phones_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/admin_new_phones/show_edit_price_dialog.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

import '../../../../../../core/constants/app_consts.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/show_delete_confirmation_dialog.dart';

class PhoneDataElement extends StatelessWidget {
  const PhoneDataElement({super.key, required this.phoneEntites});
  final PhoneEntites phoneEntites;

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
              "اسم الشركة:    ${phoneEntites.type}".toUpperCase(),
              style: AppStyles.semiBold16,
            ),
          ),
          SizedBox(height: 8.0.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "نوع الهاتف:   ${phoneEntites.name}",
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
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "الوصف:   ${phoneEntites.description}",
              style: AppStyles.semiBold16,
            ),
          ),
          SizedBox(height: 20.0.h),
          Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.3, 40.h),
                  backgroundColor: AppColors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                ),
                onPressed: () {
                  showEditPriceDialog(
                      context: context,
                      onPriceSaved: (price) {
                        BlocProvider.of<NewPhonesCubit>(context)
                            .editPrice(phoneEntites.id, price);
                      });
                },
                child: Text(
                  "تعديل السعر",
                  style: AppStyles.semiBold16.copyWith(color: AppColors.white),
                ),
              ),
              Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.3, 40.h),
                  backgroundColor: AppColors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                ),
                onPressed: () {
                  showDeleteConfirmationDialog(
                    context,
                    'هل أنت متأكد من حذف ${phoneEntites.name}  ${phoneEntites.type} ؟',
                    () {
                      BlocProvider.of<NewPhonesCubit>(context)
                          .deleteNewPhoneData(phoneEntites.id);
                    },
                  );
                },
                child: Text(
                  "حذف المنتج",
                  style: AppStyles.semiBold16.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
