import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manager/orders/orders_cubit.dart';
import 'package:west_elbalad/core/functions/build_message_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/orders/orders_view_body.dart';
import 'package:west_elbalad/features/admin/presentation/manager/used_phones/used_phones_cubit.dart';


class OrdersViewBodyBlocConsumer extends StatelessWidget {
  const OrdersViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is removeEditUsedPhonesuccess) {
          buildMessageBar(context, "تم الحذف بنجاح");
        } 
      },
      builder: (context, state) {
        if (state is OrdersSuccess) {
          return OrdersViewBody(ordersList: state.ordersList);
        } else if (state is OrdersFailure) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
