import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/app_router.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/admin_view/custom_admin_view_card.dart';


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
                  title: "بيانات المستخدمين",
                ),
                CustomAdminViewCard(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kOrdersView);
                  },
                  title: "عرض الطلبات",
                ),
                CustomAdminViewCard(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kAddInStoreView);
                  },
                  title: "اضافة منتج",
                ),
                CustomAdminViewCard(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kNewPhonesView);
                  },
                  title: "المنتجات الجديدة",
                ),
                CustomAdminViewCard(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kUsedPhonesView);
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
