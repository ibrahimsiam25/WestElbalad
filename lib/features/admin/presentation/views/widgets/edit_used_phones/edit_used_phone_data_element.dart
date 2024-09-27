import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/constants/app_consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/widgets/verified_type_row.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';
import '../../../../../../core/widgets/show_delete_confirmation_dialog.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';
import 'package:west_elbalad/features/admin/presentation/manager/used_phones/used_phones_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/edit_new_phones/show_edit_price_dialog.dart';


class EditUsedPhoneDataElement extends StatelessWidget {
  final UsedPhonesEntities phoneEntites;
  const EditUsedPhoneDataElement({
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
            padding: EdgeInsets.only(right: 12.0.w, left: 12.0.w, top: 12.0.h),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 4.0),
                  child: Text('بيانات البائع', style: AppStyles.subtitle),
                ),
                Expanded(
                  child: Divider(),
                ),
              ],
            ),
          ),
          Text(
            phoneEntites.userName,
            style: AppStyles.semiBold16,
          ),
          Text(
            phoneEntites.userPhone,
            style: AppStyles.semiBold16,
          ),
          Text(
            phoneEntites.authUserEmail,
            style: AppStyles.semiBold16,
          ),
          Text(
            phoneEntites.authUserName,
            style: AppStyles.semiBold16,
          ),
          Text(
            phoneEntites.userLocation,
            style: AppStyles.semiBold16,
          ),
          Text(
            phoneEntites.userGovernorate,
            style: AppStyles.semiBold16,
          ),
          SizedBox(height: 12.0.h),
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
                          BlocProvider.of<EditUsedPhonesCubit>(context)
                              .editUsedPhonesPrice(phoneEntites.id, price);
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
                        BlocProvider.of<EditUsedPhonesCubit>(context)
                            .deleteUsedPhoneData(phoneEntites.id);
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
