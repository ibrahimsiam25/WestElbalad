import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/features/admin/domain/repos/admin_repo.dart';
import 'package:west_elbalad/features/admin/presentation/manager/pending_used_phones/pending_used_phones_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/pending_used_phones/pending_used_phones_view_body.dart';

class PendingUsedPhonesView extends StatelessWidget {
  const PendingUsedPhonesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PendingUsedPhonesCubit>(
        create: (context) => PendingUsedPhonesCubit(
          getIt<AdminRepo>(),
        )..fetchPendingUsedPhones(),
        child: const PendingUsedPhonesViewBody(),
      ),
    );
  }
}
