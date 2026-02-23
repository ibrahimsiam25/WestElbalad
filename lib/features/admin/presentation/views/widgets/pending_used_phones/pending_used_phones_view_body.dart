import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/service/get_it_service.dart';
import 'package:west_elbalad/core/widgets/custom_app_bar.dart';
import 'package:west_elbalad/features/admin/presentation/manager/pending_used_phones/pending_used_phones_cubit.dart';
import 'package:west_elbalad/features/admin/presentation/views/widgets/pending_used_phones/pending_phone_data_element.dart';
import 'package:west_elbalad/features/used_phones/presentation/manager/fetch_used_phone/fetch_used_phone_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendingUsedPhonesViewBody extends StatelessWidget {
  const PendingUsedPhonesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PendingUsedPhonesCubit, PendingUsedPhonesState>(
      listener: (context, state) {
        if (state is PendingUsedPhoneApproved) {
          // Refresh the UsedPhones view so the approved phone appears immediately
          getIt<FetchUsedPhoneCubit>().fetchPhonesStreamData();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم قبول الإعلان بنجاح ✅'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is PendingUsedPhoneRejected) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم رفض وحذف الإعلان'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is PendingUsedPhonesFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 30.h),
          child: Column(
            children: [
              const CustomAppBar(title: 'موبايلات تنتظر القبول'),
              if (state is PendingUsedPhonesLoading)
                const Center(child: CircularProgressIndicator())
              else if (state is PendingUsedPhonesFailure)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (state is PendingUsedPhonesSuccess &&
                  state.phonesList.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.w),
                    child: const Text(
                      'لا توجد موبايلات تنتظر المراجعة',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              else if (state is PendingUsedPhonesSuccess)
                ...List.generate(state.phonesList.length, (i) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: kHorizontalPadding,
                      left: kHorizontalPadding,
                      bottom: kVerticalPadding,
                    ),
                    child: PendingPhoneDataElement(phone: state.phonesList[i]),
                  );
                }),
            ],
          ),
        );
      },
    );
  }
}
