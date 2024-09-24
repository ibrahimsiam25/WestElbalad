import 'package:flutter/material.dart';
import '../../domain/repos/admin_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/features/admin/presentation/manager/remove_from_store/remove_from_store_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/remove_from_store/remove_from_store_view_body_bloc_consumer.dart';



class RemoveFromStoreView extends StatelessWidget {
  const RemoveFromStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => RemoveFromStoreCubit(getIt<AdminRepo>(),
      
        )..fetchPhonesData(),
        child: RemoveFromStoreViewBodyBlocConsumer(),
      ),
    );
  }
}