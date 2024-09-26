import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_router.dart';
import '../../domian/repos/used_phone_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/utils/backend_endpoints.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import '../manager/fetch_used_phone/fetch_used_phone_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/add_in_store_view.dart';
import 'package:west_elbalad/features/used_phones/presentation/views/widgets/used_phones_bloc_consumer.dart';




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
            GoRouter.of(context).push(AppRouter.kAddUsedPhoneView);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => FetchUsedPhoneCubit(
          getIt<UsedPhonesRepo>(),
          getIt<Stream<QuerySnapshot>>(instanceName: BackendEndpoint.usedPhones),
        ),
        child: const UsedPhonesBlocConsumer(),
      ),
    );
  }
}
