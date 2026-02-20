import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/functions/save_and_get_map_to_list_with_shared_pref.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/core/widgets/custom_progress_indicator.dart';
import 'package:west_elbalad/features/home/data/model/phones_model.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/manager/show_oredrs/show_orders_cubit.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/views/widgets/product_data_element.dart';

import '../../../../../core/service/shared_preferences_singleton.dart';

class ShoppingCartViewBody extends StatelessWidget {
  const ShoppingCartViewBody({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AppBar is always outside BlocBuilder so showBackButton is
        // evaluated once from this widget's field — never stale.
        CustomAppBar(title: 'عربة التسوق', backButton: showBackButton),
        Expanded(
          child: BlocBuilder<ShowOrdersCubit, ShowOrdersState>(
            builder: (context, state) {
              if (state is ShowOrdersSuccess) {
                int totalPrice = SharedPref.getInt(kTotalPrice);
                final bool hasItems = state.orders.isNotEmpty;
                final bool showTotal = totalPrice > 0 && totalPrice != -1;

                return Column(
                  children: [
                    if (showTotal) ...[
                      SizedBox(height: 10.h),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: kHorizontalPadding),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primary.withOpacity(0.75),
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.receipt_long_rounded,
                                color: Colors.white, size: 20.r),
                            SizedBox(width: 10.w),
                            Text(
                              'إجمالي الطلب: $totalPrice جنيه',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (!hasItems)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shopping_cart_outlined,
                                  size: 64.r,
                                  color: AppColors.grey.withOpacity(0.5)),
                              SizedBox(height: 12.h),
                              Text(
                                'عربة التسوق فارغة',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: kHorizontalPadding,
                            vertical: 12.h,
                          ),
                          itemCount: state.orders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: ProductDataElement(
                                onPressed: () {
                                  removeMapFromListInSharedPref(
                                      key: kOrder,
                                      mapToRemove: PhoneModel.fromEntity(
                                              state.orders[index])
                                          .toMap());
                                  BlocProvider.of<ShowOrdersCubit>(context)
                                      .fetchOrders();
                                },
                                phoneEntites: state.orders[index],
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              } else if (state is ShowOrdersFailed) {
                return const Center(child: Text('حدث خطأ'));
              } else {
                return const CustomProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
