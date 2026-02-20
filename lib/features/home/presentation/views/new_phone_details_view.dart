import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/home/data/model/phones_model.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/new_phone_details_view_body.dart';

import '../../../../core/functions/save_and_get_map_to_list_with_shared_pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_bottom_navigation_bar.dart';

class NewPhoneDetailsView extends StatelessWidget {
  const NewPhoneDetailsView({
    super.key,
    required this.phoneEntites,
  });

  final PhoneEntites phoneEntites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomAppBar(
          title: "تفاصيل المنتج",
        ),
      ),
      body: NewPhoneDetailsViewBody(phone: phoneEntites),
      bottomNavigationBar: SafeArea(
        child: CustomBottomNavigationBar(
          onPressedTwo: () {
            saveMapToListInSharedPref(
              key: kOrder,
              newMap: PhoneModel.fromEntity(phoneEntites).toMap(),
            );
            GoRouter.of(context).push(AppRouter.kShoppingCartView);
          },
          onPressedOne: () {
            Navigator.of(context).pop();
          },
          textTwo: "اضافة الي عربة التسوق",
          iconOne: Icons.home,
          iconTwo: Icons.shopping_cart,
        ),
      ),
    );
  }
}
