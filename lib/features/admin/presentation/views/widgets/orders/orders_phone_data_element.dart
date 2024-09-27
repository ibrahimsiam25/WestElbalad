import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manager/orders/orders_cubit.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/constants/app_consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import '../../../../../../core/widgets/show_delete_confirmation_dialog.dart';
import '../../../../../shopping_cart/data/model/user_info_for_order_model.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
            child: Row(
              children: [
                // User Avatar or Image Placeholder
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('ملومات تسجيل الدخول', style: AppStyles.subtitle),
                ),
                Expanded(
                  child: Divider(),
                ),
              ],
            ),
          ),
          Text(
            orderEntities.authUserName,
            style: AppStyles.semiBold16,
          ),
          Text(
            orderEntities.authUserEmail,
            style: AppStyles.semiBold16,
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('تفاصيل الطلبية', style: AppStyles.subtitle),
                ),
                Expanded(
                  child: Divider(),
                ),
              ],
            ),
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
              'اجمالي سعر الطلب : ${orderEntities.totalPrice} جنية',
              style: AppStyles.semiBold16.copyWith(color: AppColors.red),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("المنتجات المطلوبة", style: AppStyles.subtitle),
                ),
                Expanded(
                  child: Divider(),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true, // Allows the ListView to be inside a column
            physics: NeverScrollableScrollPhysics(), // Disable scrolling
            itemCount: orderEntities.lsitOfOrder.length,
            itemBuilder: (context, index) {
              final order = orderEntities.lsitOfOrder[index];
              return ListTile(
                title: Text(order.name ,style: AppStyles.subtitle ,), // Name of the product
                trailing: Text("${order.price} جنية",style:  AppStyles.subtitle.copyWith(color: AppColors.primary) ), // Price of the product
              );
            },
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
                        bottomLeft: Radius.circular(kRadius24),
                      ),
                    ),
                    backgroundColor: AppColors.primary,
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
        ],
      ),
    );
  }
}
