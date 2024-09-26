import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import '../../../../core/widgets/custom_bottom_navigation_bar.dart';
import 'package:west_elbalad/features/home/data/model/phones_model.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import '../../../../core/functions/save_and_get_map_to_list_with_shared_pref.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/phone_details_view_body.dart';

class PhoneDetailsView extends StatelessWidget {
  const PhoneDetailsView({super.key, required this.phoneEntites});

  final PhoneEntites phoneEntites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhoneDetailsViewBody(phone: phoneEntites),
      bottomNavigationBar: CustomBottomNavigationBar(
        onPressedTwo: () {
          saveMapToListInSharedPref(
              key: kOrder, newMap: PhoneModel.fromEntity(phoneEntites).toMap());
          GoRouter.of(context).push(AppRouter.kShoppingCartView);
        },
        onPressedOne: () {
          Navigator.of(context).pop();
        },
        textTwo: "اضافة الي عربة التسوق",
        iconOne: Icons.home,
        iconTwo: Icons.shopping_cart,
      ),
    );
  }
}
