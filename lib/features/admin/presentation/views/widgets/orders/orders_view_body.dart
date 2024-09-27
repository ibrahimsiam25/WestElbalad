import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/orders/orders_phone_data_element.dart';


class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key, required this.ordersList});
  final List ordersList;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(title: "الطلبات"),
          ...List.generate(ordersList.length, (index) {
            final order = ordersList[index];
            return Padding(
              padding: EdgeInsets.only(
                right: kHorizontalPadding,
                left: kHorizontalPadding,
                bottom: kVerticalPadding,
              ),
              child: OrderDataElement(orderEntities: order),
            );
          })
        ],
      ),
    );
  }
}
