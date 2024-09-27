import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/functions/save_and_get_map_to_list_with_shared_pref.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/core/widgets/custom_progress_indicator.dart';
import 'package:west_elbalad/features/home/data/model/phones_model.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/manager/show_oredrs/show_orders_cubit.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/views/widgets/product_data_element.dart';

import '../../../../../core/service/shared_preferences_singleton.dart';
import '../../../../../core/utils/app_styles.dart';

class ShoppingCartViewBody extends StatelessWidget {
  const ShoppingCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowOrdersCubit()..fetchOrders(),
      child: BlocBuilder<ShowOrdersCubit, ShowOrdersState>(
        builder: (context, state) {
          if (state is ShowOrdersSuccess) {
            int totalPrice = SharedPref.getInt(kTotalPrice);
            String totalPriceText = (totalPrice == 0 || totalPrice == -1)
                ? "صفر"
                : totalPrice.toString();
            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    title: "عربة التسوق",
                  ),
                  Text(
                    "اجمالي سعر الطلب: $totalPriceText",
                    style: AppStyles.title,
                  ),
                  ...List.generate(state.orders.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.0.h,
                        top: index == 0 ? 12.0.h : 0.0.h,
                        right: kHorizontalPadding,
                        left: kHorizontalPadding,
                      ),
                      child: ProductDataElement(
                        onPressed: () {
                          removeMapFromListInSharedPref(
                              key: kOrder,
                              mapToRemove:
                                  PhoneModel.fromEntity(state.orders[index])
                                      .toMap());
                          BlocProvider.of<ShowOrdersCubit>(context)
                              .fetchOrders();
                        },
                        phoneEntites: state.orders[index],
                      ),
                    );
                  }),
                ],
              ),
            );
          } else if (state is ShowOrdersFailed) {
            return Text("حدث خطأ");
          } else {
            return CustomProgressIndicator();
          }
        },
      ),
    );
  }
}
