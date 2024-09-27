import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/domain/entities/user_informations_entites.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/users_informations/user_data_element.dart';

class UsersInformationsViewBody extends StatelessWidget {
  const UsersInformationsViewBody(
      {super.key, required this.usersInformationList});
  final List<UserInformationsEntity> usersInformationList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'عرض المستخدمين',
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: kHorizontalPadding, vertical: 8.0.h),
            itemCount: usersInformationList.length,
            itemBuilder: (context, index) {
              final user = usersInformationList[index];
              return UserDataElement(user: user);
            },
          ),
        ),
      ],
    );
  }
}
