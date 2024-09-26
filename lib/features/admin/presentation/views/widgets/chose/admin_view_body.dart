import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/features/admin/presentation/views/add_in_store_view.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/chose/custom_admin_view_card.dart';

import '../../../../../../core/utils/app_router.dart';

class AdminViewBody extends StatelessWidget {
  const AdminViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
            ),
            child: Column(
              children: [
                CustomAdminViewCard(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kusersInformatinsView);
                  },
                  title: "المستخدمين",
                ),
                CustomAdminViewCard(
                  onPressed: () {},
                  title: "الطلبات",
                ),
                CustomAdminViewCard(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddInStoreView(),
                        settings: RouteSettings(arguments: 'جديد'),
                      ),
                    );
                  },
                  title: "اضافة منتج ",
                ),
                CustomAdminViewCard(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kRemoveFromStoreView);
                  },
                  title: "المنتجات",
                ),
                CustomAdminViewCard(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kRemoveFromStoreView);
                  },
                  title: "المنتجات المستعملة",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
