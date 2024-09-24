import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/widgets/custom_error_widget.dart';
import 'package:west_elbalad/core/widgets/custom_progress_indicator.dart';
import 'package:west_elbalad/features/home/presentation/manager/phones_data/phones_data_cubit.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/home_view_body.dart';

class PhonesBlocConsumer extends StatelessWidget {
  const PhonesBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhonesDataCubit, PhonesDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PhonesDataSuccess) {
            return HomeViewBody(
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
