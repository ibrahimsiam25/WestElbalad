import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/features/used_phones/presentation/views/widgets/used_phones_bloc_consumer.dart';

import '../../../../core/utils/backend_endpoints.dart';
import '../../domian/repos/used_phone_repo.dart';
import '../manager/fetch_used_phone/fetch_used_phone_cubit.dart';

class UsedPhones extends StatelessWidget {
  const UsedPhones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<FetchUsedPhoneCubit>(
        create: (context) => FetchUsedPhoneCubit(
          getIt<UsedPhonesRepo>(),
          getIt<Stream<QuerySnapshot>>(
            instanceName: BackendEndpoint.usedPhones,
          ),
        ),
        child: const UsedPhonesBlocConsumer(),
      ),
    );
  }
}
