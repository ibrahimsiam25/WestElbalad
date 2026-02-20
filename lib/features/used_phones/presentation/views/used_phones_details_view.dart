import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/used_phones/data/model/used_phone_model.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';
import 'package:west_elbalad/features/used_phones/presentation/views/widgets/used_phones_details_view_body.dart';

import '../../../../core/functions/save_and_get_map_to_list_with_shared_pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_bottom_navigation_bar.dart';

class UsedPhonesDetailsView extends StatelessWidget {
  const UsedPhonesDetailsView({
    super.key,
    required this.usedPhonesEntities,
  });

  final UsedPhonesEntities usedPhonesEntities;

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
      body: UsedPhonesDetailsViewBody(phone: usedPhonesEntities),
      bottomNavigationBar: SafeArea(
        child: CustomBottomNavigationBar(
          onPressedTwo: () {
            saveMapToListInSharedPref(
              key: kOrder,
              newMap: UsedPhoneModel.fromEntity(usedPhonesEntities).toMap(),
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
