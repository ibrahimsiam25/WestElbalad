import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/filter_list.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/home_appbar.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/selected_phones.dart';
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            //AppBar
            HomeAppbar(), //Banner
            //حط الاعلان هنا يعم ابراهيم

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
                final selectedPhones = phones
                    .where(
                      (phone) => phone.type == orderedPhones[state],
                    )
                    .map((phone) => SelectedPhones(phones: phone))
                    .toList();
                return Column(
                  children: [
                    //Filters
                    Filters(
                      phones: phones,
                    ),
                    SizedBox(height: 16.0.h),
                    //Selected phones
                    Wrap(
                      spacing: 16.0.w,
                      children: orderedPhones[state] == 'all'
                          ? [
                              ...phones.map(
                                  (phone) => SelectedPhones(phones: phone)),
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
                                    height: 300.0.w,
                                  ),
                                ),
                            ],
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
