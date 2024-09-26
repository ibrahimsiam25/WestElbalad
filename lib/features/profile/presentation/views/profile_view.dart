import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:west_elbalad/features/profile/presentation/views/widgets/profile_view_body_bloc_consumer.dart';

import '../../../../core/service/get_it_service.dart';
import '../../../admin/presentation/manager/image_picker/image_picker_cubit.dart';

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
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0.h),
          child: CustomAppBar(
            title: "الملف الشخصي",
            backButton: false,
          ),
        ),
        body: const ProfileViewBodyBlocConsumer(),
      ),
    );
  }
}
