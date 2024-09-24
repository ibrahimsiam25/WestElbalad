import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/signin_view_body_bloc_consumer.dart';
import '../../../../core/service/get_it_service.dart';
import 'package:west_elbalad/features/auth/domain/repos/auth_repo.dart';
import 'package:west_elbalad/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        body: const SigninViewBodyBlocConsumer(),
      ),
    );
  }
}
