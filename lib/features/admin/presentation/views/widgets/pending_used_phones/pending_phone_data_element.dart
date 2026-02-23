import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';
import 'package:west_elbalad/core/widgets/show_delete_confirmation_dialog.dart';
import 'package:west_elbalad/core/widgets/verified_type_row.dart';
import 'package:west_elbalad/features/admin/presentation/manager/pending_used_phones/pending_used_phones_cubit.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';

class PendingPhoneDataElement extends StatelessWidget {
  final UsedPhonesEntities phone;

  const PendingPhoneDataElement({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius24),
        color: AppColors.white,
        border: Border.all(color: Colors.orange.shade200, width: 1.5),
      ),
      child: Column(
        children: [
          // Phone image + info
          Padding(
            padding: EdgeInsets.only(right: 12.w, left: 12.w, top: 12.h),
            child: Row(
              children: [
                SizedBox(
                  width: 116.w,
                  height: 116.h,
                  child: CustomCachedImage(imageUrl: phone.imageUrl),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VerifiedTypeRow(type: phone.type),
                      Text(
                        phone.name.capitalize!,
                        textAlign: TextAlign.center,
                        style: AppStyles.title,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${phone.price} جنية",
                        style: AppStyles.semiBold16.apply(color: AppColors.red),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'في انتظار القبول',
                          style: AppStyles.semiBold16.copyWith(
                            color: Colors.orange.shade800,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          // Seller info
          _divider('بيانات البائع'),
          _info("اسم البائع", phone.userName),
          _info("رقم الهاتف", phone.userPhone),
          _info("المحافظة", phone.userGovernorate),
          _info("المنطقة", phone.userLocation),
          SizedBox(height: 4.h),
          _divider('معلومات الحساب'),
          _info("اسم المستخدم", phone.authUserName),
          _info("البريد الإلكتروني", phone.authUserEmail),
          SizedBox(height: 12.h),
          // Phone description
          if (phone.description.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                "الوصف: ${phone.description}",
                textAlign: TextAlign.center,
                style: AppStyles.semiBold16,
              ),
            ),
            SizedBox(height: 8.h),
          ],
          // Approve / Reject buttons
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(kRadius24),
                      ),
                    ),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  onPressed: () {
                    showDeleteConfirmationDialog(
                      context,
                      'هل تريد قبول إعلان: ${phone.name.capitalize} ؟',
                      () {
                        context
                            .read<PendingUsedPhonesCubit>()
                            .approveUsedPhone(phone.id);
                      },
                    );
                  },
                  child: Text(
                    "قبول",
                    style:
                        AppStyles.semiBold16.copyWith(color: AppColors.white),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(kRadius24),
                      ),
                    ),
                    backgroundColor: AppColors.red,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  onPressed: () {
                    showDeleteConfirmationDialog(
                      context,
                      'هل تريد رفض وحذف إعلان: ${phone.name.capitalize} ؟',
                      () {
                        context
                            .read<PendingUsedPhonesCubit>()
                            .rejectUsedPhone(phone.id);
                      },
                    );
                  },
                  child: Text(
                    "رفض وحذف",
                    style:
                        AppStyles.semiBold16.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider(String label) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Text(label, style: AppStyles.subtitle),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _info(String label, String value) {
    return Text(
      "$label : $value",
      style: AppStyles.semiBold16,
    );
  }
}
