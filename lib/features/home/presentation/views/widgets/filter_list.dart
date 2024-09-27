import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/features/home/domian/entites/phone_entites.dart';
import 'package:west_elbalad/features/home/presentation/manager/phones_filter/filter_cubit.dart';
import 'package:west_elbalad/features/home/presentation/views/widgets/filter_element.dart';

class Filters extends StatelessWidget {
  final List<PhoneEntites> phones;
  const Filters({
    super.key,
    required this.phones,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0.h,
      child: Center(
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

            return Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: orderedPhones.length,
                    itemBuilder: (context, index) {
                      final phoneType = orderedPhones[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: index == orderedPhones.length - 1
                              ? 16.0.w
                              : 4.0.w,
                          right: index == 0 ? 12.0.w : 0.0.w,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(kRadius24),
                          onTap: () {
                            context.read<FilterListCubit>().selectIndex(index);
                          },
                          child: FilterElement(
                            text: phoneType,
                            color: state == index
                                ? AppColors.primary
                                : AppColors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
