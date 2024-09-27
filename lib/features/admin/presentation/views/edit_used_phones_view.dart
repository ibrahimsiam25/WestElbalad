import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/features/admin/presentation/manager/edit_used_phones/used_phones_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/used_phones/edit_used_phones_view_body_bloc_consumer.dart';

import '../../domain/repos/admin_repo.dart';

class EditUsedPhonesView extends StatelessWidget {
  const EditUsedPhonesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<EditUsedPhonesCubit>(
        create: (context) => EditUsedPhonesCubit(
          getIt<AdminRepo>(),
        )..fetchUsedPhonesData(),
        child: EditUsedPhonesViewBodyBlocConsumer(),
      ),
    );
  }
}
