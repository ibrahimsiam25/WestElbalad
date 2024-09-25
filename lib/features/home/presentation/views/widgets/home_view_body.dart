import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_assets.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:west_elbalad/core/widgets/custom_title.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/home/presentation/manager/phones_filter/filter_cubit.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/filter_list.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/selected_phones.dart';

class HomeViewBody extends StatelessWidget {
  final List<PhoneEntites> phones;
  const HomeViewBody({
    super.key,
    required this.phones,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterListCubit(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CustomHomeAppBar()),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.27,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding, vertical: 16.0),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: AspectRatio(
                        aspectRatio: 1321 / 736,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(AppAssets.offer1)),
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: AspectRatio(
                        aspectRatio: 1321 / 736,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(AppAssets.offer2)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<FilterListCubit, int>(
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
                final selectedPhones = phones
                    .where(
                      (phone) =>
                          phone.type == orderedPhones[state] &&
                          (phone.status == 'new' || phone.status == 'جديد'),
                    )
                    .map((phone) => SelectedPhones(phones: phone))
                    .toList();
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
                    //New phones
                    Column(
                      children: [
                        //Filters
                        Filters(
                          phones: phones,
                        ),
                        SizedBox(height: 16.0.h),
                        CustomTitle(title: 'الأجهزة الجديدة'),
                        SizedBox(height: 12.0.h),
                        //Selected phones
                        Wrap(
                          spacing: 16.0.w,
                          children: orderedPhones[state] == 'all'
                              ? [
                                  ...phones
                                      .where(
                                        (phone) => (phone.status == 'جديد' ||
                                            phone.status == 'new'),
                                      )
                                      .map((phone) =>
                                          SelectedPhones(phones: phone)),
                                  //For alighnment and refresh
                                  if (selectedPhones.length == 1)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: kHorizontalPadding),
                                      child: SizedBox(
                                        width: 128.0.w,
                                      ),
                                    ),
                                ]
                              : [
                                  ...selectedPhones,
                                  //For alighnment and refresh
                                  if (selectedPhones.length == 1)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: kHorizontalPadding),
                                      child: SizedBox(
                                        width: 128.0.w,
                                      ),
                                    ),

                                  //Empty
                                  if (selectedPhones.isEmpty)
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: kHorizontalPadding),
                                      child: SizedBox(
                                        width: 200.0.w,
                                        height: 128.0.h,
                                        child: Center(
                                          child: Text(
                                            'لا توجد اجهزة جديدة\nمن هذا النوع.',
                                            textAlign: TextAlign.center,
                                            style: AppStyles.semiBold16,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0.h),
                    //Used phones
                    Column(
                      children: [
                        CustomTitle(title: 'الأجهزة المستعملة'),
                        SizedBox(height: 12.0.h),
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
            ),
          )
        ],
      ),
    );
  }
}
