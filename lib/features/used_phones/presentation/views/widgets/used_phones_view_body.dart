import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/utils/app_router.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/used_phones/domian/entities/used_phone_entities.dart';
import 'package:west_elbalad/features/used_phones/presentation/views/widgets/filter_list.dart';
import 'package:west_elbalad/features/home/presentation/manager/phones_filter/filter_cubit.dart';
import 'package:west_elbalad/features/used_phones/presentation/views/widgets/selected_phones.dart';

class UsedPhonesViewBody extends StatelessWidget {
  final List<UsedPhonesEntities> phones;
  const UsedPhonesViewBody({
    super.key,
    required this.phones,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterListCubit(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              title: "الهواتف المستعملة",
              backButton: false,
              icon: Iconsax.add5,
              onTap: () {
                GoRouter.of(context).push(AppRouter.kAddUsedPhoneView);
              },
            ),
            BlocBuilder<FilterListCubit, int>(
              builder: (context, state) {
                final orderedPhones = [
                  'all',
                  'oppo',
                  'samsung',
                  'realme',
                  'mi',
                  'vivo',
                  'nokia',
                  ...phones.map((phone) => phone.type).toList()
                ].toSet().toList();
                return Column(
                  children: [
                    Column(
                      children: [
                        //Filters
                        UsedPhonesFilters(
                          phones: phones,
                        ),
                        SizedBox(height: 8.0.h),
                        // Grid of phones
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: kHorizontalPadding),
                          child: () {
                            final list = orderedPhones[state] == 'all'
                                ? phones
                                : phones
                                    .where(
                                        (p) => p.type == orderedPhones[state])
                                    .toList();
                            if (list.isEmpty) {
                              return SizedBox(
                                height: 120.h,
                                child: Center(
                                  child: Text(
                                    orderedPhones[state] == 'all'
                                        ? 'لا توجد اجهزة مستعملة.'
                                        : 'لا توجد اجهزة مستعملة\nمن هذا النوع.',
                                    textAlign: TextAlign.center,
                                    style: AppStyles.semiBold16,
                                  ),
                                ),
                              );
                            }
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 16.h),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.h,
                                mainAxisExtent: 240.h,
                              ),
                              itemCount: list.length,
                              itemBuilder: (context, index) =>
                                  SelectedUsedPhones(phones: list[index]),
                            );
                          }(),
                        ),
                      ],
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
