import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/functions/save_and_get_map_to_list_with_shared_pref.dart';
import 'package:west_elbalad/core/widgets/custom_progress_indicator.dart';
import 'package:west_elbalad/features/home/data/model/phones_model.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/manager/show_oredrs/show_orders_cubit.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/views/widgets/product_data_element.dart';

class ShoppingCartViewBody extends StatelessWidget {
  const ShoppingCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: BlocProvider(
        create: (context) => ShowOrdersCubit()..fetchOrders(),
        child: BlocBuilder<ShowOrdersCubit, ShowOrdersState>(
          builder: (context, state) {
            if (state is ShowOrdersSuccess) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(kRadius24),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: List.generate(state.orders.length, (index) {
                    return ProductDataElement(
                      onPressed: () {
                        removeMapFromListInSharedPref(
                            key: kOrder,
                            mapToRemove:
                                PhoneModel.fromEntity(state.orders[index])
                                    .toMap());
                        BlocProvider.of<ShowOrdersCubit>(context).fetchOrders();
                      },
                      phoneEntites: state.orders[index],
                    );
                  }),
                ),
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
