import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/chose/custom_admin_view_card.dart';

class AdminViewBody extends StatelessWidget {
  const AdminViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'المشرف',
          backButton: false,
        ),
        SizedBox(height: 8.0.h),
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
                title: "عرض المستخدمين",
              ),
              CustomAdminViewCard(
                onPressed: () {},
                title: " عرض الطلبات ",
              ),
              CustomAdminViewCard(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kAddInStoreView);
                },
                title: "اضافة منتج ",
              ),
                        CustomAdminViewCard(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kRemoveFromStoreView);
                },
                title: "حذف منتج و تعديل في سعر",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
