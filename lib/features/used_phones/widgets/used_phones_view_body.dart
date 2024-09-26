import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/used_phones/widgets/used_phones_appbar.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/filter_list.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/selected_phones.dart';
import 'package:west_elbalad/features/home/presentation/manager/phones_filter/filter_cubit.dart';

class UsedPhonesViewBody extends StatelessWidget {
  final List<PhoneEntites> phones;
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
            //App bar
            HomeAppbar(),
            SizedBox(height: 16.0.h),
            BlocBuilder<FilterListCubit, int>(
              builder: (context, state) {
                final orderedPhones = [
                  'all',
                  'samsung',
                  'oppo',
                  'realme',
                  'mi',
                  'nokia',
                  ...phones.map((phone) => phone.type).toList()
                ].toSet().toList();

                final usedPhones = phones
                    .where(
                      (phone) =>
                          phone.type == orderedPhones[state] &&
                          (phone.status == 'used' || phone.status == 'مستعمل'),
                    )
                    .map((phone) => SelectedPhones(phones: phone))
                    .toList();
                return Column(
                  children: [
                    //Used phones
                    Column(
                      children: [
                        //Filters
                        Filters(
                          phones: phones,
                        ),
                        SizedBox(height: 8.0.h),
                        //Selected phones
                        Wrap(
                          spacing: 16.0.w,
                          children: orderedPhones[state] == 'all'
                              ? [
                                  ...phones
                                      .where(
                                        (phone) => (phone.status == 'مستعمل' ||
                                            phone.status == 'used'),
                                      )
                                      .map((phone) =>
                                          SelectedPhones(phones: phone)),
                                  //For alighnment and refresh
                                  if (usedPhones.length == 1)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: kHorizontalPadding),
                                      child: SizedBox(
                                        width: 128.0.w,
                                      ),
                                    ),
                                ]
                              : [
                                  ...usedPhones,
                                  //For alighnment and refresh
                                  if (usedPhones.length == 1)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: kHorizontalPadding),
                                      child: SizedBox(
                                        width: 128.0.w,
                                      ),
                                    ),
                                  //Empty
                                  if (usedPhones.isEmpty)
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: kHorizontalPadding),
                                      child: SizedBox(
                                        width: 200.0.w,
                                        height: 128.0.h,
                                        child: Center(
                                          child: Text(
                                            'لا توجد اجهزة مستعملة\nمن هذا النوع.',
                                            textAlign: TextAlign.center,
                                            style: AppStyles.semiBold16,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
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
