import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/shopping_cart_view_body.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_bottom_navigation_bar.dart';


class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ShoppingCartViewBody(),
            bottomNavigationBar: CustomBottomNavigationBar(
        onPressedTwo: () {
        
       //   GoRouter.of(context).push(AppRouter.kShoppingCartView);
        },
        onPressedOne: () {
          GoRouter.of(context).go(AppRouter.kBottomNavBarController);
        },
        textTwo: "اتمام الطلب",
        iconOne: Icons.home,
        iconTwo: Icons.shopping_bag,
      )
    );
  }
}