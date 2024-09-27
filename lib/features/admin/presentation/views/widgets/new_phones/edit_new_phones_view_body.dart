import 'package:flutter/material.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/new_phones/edit_new_phone_data_element.dart';

class EditNewPhonesViewBody extends StatelessWidget {
  const EditNewPhonesViewBody({super.key, required this.phonesList});
  final List phonesList;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(title: "المنتجات الجديدة"),
          ...List.generate(phonesList.length, (index) {
            final phone = phonesList[index];
            return Padding(
              padding: EdgeInsets.only(
                right: kHorizontalPadding,
                left: kHorizontalPadding,
                bottom: kVerticalPadding,
              ),
              child: EditNewPhoneDataElement(phoneEntites: phone),
            );
          }),
        ],
      ),
    );
  }
}
