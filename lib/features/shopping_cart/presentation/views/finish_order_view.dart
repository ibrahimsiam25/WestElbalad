import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domian/repos/shopping_cart.repo.dart';
import '../../../../core/service/get_it_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/finish_order/finish_order_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/views/widgets/finish_order_view_body_bloc_consumer.dart';

class FinishOrderView extends StatelessWidget {
  const FinishOrderView({super.key, });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinishOrderCubit(
        getIt<ShoppingCartRepo>(),
      ),
      child: Scaffold(
        body: FinishOrderViewBodyBlocConsumer(
      
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0.h),
          child: CustomAppBar(
            title: "اتمام الطلب",
          ),
        ),
      ),
    );
  }
}
