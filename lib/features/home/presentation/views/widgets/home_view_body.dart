import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/offer_list.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/filter_list.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/selected_phones.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:west_elbalad/features/home/presentation/manager/phones_filter/filter_cubit.dart';

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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomHomeAppBar(),
          OffersList(),
          SizedBox(height: 16.0.h),
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
                  //New phones
                  Column(
                    children: [
                      //Filters
                      Filters(
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
                                  .where((p) => p.type == orderedPhones[state])
                                  .toList();
                          if (list.isEmpty) {
                            return SizedBox(
                              height: 120.h,
                              child: Center(
                                child: Text(
                                  orderedPhones[state] == 'all'
                                      ? 'لا توجد اجهزة جديدة.'
                                      : 'لا توجد اجهزة جديدة\nمن هذا النوع.',
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
                                SelectedPhones(phones: list[index]),
                          );
                        }(),
                      ),
                    ],
                  ),
                  SizedBox(height: 160.0.h),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
