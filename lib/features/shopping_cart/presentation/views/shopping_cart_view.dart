import 'package:flutter/material.dart';
import 'widgets/shopping_cart_view_body.dart';


class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ShoppingCartViewBody(),
    );
  }
}