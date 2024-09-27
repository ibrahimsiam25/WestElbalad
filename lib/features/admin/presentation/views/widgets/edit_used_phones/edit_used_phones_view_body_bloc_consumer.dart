import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/functions/build_message_bar.dart';
import 'package:west_elbalad/features/admin/presentation/manager/used_phones/used_phones_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/edit_used_phones/edit_used_phones_view_body.dart';

class EditUsedPhonesViewBodyBlocConsumer extends StatelessWidget {
  const EditUsedPhonesViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditUsedPhonesCubit, EditUsedPhonesState>(
      listener: (context, state) {
        if (state is removeEditUsedPhonesuccess) {
          buildMessageBar(context, "تم الحذف بنجاح");
        } else if (state is editUsedPhonePriceSuccess) {
          buildMessageBar(context, "تم تعديل السعر بنجاح");
        }
      },
      builder: (context, state) {
        if (state is EditUsedPhonesSuccess) {
          return EditUsedPhoneViewBody(phonesList: state.phonesList);
        } else if (state is EditUsedPhonesFailure) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
