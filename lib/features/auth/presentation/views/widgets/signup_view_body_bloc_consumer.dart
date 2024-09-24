import 'signup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_router.dart';
import '../../cubits/signup_cubits/signup_cubit.dart';
import '../../../../../core/functions/build_message_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          GoRouter.of(context).go(AppRouter.kVerificationView);
        }
        if (state is SignupFailure) {
          if (state.message == 'الايميل مسجل من قبل ولاكن لم يتحقق منه') {
            GoRouter.of(context).go(AppRouter.kVerificationView);
          }
          buildMessageBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading ? true : false,
          child: const SignupViewBody(),
        );
      },
    );
  }
}
