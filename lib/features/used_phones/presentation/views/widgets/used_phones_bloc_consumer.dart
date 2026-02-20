import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/core/widgets/custom_error_widget.dart';
import 'package:west_elbalad/core/widgets/phones_grid_skeleton.dart';
import 'package:west_elbalad/features/used_phones/presentation/views/widgets/used_phones_view_body.dart';
import 'package:west_elbalad/features/used_phones/presentation/manager/fetch_used_phone/fetch_used_phone_cubit.dart';

class UsedPhonesBlocConsumer extends StatelessWidget {
  const UsedPhonesBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchUsedPhoneCubit, FetchUsedPhoneState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchUsedPhoneDataSuccess) {
            return UsedPhonesViewBody(
              phones: state.usedPhoneList,
            );
          } else if (state is FetchUsedPhoneDataFailure) {
            return CustomErrorWidget(text: state.message);
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    title: 'الهواتف المستعملة',
                    backButton: false,
                    icon: Iconsax.add5,
                    onTap: () {},
                  ),
                  const PhonesGridSkeleton(),
                ],
              ),
            );
          }
        });
  }
}
