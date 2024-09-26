import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/functions/build_message_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/phone_data/remove_from_store_view_body.dart';

import '../../../manager/remove_from_store/remove_from_store_cubit.dart';

class RemoveFromStoreViewBodyBlocConsumer extends StatelessWidget {
  const RemoveFromStoreViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoveFromStoreCubit, RemoveFromStoreState>(
      listener: (context, state) {
        if (state is removePhoneSuccess) {
          buildMessageBar(context, "تم الحذف بنجاح");
        } else if (state is editPriceSuccess) {
          buildMessageBar(context, "تم تعديل السعر بنجاح");
        }
      },
      builder: (context, state) {
        if (state is RemoveFromStoreSuccess) {
          return RemoveFromStoreViewBody(phonesList: state.phonesList);
        } else if (state is RemoveFromStoreFailure) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
