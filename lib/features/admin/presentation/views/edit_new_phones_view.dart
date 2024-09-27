import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/features/admin/presentation/manager/new_phones/new_phones_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/new_phones/edit_new_phones_view_body_bloc_consumer.dart';

import '../../domain/repos/admin_repo.dart';

class EditNewPhonesView extends StatelessWidget {
  const EditNewPhonesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NewPhonesCubit>(
        create: (context) => NewPhonesCubit(
          getIt<AdminRepo>(),
        )..fetchNewPhonesData(),
        child: EditNewPhonesViewBodyBlocConsumer(),
      ),
    );
  }
}
