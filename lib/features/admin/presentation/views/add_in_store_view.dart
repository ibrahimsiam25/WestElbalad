import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/manager/image_picker/image_picker_cubit.dart';

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
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0.h),
          child: CustomAppBar(
            title: "اضافة منتج جديد",
          ),
        ),
        body: const AddInStoreViewBodyBlocConsumer(),
      ),
    );
  }
}
