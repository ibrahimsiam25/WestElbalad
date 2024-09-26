import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:west_elbalad/core/constants/app_colors.dart';
import 'package:west_elbalad/core/constants/app_consts.dart';
import 'package:west_elbalad/core/functions/build_message_bar.dart';
import 'package:west_elbalad/core/widgets/custom_button.dart';
import 'package:west_elbalad/core/widgets/custom_text_field.dart';

import '../../../../../../core/widgets/custom_number_field.dart';
import '../../../manager/add_in_store/edit_in_store_cubit.dart';
import '../../../manager/image_picker/image_picker_cubit.dart';

class AddInStoreViewBody extends StatefulWidget {
  const AddInStoreViewBody({
    super.key,
  });

  @override
  State<AddInStoreViewBody> createState() => _AddInStoreViewBodyState();
}

class _AddInStoreViewBodyState extends State<AddInStoreViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String phoneType,
      phoneStatus,
      phoneName,
      phoneDescription,
      phonePrice,
      userName,
      userPhone,
      userLocation;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final String selectedPhoneStatus =
        ModalRoute.of(context)!.settings.arguments as String;
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              SizedBox(height: 16.0.h),
              CustomTextFormField(
                onSaved: (value) {
                  phoneType = value!;
                },
                hintText: "اسم الشركة",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 4.0.h),
              CustomTextFormField(
                onSaved: (value) {
                  phoneName = value!;
                },
                hintText: "نوع الهاتف",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 4.0.h),
              CustomNumberField(
                onSaved: (value) {
                  phonePrice = value!;
                },
                hintText: "سعر الهاتف",
              ),
              SizedBox(height: 4.0.h),
              CustomTextFormField(
                onSaved: (value) {
                  phoneDescription = value!;
                },
                hintText: "موصفات الهاتف",
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 4.0.h),
              if (selectedPhoneStatus == 'مستعمل')
                Column(
                  children: [
                    CustomTextFormField(
                      onSaved: (value) {
                        userName = value!;
                      },
                      hintText: "اسم المستخدم",
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(height: 4.0.h),
                    CustomTextFormField(
                      onSaved: (value) {
                        userPhone = value!;
                      },
                      hintText: "رقم الهاتف",
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(height: 4.0.h),
                    CustomTextFormField(
                      onSaved: (value) {
                        userLocation = value!;
                      },
                      hintText: "العنوان",
                      textInputType: TextInputType.text,
                    ),
                  ],
                ),
              SizedBox(height: 12.0.h),
              CustomButton(
                backgroundColor: AppColors.lightGreen,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (context.read<ImagePickerCubit>().image != null) {
                      context.read<AddInStoreCubit>().uploadPhoneData(
                          context.read<ImagePickerCubit>().image, {
                        "phoneType": phoneType,
                        "phoneStatus":
                            selectedPhoneStatus == 'مستعمل' ? 'مستعمل' : 'جديد',
                        "phoneName": phoneName,
                        "phoneDescription": phoneDescription,
                        "phonePrice": phonePrice,
                        "userName": selectedPhoneStatus == 'مستعمل'
                            ? userName
                            : "وسط البلد",
                        "userPhone": selectedPhoneStatus == 'مستعمل'
                            ? userPhone
                            : "رقم وسط البلد",
                        "userLocation": selectedPhoneStatus == 'مستعمل'
                            ? userLocation
                            : "عنوان وسط البلد",
                      });
                    } else {
                      buildMessageBar(context, "يجب تحديد صورة للهاتف");
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                text: "اضافة الهاتف",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
