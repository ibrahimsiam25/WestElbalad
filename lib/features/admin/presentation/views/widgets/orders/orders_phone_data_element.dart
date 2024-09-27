import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/widgets/custom_cacehd_network_image.dart';

import '../../../../../../core/constants/app_consts.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/show_delete_confirmation_dialog.dart';
import '../../../../../shopping_cart/data/model/user_info_for_order_model.dart';
import '../../../manager/orders/orders_cubit.dart';

class OrderDataElement extends StatelessWidget {
  final UserInfoForOrderModel orderEntities;

  const OrderDataElement({
    Key? key,
    required this.orderEntities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius24),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 16.0.h),
          Text("المنتجات المطلوبة", style: AppStyles.title),
          SizedBox(height: 16.0.h),
          //Orders
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: orderEntities.lsitOfOrder.length,
            itemBuilder: (context, index) {
              final order = orderEntities.lsitOfOrder[index];
              return ListTile(
                title: Text(
                  order.name.capitalize!,
                  style: AppStyles.semiBold16,
                ),
                subtitle: Text(
                  "${order.price} جنية",
                  style: AppStyles.subtitle.copyWith(
                    color: AppColors.red,
                  ),
                ),
                leading: CustomCachedImage(
                  imageUrl: order.imageUrl,
                  width: 80.0.w,
                ),
              );
            },
          ),
          SizedBox(height: 16.0.h),
          //User auth date
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(),
              ),
              Padding(
                padding:
                    EdgeInsets.only(right: 8.0.w, left: 8.0.w, bottom: 4.0.h),
                child: Text('ملومات تسجيل الدخول', style: AppStyles.subtitle),
              ),
              Expanded(
                child: Divider(),
              ),
            ],
          ),
          Text(
            orderEntities.authUserName,
            style: AppStyles.semiBold16,
          ),
          Text(
            orderEntities.authUserEmail,
            style: AppStyles.semiBold16,
          ),
          SizedBox(height: 8.0.h),
          //User order date
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(),
              ),
              Padding(
                padding:
                    EdgeInsets.only(right: 8.0.w, left: 8.0.w, bottom: 4.0.h),
                child: Text('تفاصيل الطلبية', style: AppStyles.subtitle),
              ),
              Expanded(
                child: Divider(),
              ),
            ],
          ),
          Text(
            "اسم المستخدم : ${orderEntities.userName}",
            style: AppStyles.semiBold16,
          ),
          Text(
            "رقم الهاتف : ${orderEntities.userPhone}",
            style: AppStyles.semiBold16,
          ),
          Text(
            "المحافظة : ${orderEntities.userGovernorate}",
            style: AppStyles.semiBold16,
          ),
          Text(
            "المنطقة : ${orderEntities.userLocation}",
            style: AppStyles.semiBold16,
          ),
          SizedBox(height: 12.0.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'اجمالي السعر : ${orderEntities.totalPrice} جنية',
              style: AppStyles.title.copyWith(
                color: AppColors.red,
              ),
            ),
          ),
          SizedBox(height: 12.0.h),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(kRadius24),
                    bottomRight: Radius.circular(kRadius24),
                  ),
                ),
                backgroundColor: AppColors.red,
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
              ),
              onPressed: () {
                showDeleteConfirmationDialog(
                  context,
                  'هل انت متاكد منحذف طالبية\n ${orderEntities.userName}?',
                  () {
                    BlocProvider.of<OrdersCubit>(context)
                        .deleteOrderData(orderEntities.id);
                  },
                );
              },
              child: Text(
                "حذف الطلبية",
                style: AppStyles.semiBold16.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
