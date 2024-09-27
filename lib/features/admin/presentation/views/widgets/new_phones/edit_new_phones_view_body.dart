import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/new_phones/edit_new_phone_data_element.dart';

import '../../../../../../core/constants/app_consts.dart';

class EditNewPhonesViewBody extends StatelessWidget {
  const EditNewPhonesViewBody({super.key, required this.phonesList});
  final List phonesList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(title: "حذف منتج و تعديل في سعر"),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: kHorizontalPadding,
              left: kHorizontalPadding,
              top: 8.0.h,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kRadius24),
                topRight: Radius.circular(kRadius24),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: phonesList.length,
                itemBuilder: (context, index) {
                  final phone = phonesList[index];
                  return EditNewPhoneDataElement(phoneEntites: phone);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
