import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/functions/build_message_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/new_phones/edit_new_phones_view_body.dart';

import '../../../manager/new_phones/new_phones_cubit.dart';

class EditNewPhonesViewBodyBlocConsumer extends StatelessWidget {
  const EditNewPhonesViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPhonesCubit, NewPhonesState>(
      listener: (context, state) {
        if (state is removeNewPhoneSuccess) {
          buildMessageBar(context, "تم الحذف بنجاح");
        } else if (state is editNewPhonePriceSuccess) {
          buildMessageBar(context, "تم تعديل السعر بنجاح");
        }
      },
      builder: (context, state) {
        if (state is NewPhonesSuccess) {
          return EditNewPhonesViewBody(phonesList: state.phonesList);
        } else if (state is NewPhonesFailure) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
