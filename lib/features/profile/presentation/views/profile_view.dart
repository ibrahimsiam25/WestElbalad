import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service/get_it_service.dart';
import '../../../admin/presentation/manager/image_picker/image_picker_cubit.dart';
import 'package:west_elbalad/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:west_elbalad/features/profile/presentation/views/widgets/profile_view_body_bloc_consumer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProfileCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ImagePickerCubit>(),
        ),
      ],
      child: Scaffold(
        body: const ProfileViewBodyBlocConsumer(),
      ),
    );
  }
}
