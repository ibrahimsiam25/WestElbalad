import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/core/widgets/custom_progress_indicator.dart';
import 'package:west_elbalad/features/home/data/model/phones_model.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/manager/show_oredrs/show_orders_cubit.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/views/widgets/product_data_element.dart';

import '../../../../../core/constants/app_consts.dart';
import '../../../../../core/functions/save_and_get_map_to_list_with_shared_pref.dart';

class ShoppingCartViewBody extends StatelessWidget {
  const ShoppingCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        CustomAppBar(title: 'عربة التسوق'),
        BlocProvider(
          create: (context) => ShowOrdersCubit()..fetchOrders(),
          child: BlocBuilder<ShowOrdersCubit, ShowOrdersState>(
            builder: (context, state) {
              if (state is ShowOrdersSuccess) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
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
                          phoneEntites: state.orders[index]),
                    );
                  },
                );
              } else if (state is ShowOrdersFailed) {
                return Text("حدث خطأ");
              } else {
                return CustomProgressIndicator();
              }
            },
          ),
        )
      ],
    ));
  }
}
