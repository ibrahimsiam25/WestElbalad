import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/core/manager/image_picker/image_picker_cubit.dart';

import '../manager/add_in_store/edit_in_store_cubit.dart';
import 'widgets/add_in_store/add_in_store_view_body_bloc_consumer.dart';

class AddInStoreView extends StatelessWidget {
  const AddInStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AddInStoreCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ImagePickerCubit>(),
        ),
      ],
      child: Scaffold(
        body: const AddInStoreViewBodyBlocConsumer(),
      ),
    );
  }
}
