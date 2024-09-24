import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/signup_view_body_bloc_consumer.dart';
import '../../../../core/service/get_it_service.dart';
import 'package:west_elbalad/features/auth/domain/repos/auth_repo.dart';
import 'package:west_elbalad/features/auth/presentation/cubits/signup_cubits/signup_cubit.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt<AuthRepo>(),
      ),
      child: Scaffold(
        body: const SignupViewBodyBlocConsumer(),
      ),
    );
  }
}
