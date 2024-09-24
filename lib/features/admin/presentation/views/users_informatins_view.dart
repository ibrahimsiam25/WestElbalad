import 'package:flutter/material.dart';
import '../../domain/repos/admin_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service/get_it_service.dart';
import '../manager/user_informations/user_informations_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/users_informations/users_informations_View_body_bloc_consumer.dart';

class UsersInformatinsView extends StatelessWidget {
  const UsersInformatinsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            UserInformationsCubit(getIt<AdminRepo>())..fetchUserInformations(),
        child: const UsersInformationsViewBodyBlocConsumer(),
      ),
    );
  }
}
