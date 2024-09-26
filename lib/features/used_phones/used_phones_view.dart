import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/add_in_store_view.dart';
import 'package:west_elbalad/features/home/domian/repos/home_repo.dart';
import 'package:west_elbalad/features/home/presentation/manager/phones_data/phones_data_cubit.dart';
import 'package:west_elbalad/features/used_phones/widgets/used_phones_bloc_consumer.dart';

class UsedPhones extends StatelessWidget {
  const UsedPhones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0.h),
        child: CustomAppBar(
          title: "الهواتف المستعملة",
          backButton: false,
          icon: Iconsax.add5,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddInStoreView(),
                settings: RouteSettings(arguments: 'مستعمل'),
              ),
            );
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => PhonesDataCubit(
          getIt<HomeRepo>(),
          getIt<Stream<QuerySnapshot>>(),
        ),
        child: const UsedPhonesBlocConsumer(),
      ),
    );
  }
}
