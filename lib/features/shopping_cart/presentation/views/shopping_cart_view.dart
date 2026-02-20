import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';

import '../../../../core/constants/app_consts.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_bottom_navigation_bar.dart';
import 'widgets/shopping_cart_view_body.dart';

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShoppingCartViewBody(),
      bottomNavigationBar: SafeArea(
        child: CustomBottomNavigationBar(
          onPressedTwo: () {
            String orders = SharedPref.getString(kOrder);
            if (orders != "") {
              GoRouter.of(context).push(AppRouter.kFinishOrderView);
            }
          },
          onPressedOne: () {
            GoRouter.of(context).go(AppRouter.kBottomNavBarController);
          },
          textTwo: "اتمام الطلب",
          iconOne: Icons.home,
          iconTwo: Icons.shopping_bag,
        ),
      ),
    );
  }
}
