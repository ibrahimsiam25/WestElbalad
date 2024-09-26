import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domian/repos/used_phone_repo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/manager/image_picker/image_picker_cubit.dart';
import 'package:west_elbalad/features/used_phones/presentation/manager/add_used_phone/add_used_phone_cubit.dart';
import 'package:west_elbalad/features/used_phones/presentation/views/widgets/add_used_phone_view_body_bloc_consumer.dart';



class AddUsedPhoneView extends StatelessWidget {
  const AddUsedPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddUsedPhoneCubit(

            getIt<UsedPhonesRepo>(),
            getIt<ImagePickerCubit>()
          ),
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
            title: "اضافة هاتف مستعمل",

          ),
        ),
        body: const AddUsedPhoneViewBodyBlocConsumer(),
      ),
    );
  }
}
