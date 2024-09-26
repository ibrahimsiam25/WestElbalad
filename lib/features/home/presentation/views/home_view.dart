import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/features/home/domian/repos/home_repo.dart';
import 'package:west_elbalad/features/home/presentation/manager/phones_data/phones_data_cubit.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/phones_bloc_consumer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140.0.h),
        child: CustomHomeAppBar(),
      ),
      body: BlocProvider(
        create: (context) => PhonesDataCubit(
          getIt<HomeRepo>(),
          getIt<Stream<QuerySnapshot>>(),
        ),
        child: const PhonesBlocConsumer(),
      ),
    );
  }
}
