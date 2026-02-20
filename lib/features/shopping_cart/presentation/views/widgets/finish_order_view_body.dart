import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/service/shared_preferences_singleton.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';
import 'package:west_elbalad/core/widgets/custom_text_field.dart';
import 'package:west_elbalad/features/shopping_cart/presentation/manager/finish_order/finish_order_cubit.dart';

import '../../../../../../core/widgets/custom_number_field.dart';
import '../../../../../core/utils/app_styles.dart';

class FinishOrderViewBody extends StatefulWidget {
  const FinishOrderViewBody({
    super.key,
  });

  @override
  State<FinishOrderViewBody> createState() => _FinishOrderViewBodyState();
}

class _FinishOrderViewBodyState extends State<FinishOrderViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String userName, userPhone, userGovernorate, userLocation;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int totalPrice = SharedPref.getInt(kTotalPrice);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              Material(
                color: AppColors.white,
                elevation: 2,
                borderRadius: BorderRadius.circular(18.r),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long_rounded,
                          size: 20.r, color: AppColors.black),
                      SizedBox(width: 8.w),
                      Text(
                        "اجمالي سعر الطلب:  $totalPrice جنية",
                        style: AppStyles.semiBold16,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 14.0.h),
              CustomTextFormField(
                onSaved: (value) {
                  userName = value!;
                },
                hintText: "اسم العميل",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 8.0.h),
              CustomNumberField(
                onSaved: (value) {
                  userPhone = value!;
                },
                hintText: "رقم الهاتف",
              ),
              SizedBox(height: 8.0.h),
              CustomTextFormField(
                onSaved: (value) {
                  userGovernorate = value!;
                },
                hintText: "المحافظة",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 8.0.h),
              CustomTextFormField(
                onSaved: (value) {
                  userLocation = value!;
                },
                hintText: "العنوان",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 18.0.h),
              CustomButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    context.read<FinishOrderCubit>().finishOrder({
                      "userName": userName,
                      "userPhone": userPhone,
                      "userGovernorate": userGovernorate,
                      "userLocation": userLocation
                    });
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: " تأكيد الطلب ",
              ),
              SizedBox(height: 12.0.h),
            ],
          ),
        ),
      ),
    );
  }
}
