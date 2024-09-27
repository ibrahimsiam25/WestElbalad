import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';
import 'package:west_elbalad/core/widgets/verified_type_row.dart';
import 'package:west_elbalad/features/admin/presentation/manager/new_phones/new_phones_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/edit_new_phones/show_edit_price_dialog.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';

import '../../../../../../core/constants/app_consts.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/show_delete_confirmation_dialog.dart';

class EditNewPhoneDataElement extends StatelessWidget {
  final PhoneEntites phoneEntites;
  const EditNewPhoneDataElement({
    super.key,
    required this.phoneEntites,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius24),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Row(
              children: [
                SizedBox(
                  width: 116.0.w,
                  height: 116.0.h,
                  child: CustomCachedImage(
                    imageUrl: phoneEntites.imageUrl,
                  ),
                ),
                SizedBox(width: 4.0.w),
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        VerifiedTypeRow(type: phoneEntites.type),
                        Text(
                          " ${phoneEntites.name}".capitalize!,
                          textAlign: TextAlign.center,
                          style: AppStyles.title,
                        ),
                        SizedBox(height: 8.0.h),
                        Text(
                          "${phoneEntites.price} جنية",
                          style: AppStyles.semiBold16.apply(
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(kRadius24),
                      ),
                    ),
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
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
                    style: AppStyles.semiBold16.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(kRadius24),
                      ),
                    ),
                    backgroundColor: AppColors.red,
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  ),
                  onPressed: () {
                    showDeleteConfirmationDialog(
                      context,
                      'هل أنت متأكد من حذف جهاز:\n ${phoneEntites.name} ؟'
                          .capitalize!,
                      () {
                        BlocProvider.of<NewPhonesCubit>(context)
                            .deleteNewPhoneData(phoneEntites.id);
                      },
                    );
                  },
                  child: Text(
                    "حذف المنتج",
                    style: AppStyles.semiBold16.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
