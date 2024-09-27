import 'package:flutter/material.dart';
import '../../domain/repos/admin_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service/get_it_service.dart';
import 'package:west_elbalad/features/admin/presentation/manager/orders/orders_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/orders/orders_view_body_bloc_consumer.dart';


class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<OrdersCubit>(
        create: (context) => OrdersCubit(
          getIt<AdminRepo>(),
        )..fetchOrdersData(),
        child: OrdersViewBodyBlocConsumer(),
      ),
    );
  }
}
