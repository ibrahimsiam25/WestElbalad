import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_router.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/views/widgets/finish_order_view_body.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/manager/finish_order/finish_order_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';import 'package:west_elbalad/core/functions/build_message_bar.dart';




class FinishOrderViewBodyBlocConsumer extends StatelessWidget {
  const FinishOrderViewBodyBlocConsumer({super.key, });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FinishOrderCubit, FinishOrderState>(
      listener: (context, state) {
        if (state is FinishOrderSuccess) {
          buildMessageBar(context, "تمت عملية الشراء بنجاح");
          SharedPref.setString(kOrder, "");
          SharedPref.setInt(kTotalPrice, 0);
          GoRouter.of(context).go(AppRouter.kBottomNavBarController);
        } else if (state is FinishOrderFailure) {
          buildMessageBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is FinishOrderLoading ? true : false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                    SizedBox(height: 100.0.h),

                  FinishOrderViewBody(
                 
                  ),
                  SizedBox(height: 16.0.h),
                ],
              ),
            ));
      },
    );
  }
}
