import 'package:flutter/material.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/edit_used_phones/edit_used_phone_data_element.dart';

import '../../../../../../core/constants/app_consts.dart';

class EditUsedPhoneViewBody extends StatelessWidget {
  const EditUsedPhoneViewBody({super.key, required this.phonesList});
  final List phonesList;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(title: "المنتجات المستعملة"),
          ...List.generate(phonesList.length, (index) {
            final phone = phonesList[index];
            return Padding(
              padding: EdgeInsets.only(
                right: kHorizontalPadding,
                left: kHorizontalPadding,
                bottom: kVerticalPadding,
              ),
              child: EditUsedPhoneDataElement(phoneEntites: phone),
            );
          })
        ],
      ),
    );
  }
}
