import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import '../../../../../core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/features/home/data/model/phones_model.dart';
import 'package:west_elbalad/core/widgets/custom_progress_indicator.dart';
import 'package:west_elbalad/core/functions/save_and_get_map_to_list_with_shared_pref.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/views/widgets/product_data_element.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/manager/show_oredrs/show_orders_cubit.dart';



class ShoppingCartViewBody extends StatelessWidget {
  const ShoppingCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: kHorizontalPadding,
        left: kHorizontalPadding,
        top: 64.0.h,
      ),
      child: BlocProvider(
        create: (context) => ShowOrdersCubit()..fetchOrders(),
        child: BlocBuilder<ShowOrdersCubit, ShowOrdersState>(
          builder: (context, state) {
            if (state is ShowOrdersSuccess) {
                 int totalPrice= SharedPref.getInt(kTotalPrice);
                   String totalPriceText = (totalPrice == 0 || totalPrice == -1) ? "صفر" : totalPrice.toString();
              return Column(
                children: [
                  SizedBox(height: 25.0.h),
                    Text("اجمالي سعر الطالبية: $totalPriceText",style: AppStyles.title,),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kRadius24),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: List.generate(state.orders.length, (index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: index == state.orders.length - 1
                                    ? 64.0.h
                                    : 16.0.h,
                                top: index == 0 ? 25.0.h : 0.0.h),
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
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ShowOrdersFailed) {
              return Text("حدث خطأ");
            } else {
              return CustomProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
