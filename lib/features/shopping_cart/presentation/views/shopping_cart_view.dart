import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';

import '../../../../core/constants/app_consts.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_bottom_navigation_bar.dart';
import '../manager/show_oredrs/show_orders_cubit.dart';
import 'widgets/shopping_cart_view_body.dart';

class ShoppingCartView extends StatelessWidget {
  /// Set [showBackBar] to false when embedding inside a BottomNavigationBar
  /// so the back/home action bar is not shown.
  const ShoppingCartView({super.key, this.showBackBar = true});

  final bool showBackBar;

  @override
  Widget build(BuildContext context) {
    print(SharedPref.getString(kOrder));
    return BlocProvider(
      create: (context) => ShowOrdersCubit()..fetchOrders(),
      child: Scaffold(
        body: ShoppingCartViewBody(showBackButton: showBackBar),
        bottomNavigationBar: BlocBuilder<ShowOrdersCubit, ShowOrdersState>(
          builder: (context, state) {
            final bool hasOrders =
                state is ShowOrdersSuccess && state.orders.isNotEmpty;

            return SafeArea(
              child: Visibility(
                visible: hasOrders,
                child: CustomBottomNavigationBar(
                  onPressedTwo: () {
                    String orders = SharedPref.getString(kOrder);
                    if (orders != "") {
                      GoRouter.of(context).push(AppRouter.kFinishOrderView);
                    }
                  },
                  onPressedOne: () {
                    if (showBackBar) {
                      GoRouter.of(context)
                          .go(AppRouter.kBottomNavBarController);
                    }
                  },
                  textTwo: "اتمام الطلب",
                  iconOne: showBackBar ? Icons.home : Icons.receipt,
                  iconTwo: Icons.shopping_bag,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
