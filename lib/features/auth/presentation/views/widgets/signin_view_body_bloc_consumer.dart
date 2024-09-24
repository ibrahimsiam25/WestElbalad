import 'signin_view_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_router.dart';
import '../../cubits/signin_cubit/signin_cubit.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import '../../../../../core/functions/build_message_bar.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';


class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          GoRouter.of(context).go(AppRouter.kBottomNavBarController);
          SharedPref.setBool(kIsSigninView, true);
        }
        if (state is SigninFailure) {
          if (state.message == 'الايميل مسجل من قبل ولاكن لم يتحقق منه') {
            GoRouter.of(context).go(AppRouter.kVerificationView);
          }
          buildMessageBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SigninLoading ? true : false,
          child: const SigninViewBody(),
        );
      },
    );
  }
}
