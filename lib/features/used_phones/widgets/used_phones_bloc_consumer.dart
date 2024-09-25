import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/widgets/custom_error_widget.dart';
import 'package:west_elbalad/core/widgets/custom_progress_indicator.dart';
import 'package:west_elbalad/features/home/presentation/manager/phones_data/phones_data_cubit.dart';
import 'package:west_elbalad/features/used_phones/widgets/used_phones_view_body.dart';

class UsedPhonesBlocConsumer extends StatelessWidget {
  const UsedPhonesBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhonesDataCubit, PhonesDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PhonesDataSuccess) {
            return UsedPhonesViewBody(
              phones: state.phonesList,
            );
          } else if (state is PhonesDataFailure) {
            return CustomErrorWidget(text: state.message);
          } else {
            return const CustomProgressIndicator();
          }
        });
  }
}
